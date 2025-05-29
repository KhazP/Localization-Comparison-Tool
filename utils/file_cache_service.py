import os
import threading
import io
import time
from pathlib import Path
from typing import Dict, Optional, Callable, Tuple, List
import logging
from .logger_service import logger_service # Changed to relative
from itertools import takewhile, repeat

logger = logger_service.get_logger()

class FileCacheService:
    """
    Service for optimized file operations with caching support.
    
    Features:
    - File content caching to reduce disk access
    - Streaming large file reading for memory efficiency
    - Async line counting for UI responsiveness
    - File preview generation
    - Smart cache invalidation based on file modification time
    """
    
    _instance = None
    _lock = threading.RLock()
    
    def __new__(cls):
        with cls._lock:
            if cls._instance is None:
                cls._instance = super(FileCacheService, cls).__new__(cls)
                cls._instance._initialized = False
            return cls._instance
    
    def __init__(self):
        with self._lock:
            if self._initialized:
                return
                
            self._initialized = True
            self._file_cache = {}  # filepath -> (content, mtime, line_count)
            self._max_cache_size = 100  # Max number of files to cache
            self._max_cache_age = 300  # Cache validity in seconds
            self._large_file_threshold = 10 * 1024 * 1024  # 10 MB
            self._preview_line_count = 5  # Number of lines in preview
            logger.info("FileCacheService initialized")
    
    def _is_cache_valid(self, filepath: str) -> bool:
        """Check if cached file content is still valid"""
        if filepath not in self._file_cache:
            return False
            
        cached_mtime = self._file_cache[filepath][1]
        current_mtime = os.path.getmtime(filepath)
        
        # Check if file was modified since caching
        if current_mtime != cached_mtime:
            return False
        
        # Check if cache is too old
        cache_age = time.time() - self._file_cache[filepath][3] if len(self._file_cache[filepath]) > 3 else 0
        if cache_age > self._max_cache_age:
            return False
            
        return True
    
    def _manage_cache_size(self):
        """Remove oldest entries if cache exceeds max size"""
        if len(self._file_cache) <= self._max_cache_size:
            return
            
        # Sort by access time (oldest first)
        sorted_items = sorted(
            self._file_cache.items(),
            key=lambda x: x[1][3] if len(x[1]) > 3 else 0
        )
        
        # Remove oldest entries
        to_remove = sorted_items[:len(sorted_items) - self._max_cache_size]
        for filepath, _ in to_remove:
            del self._file_cache[filepath]
    
    def read_file(self, filepath: str) -> str:
        """
        Read file content with caching for improved performance.
        
        For large files, content is not cached to conserve memory.
        
        Args:
            filepath: Path to the file to read
            
        Returns:
            File content as string
        """
        with self._lock:
            # Check cache first
            if self._is_cache_valid(filepath):
                self._file_cache[filepath] = (
                    self._file_cache[filepath][0],  # content
                    self._file_cache[filepath][1],  # mtime
                    self._file_cache[filepath][2],  # line count
                    time.time()                    # access time
                )
                return self._file_cache[filepath][0]
            
            # Get file size to determine reading strategy
            file_size = os.path.getsize(filepath)
            
            if file_size > self._large_file_threshold:
                # For large files, read directly and don't cache content
                logger.info(f"Reading large file without caching: {filepath}")
                with open(filepath, 'r', encoding='utf-8', errors='replace') as f:
                    content = f.read()
                return content
            
            # For smaller files, read and cache
            try:
                with open(filepath, 'r', encoding='utf-8') as f:
                    content = f.read()
            except UnicodeDecodeError:
                # Fall back to latin-1 if UTF-8 fails
                with open(filepath, 'r', encoding='latin-1') as f:
                    content = f.read()
            
            mtime = os.path.getmtime(filepath)
            line_count = content.count('\n') + 1 if content else 0
            
            # Cache the content
            self._file_cache[filepath] = (content, mtime, line_count, time.time())
            self._manage_cache_size()
            
            return content
    
    def read_file_stream(self, filepath: str, chunk_size=8192):
        """
        Stream read a file in chunks to handle large files efficiently.
        Returns a generator that yields chunks of the file.
        
        Args:
            filepath: Path to the file to read
            chunk_size: Size of chunks to read in bytes
            
        Yields:
            Chunks of file content
        """
        try:
            with open(filepath, 'r', encoding='utf-8', errors='replace') as f:
                while True:
                    chunk = f.read(chunk_size)
                    if not chunk:
                        break
                    yield chunk
        except UnicodeDecodeError:
            # Fall back to latin-1 if UTF-8 fails
            with open(filepath, 'r', encoding='latin-1') as f:
                while True:
                    chunk = f.read(chunk_size)
                    if not chunk:
                        break
                    yield chunk
    
    def read_file_lines_stream(self, filepath: str):
        """
        Stream read a file line by line to handle large files efficiently.
        
        Args:
            filepath: Path to the file to read
            
        Yields:
            Lines of file content
        """
        try:
            with open(filepath, 'r', encoding='utf-8', errors='replace') as f:
                for line in f:
                    yield line
        except UnicodeDecodeError:
            # Fall back to latin-1 if UTF-8 fails
            with open(filepath, 'r', encoding='latin-1') as f:
                for line in f:
                    yield line
    
    def count_lines(self, filepath: str) -> int:
        """
        Count lines in a file efficiently, using cache when available.
        
        Args:
            filepath: Path to the file
            
        Returns:
            Number of lines in the file
        """
        with self._lock:
            # Check cache first
            if self._is_cache_valid(filepath):
                self._file_cache[filepath] = (
                    self._file_cache[filepath][0],  # content 
                    self._file_cache[filepath][1],  # mtime
                    self._file_cache[filepath][2],  # line count
                    time.time()                    # access time
                )
                return self._file_cache[filepath][2]
            
            # Get file size
            file_size = os.path.getsize(filepath)
            
            if file_size > self._large_file_threshold:
                # For large files, count lines by reading line by line
                logger.info(f"Counting lines in large file: {filepath}")
                count = 0
                with open(filepath, 'rb') as f:
                    # Efficient line counting using bytecount
                    bufgen = takewhile(lambda x: x, (f.raw.read(1024*1024) for _ in repeat(None)))
                    count = sum(buf.count(b'\n') for buf in bufgen)
                return count + 1  # Add 1 for the last line if not ended with newline
            
            # For smaller files, read and cache
            try:
                with open(filepath, 'r', encoding='utf-8') as f:
                    content = f.read()
            except UnicodeDecodeError:
                # Fall back to latin-1 if UTF-8 fails
                with open(filepath, 'r', encoding='latin-1') as f:
                    content = f.read()
            
            mtime = os.path.getmtime(filepath)
            line_count = content.count('\n') + 1 if content else 0
            
            # Cache the content
            self._file_cache[filepath] = (content, mtime, line_count, time.time())
            self._manage_cache_size()
            
            return line_count
    
    def count_lines_async(self, filepath: str, callback: Callable[[int, Optional[str]], None]):
        """
        Count lines asynchronously to avoid blocking the UI.
        
        Args:
            filepath: Path to the file
            callback: Function to call with result (line_count, error_message)
        """
        def _work():
            try:
                line_count = self.count_lines(filepath)
                callback(line_count, None)
            except Exception as e:
                logger.error(f"Error counting lines in {filepath}: {str(e)}")
                callback(0, str(e))
        
        # Run in a separate thread to avoid blocking
        thread = threading.Thread(target=_work)
        thread.daemon = True
        thread.start()
    
    def preview_file(self, filepath: str, max_lines: int = 5) -> str:
        """
        Get a preview of a file (first few lines).
        
        Args:
            filepath: Path to the file
            max_lines: Maximum number of lines to include
            
        Returns:
            Preview text of the file
        """
        preview_lines = []
        
        try:
            # Efficiently read just the number of lines needed for preview
            with open(filepath, 'r', encoding='utf-8', errors='replace') as f:
                for i, line in enumerate(f):
                    if i >= max_lines:
                        break
                    preview_lines.append(line.rstrip())
        except UnicodeDecodeError:
            # Fall back to latin-1 if UTF-8 fails
            with open(filepath, 'r', encoding='latin-1') as f:
                for i, line in enumerate(f):
                    if i >= max_lines:
                        break
                    preview_lines.append(line.rstrip())
        except Exception as e:
            logger.error(f"Error reading file preview: {str(e)}")
            return f"Error reading file: {str(e)}"
        
        preview_text = '\n'.join(preview_lines)
        if len(preview_lines) >= max_lines:
            preview_text += "\n..."
            
        return preview_text
    
    def clear_cache(self):
        """Clear the entire file cache"""
        with self._lock:
            self._file_cache.clear()
            logger.info("File cache cleared")
    
    def remove_from_cache(self, filepath: str):
        """Remove a specific file from cache"""
        with self._lock:
            if filepath in self._file_cache:
                del self._file_cache[filepath]
                logger.debug(f"Cache entry removed for {filepath}")
    
    def set_max_cache_size(self, size: int):
        """Set maximum number of files to cache"""
        with self._lock:
            self._max_cache_size = size
            self._manage_cache_size()
            logger.debug(f"Cache size limit set to {size}")
    
    def set_max_cache_age(self, age: int):
        """Set maximum age for cached entries in seconds"""
        with self._lock:
            self._max_cache_age = age
            logger.debug(f"Cache age limit set to {age} seconds")
    
    def set_large_file_threshold(self, size: int):
        """Set size threshold for large files in bytes"""
        with self._lock:
            self._large_file_threshold = size
            logger.debug(f"Large file threshold set to {size} bytes")
    
    def get_cache_stats(self) -> Dict:
        """Get statistics about the current cache state"""
        with self._lock:
            stats = {
                'cache_size': len(self._file_cache),
                'max_cache_size': self._max_cache_size,
                'max_cache_age': self._max_cache_age,
                'large_file_threshold': self._large_file_threshold,
            }
            logger.debug(f"Cache stats: {stats}")
            return stats


# Global instance
file_cache_service = FileCacheService()