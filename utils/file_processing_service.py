import threading
import asyncio
import time
import os  # Add missing import for os.walk
import atexit
from typing import Dict, Optional, Callable, Any
from pathlib import Path
import logging
from utils.logger_service import logger_service
from utils.file_cache_service import file_cache_service
import GUI.logic as logic

logger = logger_service.get_logger()

class FileProcessingService:
    """
    Service for handling file processing operations asynchronously.
    Uses the FileCacheService for optimized file access.
    """
    
    _instance = None
    _lock = threading.RLock()
    
    def __new__(cls):
        with cls._lock:
            if cls._instance is None:
                cls._instance = super(FileProcessingService, cls).__new__(cls)
                cls._instance._initialized = False
            return cls._instance
    
    def __init__(self):
        with self._lock:
            if self._initialized:
                return
                
            self._initialized = True
            self._workers = {}  # Task ID -> (thread, status)
            self._results = {}  # Task ID -> result
            self._task_counter = 0
            logger.info("FileProcessingService initialized")
            
            # Register cleanup on exit
            atexit.register(self._cleanup)
    
    def _get_next_task_id(self) -> str:
        """Generate a unique task ID"""
        with self._lock:
            self._task_counter += 1
            return f"task_{self._task_counter}"
    
    def parse_file_async(self, file_path: str, progress_callback: Optional[Callable] = None) -> str:
        """
        Parse a localization file asynchronously.
        
        Args:
            file_path: Path to the file
            progress_callback: Function to call with progress updates (0-1)
            
        Returns:
            Task ID that can be used to retrieve the result later
        """
        task_id = self._get_next_task_id()
        
        def _work():
            try:
                # Update progress to indicate we're starting
                if progress_callback:
                    progress_callback(0.1)
                
                # Use FileCacheService to read the file
                content = file_cache_service.read_file(file_path)
                
                if progress_callback:
                    progress_callback(0.4)
                
                # Parse the content based on file extension
                ext = Path(file_path).suffix.lower()
                result = logic.parse_content_by_ext(content, ext)
                
                if progress_callback:
                    progress_callback(0.9)
                
                # Store the result
                with self._lock:
                    self._results[task_id] = {
                        'status': 'completed',
                        'result': result,
                        'error': None,
                        'timestamp': time.time()
                    }
                
                if progress_callback:
                    progress_callback(1.0)
                
            except Exception as e:
                logger.error(f"Error parsing file {file_path}: {str(e)}")
                # Store the error
                with self._lock:
                    self._results[task_id] = {
                        'status': 'error',
                        'result': None,
                        'error': str(e),
                        'timestamp': time.time()
                    }
                
                if progress_callback:
                    progress_callback(1.0)  # Signal completion even on error
                
            finally:
                # Clean up
                with self._lock:
                    if task_id in self._workers:
                        del self._workers[task_id]
        
        # Start the worker thread
        thread = threading.Thread(target=_work)
        thread.daemon = True
        
        with self._lock:
            self._workers[task_id] = (thread, 'running')
            self._results[task_id] = {
                'status': 'running',
                'result': None,
                'error': None,
                'timestamp': time.time()
            }
        
        thread.start()
        return task_id
    
    def compare_files_async(self, source_path: str, target_path: str, 
                           config: dict, progress_callback: Optional[Callable] = None) -> str:
        """
        Compare two localization files asynchronously.
        
        Args:
            source_path: Path to the source file
            target_path: Path to the target file
            config: Configuration dictionary for comparison options
            progress_callback: Function to call with progress updates (0-1)
            
        Returns:
            Task ID that can be used to retrieve the result later
        """
        task_id = self._get_next_task_id()
        
        def _work():
            try:
                # Update progress to indicate we're starting
                if progress_callback:
                    progress_callback(0.1)
                
                # Use FileCacheService to read both files
                source_content = file_cache_service.read_file(source_path)
                if progress_callback:
                    progress_callback(0.3)
                    
                target_content = file_cache_service.read_file(target_path)
                if progress_callback:
                    progress_callback(0.5)
                
                # Parse the contents based on file extensions
                ext_source = Path(source_path).suffix.lower()
                ext_target = Path(target_path).suffix.lower()
                
                source_result = logic.parse_content_by_ext(source_content, ext_source)
                if progress_callback:
                    progress_callback(0.7)
                    
                target_result = logic.parse_content_by_ext(target_content, ext_target)
                if progress_callback:
                    progress_callback(0.8)
                
                # Extract translations and line numbers
                if isinstance(source_result, dict) and "translations" in source_result:
                    source_dict = source_result["translations"]
                    source_lines = source_result.get("line_numbers", {})
                else:
                    source_dict = source_result
                    source_lines = {}
                    
                if isinstance(target_result, dict) and "translations" in target_result:
                    target_dict = target_result["translations"]
                    target_lines = target_result.get("line_numbers", {})
                else:
                    target_dict = target_result
                    target_lines = {}
                
                # Prepare comparison options
                mt_settings = {
                    'enabled': config.get("mt_enabled", False),
                    'api_key': config.get("mt_api_key", ""),
                    'source_lang': config.get("mt_source_lang", "en"),
                    'target_lang': config.get("mt_target_lang", "")
                }
                
                # Perform comparison
                comparison_result = logic.compare_translations(
                    target_dict,
                    source_dict,
                    ignore_case=config.get("ignore_case", False),
                    ignore_whitespace=config.get("ignore_whitespace", False),
                    is_gui=True,
                    include_summary=False,
                    compare_values=config.get("compare_values", True),
                    ignore_patterns=config.get("ignore_patterns", []),
                    log_missing_keys=config.get("log_missing_strings", False),
                    auto_fill_missing=config.get("auto_fill_missing", False),
                    mt_settings=mt_settings
                )
                
                # Calculate statistics
                missing_keys_set = set(source_dict.keys()) - set(target_dict.keys())
                obsolete_keys_set = set(target_dict.keys()) - set(source_dict.keys())
                
                total_keys = len(source_dict)
                missing_keys = len(missing_keys_set)
                obsolete_keys = len(obsolete_keys_set)
                
                # Store the complete result
                with self._lock:
                    self._results[task_id] = {
                        'status': 'completed',
                        'result': {
                            'comparison': comparison_result,
                            'source_dict': source_dict,
                            'target_dict': target_dict,
                            'source_lines': source_lines,
                            'target_lines': target_lines,
                            'stats': {
                                'total_keys': total_keys,
                                'missing_keys': missing_keys,
                                'obsolete_keys': obsolete_keys
                            }
                        },
                        'error': None,
                        'timestamp': time.time()
                    }
                
                if progress_callback:
                    progress_callback(1.0)
                
            except Exception as e:
                logger.error(f"Error comparing files {source_path} and {target_path}: {str(e)}")
                # Store the error
                with self._lock:
                    self._results[task_id] = {
                        'status': 'error',
                        'result': None,
                        'error': str(e),
                        'timestamp': time.time()
                    }
                
                if progress_callback:
                    progress_callback(1.0)  # Signal completion even on error
                
            finally:
                # Clean up worker and update status
                with self._lock:
                    if task_id in self._workers:
                        del self._workers[task_id]
                        logger.debug(f"Removed worker for task {task_id}")
        
        # Start the worker thread
        thread = threading.Thread(target=_work)
        thread.daemon = True
        
        with self._lock:
            self._workers[task_id] = (thread, 'running')
            self._results[task_id] = {
                'status': 'running',
                'result': None,
                'error': None,
                'timestamp': time.time()
            }
        
        thread.start()
        return task_id
    
    def compare_directories_async(self, source_dir: str, target_dir: str, 
                                config: dict, progress_callback: Optional[Callable] = None) -> str:
        """
        Compare two directories of localization files asynchronously.
        
        Args:
            source_dir: Path to the source directory
            target_dir: Path to the target directory
            config: Configuration dictionary for comparison options
            progress_callback: Function to call with progress updates (0-1)
            
        Returns:
            Task ID that can be used to retrieve the result later
        """
        task_id = self._get_next_task_id()
        
        def _work():
            try:
                # Update progress to indicate we're starting
                if progress_callback:
                    progress_callback(0.05)
                
                # Get all files in both directories
                source_files = {}
                target_files = {}
                
                for root, _, files in os.walk(source_dir):
                    for file in files:
                        file_path = os.path.join(root, file)
                        rel_path = os.path.relpath(file_path, source_dir)
                        ext = Path(file).suffix.lower()
                        if ext in logic.SUPPORTED_FORMATS:
                            source_files[rel_path] = file_path
                
                for root, _, files in os.walk(target_dir):
                    for file in files:
                        file_path = os.path.join(root, file)
                        rel_path = os.path.relpath(file_path, target_dir)
                        ext = Path(file).suffix.lower()
                        if ext in logic.SUPPORTED_FORMATS:
                            target_files[rel_path] = file_path
                
                if progress_callback:
                    progress_callback(0.1)
                
                # Find common files
                common_files = sorted(set(source_files.keys()) & set(target_files.keys()))
                
                if not common_files:
                    with self._lock:
                        self._results[task_id] = {
                            'status': 'completed',
                            'result': {
                                'error': "No matching files found in both directories",
                                'file_results': {},
                                'stats': {
                                    'total_files': 0,
                                    'total_missing': 0,
                                    'total_obsolete': 0
                                }
                            },
                            'error': None,
                            'timestamp': time.time()
                        }
                    if progress_callback:
                        progress_callback(1.0)
                    return
                
                # Process each file pair
                file_results = {}
                total_missing = 0
                total_obsolete = 0
                
                # Calculate progress increment per file
                progress_per_file = 0.8 / len(common_files)  # Reserve 20% for initialization and cleanup
                progress_base = 0.1
                
                for i, filename in enumerate(common_files):
                    source_path = source_files[filename]
                    target_path = target_files[filename]
                    
                    try:
                        # Read and compare files using cache service
                        source_content = file_cache_service.read_file(source_path)
                        target_content = file_cache_service.read_file(target_path)
                        
                        source_dict = logic.parse_content_by_ext(source_content, Path(source_path).suffix)
                        target_dict = logic.parse_content_by_ext(target_content, Path(target_path).suffix)
                        
                        # Extract translations if necessary
                        if isinstance(source_dict, dict) and "translations" in source_dict:
                            source_dict = source_dict["translations"]
                        if isinstance(target_dict, dict) and "translations" in target_dict:
                            target_dict = target_dict["translations"]
                        
                        # Prepare comparison options
                        mt_settings = {
                            'enabled': config.get("mt_enabled", False),
                            'api_key': config.get("mt_api_key", ""),
                            'source_lang': config.get("mt_source_lang", "en"),
                            'target_lang': config.get("mt_target_lang", "")
                        }
                        
                        comparison_result = logic.compare_translations(
                            target_dict,
                            source_dict,
                            ignore_case=config.get("ignore_case", False),
                            ignore_whitespace=config.get("ignore_whitespace", False),
                            is_gui=True,
                            include_summary=False,
                            compare_values=config.get("compare_values", True),
                            ignore_patterns=config.get("ignore_patterns", []),
                            log_missing_keys=config.get("log_missing_strings", False),
                            auto_fill_missing=config.get("auto_fill_missing", False),
                            mt_settings=mt_settings
                        )
                        
                        # Calculate file statistics
                        file_missing = len(set(source_dict.keys()) - set(target_dict.keys()))
                        file_obsolete = len(set(target_dict.keys()) - set(source_dict.keys()))
                        
                        total_missing += file_missing
                        total_obsolete += file_obsolete
                        
                        # Store file result
                        file_results[filename] = {
                            'comparison': comparison_result,
                            'source_dict': source_dict,
                            'target_dict': target_dict,
                            'stats': {
                                'total_keys': len(source_dict),
                                'missing_keys': file_missing,
                                'obsolete_keys': file_obsolete
                            }
                        }
                        
                    except Exception as e:
                        logger.error(f"Error comparing file pair {filename}: {str(e)}")
                        file_results[filename] = {
                            'error': str(e),
                            'stats': {
                                'total_keys': 0,
                                'missing_keys': 0,
                                'obsolete_keys': 0
                            }
                        }
                    
                    # Update progress for this file
                    if progress_callback:
                        current_progress = progress_base + (i + 1) * progress_per_file
                        progress_callback(min(0.95, current_progress))  # Keep some progress for final steps
                
                # Store the complete result
                with self._lock:
                    self._results[task_id] = {
                        'status': 'completed',
                        'result': {
                            'file_results': file_results,
                            'stats': {
                                'total_files': len(common_files),
                                'total_missing': total_missing,
                                'total_obsolete': total_obsolete
                            }
                        },
                        'error': None,
                        'timestamp': time.time()
                    }
                
                if progress_callback:
                    progress_callback(1.0)
                
            except Exception as e:
                logger.error(f"Error in directory comparison: {str(e)}")
                # Store the error
                with self._lock:
                    self._results[task_id] = {
                        'status': 'error',
                        'result': None,
                        'error': str(e),
                        'timestamp': time.time()
                    }
                
                if progress_callback:
                    progress_callback(1.0)  # Signal completion even on error
                
            finally:
                # Clean up worker and update status
                with self._lock:
                    if task_id in self._workers:
                        del self._workers[task_id]
                        logger.debug(f"Removed worker for task {task_id}")
        
        # Start the worker thread
        thread = threading.Thread(target=_work)
        thread.daemon = True
        
        with self._lock:
            self._workers[task_id] = (thread, 'running')
            self._results[task_id] = {
                'status': 'running',
                'result': None,
                'error': None,
                'timestamp': time.time()
            }
            logger.debug(f"Started worker thread for task {task_id}")
        
        thread.start()
        return task_id
    
    def get_task_status(self, task_id: str) -> Dict:
        """
        Get the status of a task.
        
        Args:
            task_id: ID of the task to check
            
        Returns:
            Dictionary with task status information
        """
        with self._lock:
            if task_id in self._results:
                return self._results[task_id].copy()
            else:
                return {
                    'status': 'not_found',
                    'result': None,
                    'error': "Task not found",
                    'timestamp': time.time()
                }
    
    def is_task_complete(self, task_id: str) -> bool:
        """Check if a task is complete (successful or failed)"""
        status = self.get_task_status(task_id)
        return status['status'] in ['completed', 'error']
    
    def wait_for_task(self, task_id: str, timeout: Optional[float] = None) -> Dict:
        """
        Wait for a task to complete and return the result.
        
        Args:
            task_id: ID of the task to wait for
            timeout: Maximum time to wait in seconds, or None for no limit
            
        Returns:
            Task result dictionary
        """
        start_time = time.time()
        
        while True:
            if self.is_task_complete(task_id):
                return self.get_task_status(task_id)
            
            if timeout is not None and time.time() - start_time > timeout:
                return {
                    'status': 'timeout',
                    'result': None,
                    'error': "Operation timed out",
                    'timestamp': time.time()
                }
            
            time.sleep(0.1)
    
    def clean_old_results(self, max_age: float = 3600):
        """
        Clean up old task results to free memory.
        
        Args:
            max_age: Maximum age of results to keep in seconds (default: 1 hour)
        """
        with self._lock:
            current_time = time.time()
            old_tasks = [
                task_id for task_id, result in self._results.items()
                if current_time - result['timestamp'] > max_age
                and task_id not in self._workers
            ]
            
            for task_id in old_tasks:
                del self._results[task_id]
                logger.debug(f"Removed old result for task {task_id}")

            if old_tasks:
                logger.info(f"Cleaned up {len(old_tasks)} old task results")
    
    def _cleanup(self):
        """Clean up all running tasks when the application exits"""
        with self._lock:
            # Wait for any running tasks to complete
            for task_id, (thread, _) in self._workers.items():
                if thread.is_alive():
                    logger.info(f"Waiting for task {task_id} to complete...")
                    thread.join(timeout=1.0)  # Wait up to 1 second per task
            
            # Clear all results and workers
            self._workers.clear()
            self._results.clear()
            logger.info("FileProcessingService cleanup complete")


# Global instance
file_processing_service = FileProcessingService()