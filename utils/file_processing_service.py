import threading
import time
import os
import atexit
from typing import Dict, Optional, Callable, Any
from pathlib import Path
import logging

# Local application imports
from utils.logger_service import logger_service
# file_cache_service is not used directly for parsing anymore, but might be for other things.
# from utils.file_cache_service import file_cache_service 
# import GUI.logic as gui_logic # Removed this import

# New imports for parser discovery and error handling
from ..parsers import get_available_parsers, get_parser_for_file, BaseParser # BaseParser might be unused here
from ..core.errors import UnsupportedFormatError, ParsingError
# New import for the relocated compare_translations function
from ..core.comparison_service import compare_translations
from ..core.errors import UnsupportedFormatError, ParsingError

logger = logger_service.get_logger()

class FileProcessingService:
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
            self._workers: Dict[str, tuple[threading.Thread, str]] = {}
            self._results: Dict[str, Dict[str, Any]] = {}
            self._task_counter = 0
            
            # Initialize available parsers
            self.available_parsers = get_available_parsers()
            if not self.available_parsers:
                logger.warning("No parsers discovered. File parsing will not work.")
            else:
                logger.info(f"Discovered {len(self.available_parsers)} parsers: {list(self.available_parsers.keys())}")

            logger.info("FileProcessingService initialized")
            atexit.register(self._cleanup)
    
    def _get_next_task_id(self) -> str:
        with self._lock:
            self._task_counter += 1
            return f"task_{self._task_counter}"

    def _process_file_synchronously(self, file_path: str) -> Dict[str, str]:
        """
        Synchronously parses a file using the discovered parsers.
        This is a helper method for internal use by async methods.
        """
        # file_cache_service.read_file(file_path) is removed, parser handles file reading.
        parser = get_parser_for_file(file_path, self.available_parsers)
        if not parser:
            # Log this error as it's a significant issue for processing.
            logger.error(f"No parser found for file: {file_path}")
            raise UnsupportedFormatError(f"No parser found for file type: {Path(file_path).suffix}", filepath=file_path)
        
        # The parser's parse method now takes file_path and handles reading.
        # It also raises ParsingError on issues.
        return parser.parse(file_path)

    def parse_file_async(self, file_path: str, progress_callback: Optional[Callable[[float], None]] = None) -> str:
        task_id = self._get_next_task_id()
        
        def _work():
            try:
                if progress_callback: progress_callback(0.1)
                
                # Use the new synchronous helper for parsing logic
                # This already includes getting the parser and calling its parse method
                result = self._process_file_synchronously(file_path)
                
                if progress_callback: progress_callback(0.9)
                
                with self._lock:
                    self._results[task_id] = {'status': 'completed', 'result': result, 'error': None, 'timestamp': time.time()}
                
                if progress_callback: progress_callback(1.0)
                
            except (UnsupportedFormatError, ParsingError) as e:
                logger.error(f"Error parsing file {file_path}: {e}")
                with self._lock:
                    self._results[task_id] = {'status': 'error', 'result': None, 'error': str(e), 'timestamp': time.time()}
                if progress_callback: progress_callback(1.0)
            except Exception as e: # Catch any other unexpected errors
                logger.error(f"Unexpected error parsing file {file_path}: {e}", exc_info=True)
                with self._lock:
                    self._results[task_id] = {'status': 'error', 'result': None, 'error': f"An unexpected error occurred: {e}", 'timestamp': time.time()}
                if progress_callback: progress_callback(1.0)
            finally:
                with self._lock:
                    if task_id in self._workers: del self._workers[task_id]
        
        thread = threading.Thread(target=_work)
        thread.daemon = True
        with self._lock:
            self._workers[task_id] = (thread, 'running')
            self._results[task_id] = {'status': 'running', 'result': None, 'error': None, 'timestamp': time.time()}
        thread.start()
        return task_id
    
    def compare_files_async(self, source_path: str, target_path: str, 
                           config: dict, progress_callback: Optional[Callable[[float], None]] = None) -> str:
        task_id = self._get_next_task_id()
        
        def _work():
            try:
                if progress_callback: progress_callback(0.1)
                
                source_dict = self._process_file_synchronously(source_path)
                if progress_callback: progress_callback(0.4) # Adjusted progress
                    
                target_dict = self._process_file_synchronously(target_path)
                if progress_callback: progress_callback(0.7) # Adjusted progress
                
                # Line numbers are no longer returned by the new parsers.
                # If line numbers are critical, this part needs rethinking.
                # For now, pass empty dicts for source_lines and target_lines.
                source_lines = {} 
                target_lines = {}
                
                mt_settings = {
                    'enabled': config.get("mt_enabled", False),
                    'api_key': config.get("mt_api_key", ""),
                    'source_lang': config.get("mt_source_lang", "en"),
                    'target_lang': config.get("mt_target_lang", "")
                }
                
                # Assuming gui_logic.compare_translations is still the comparison engine.
                # It might need adjustment if it expected specific parser output structures.
                # UPDATED: Call the new compare_translations
                comparison_result = compare_translations(
                    source_translations=source_dict, 
                    target_translations=target_dict,
                    ignore_case=config.get("ignore_case", False),
                    # ignore_whitespace is not a direct param in the new compare_translations
                    # but handled by normalize_key. The old call also didn't use it actively.
                    is_gui=True, include_summary=False, # Assuming these are GUI flags
                    compare_values=config.get("compare_values", True),
                    ignore_patterns=config.get("ignore_patterns", []),
                    log_missing_keys=config.get("log_missing_strings", False),
                    auto_fill_missing=config.get("auto_fill_missing", False),
                    mt_settings=mt_settings
                )
                
                missing_keys_set = set(source_dict.keys()) - set(target_dict.keys())
                obsolete_keys_set = set(target_dict.keys()) - set(source_dict.keys())
                
                stats = {
                    'total_keys': len(source_dict),
                    'missing_keys': len(missing_keys_set),
                    'obsolete_keys': len(obsolete_keys_set)
                }
                
                with self._lock:
                    self._results[task_id] = {
                        'status': 'completed',
                        'result': {
                            'comparison': comparison_result,
                            'source_dict': source_dict, 'target_dict': target_dict,
                            'source_lines': source_lines, 'target_lines': target_lines, # Still here, but empty
                            'stats': stats
                        },
                        'error': None, 'timestamp': time.time()
                    }
                if progress_callback: progress_callback(1.0)
                
            except (UnsupportedFormatError, ParsingError) as e:
                logger.error(f"Error during file comparison ({source_path} vs {target_path}): {e}")
                with self._lock:
                    self._results[task_id] = {'status': 'error', 'result': None, 'error': str(e), 'timestamp': time.time()}
                if progress_callback: progress_callback(1.0)
            except Exception as e:
                logger.error(f"Unexpected error comparing files {source_path} and {target_path}: {e}", exc_info=True)
                with self._lock:
                    self._results[task_id] = {'status': 'error', 'result': None, 'error': f"An unexpected error occurred: {e}", 'timestamp': time.time()}
                if progress_callback: progress_callback(1.0)
            finally:
                with self._lock:
                    if task_id in self._workers: del self._workers[task_id]
        
        thread = threading.Thread(target=_work)
        thread.daemon = True
        with self._lock:
            self._workers[task_id] = (thread, 'running')
            self._results[task_id] = {'status': 'running', 'result': None, 'error': None, 'timestamp': time.time()}
        thread.start()
        return task_id
    
    def compare_directories_async(self, source_dir: str, target_dir: str, 
                                config: dict, progress_callback: Optional[Callable[[float], None]] = None) -> str:
        task_id = self._get_next_task_id()
        
        def _work():
            try:
                if progress_callback: progress_callback(0.05)
                
                source_files_map = {}
                target_files_map = {}
                
                # Determine supported extensions from all available parsers
                supported_extensions = set()
                for p_instance in self.available_parsers.values():
                    for ext in p_instance.get_supported_extensions():
                        supported_extensions.add(ext)
                if not supported_extensions:
                    logger.warning("No supported extensions found from parsers for directory comparison.")
                    # Potentially fall back to gui_logic.SUPPORTED_FORMATS if it exists and is relevant
                    # For now, let's assume this set is comprehensive.
                
                for root, _, files in os.walk(source_dir):
                    for file in files:
                        file_path = os.path.join(root, file)
                        rel_path = os.path.relpath(file_path, source_dir)
                        if Path(file).suffix.lower() in supported_extensions:
                            source_files_map[rel_path] = file_path
                
                for root, _, files in os.walk(target_dir):
                    for file in files:
                        file_path = os.path.join(root, file)
                        rel_path = os.path.relpath(file_path, target_dir)
                        if Path(file).suffix.lower() in supported_extensions:
                            target_files_map[rel_path] = file_path
                
                if progress_callback: progress_callback(0.1)
                
                common_files = sorted(list(set(source_files_map.keys()) & set(target_files_map.keys())))
                
                if not common_files:
                    # ... (error handling for no common files, same as original)
                    with self._lock: # Ensure lock is used for results
                        self._results[task_id] = {
                            'status': 'completed',
                            'result': {
                                'error': "No matching files with supported extensions found in both directories.",
                                'file_results': {},
                                'stats': {'total_files': 0, 'total_missing': 0, 'total_obsolete': 0}
                            }, 'error': None, 'timestamp': time.time()
                        }
                    if progress_callback: progress_callback(1.0)
                    return

                file_results = {}
                total_missing_overall = 0
                total_obsolete_overall = 0
                progress_per_file = 0.8 / len(common_files)
                progress_base = 0.1
                
                for i, filename in enumerate(common_files):
                    source_path = source_files_map[filename]
                    target_path = target_files_map[filename]
                    current_file_result = {}
                    try:
                        source_dict = self._process_file_synchronously(source_path)
                        target_dict = self._process_file_synchronously(target_path)
                        
                        mt_settings = {
                            'enabled': config.get("mt_enabled", False),
                            'api_key': config.get("mt_api_key", ""),
                            'source_lang': config.get("mt_source_lang", "en"),
                            'target_lang': config.get("mt_target_lang", "")
                        }
                        
                        comparison_output = gui_logic.compare_translations(
                            target_dict, source_dict,
                            ignore_case=config.get("ignore_case", False),
                            ignore_whitespace=config.get("ignore_whitespace", False),
                            is_gui=True, include_summary=False,
                            compare_values=config.get("compare_values", True),
                            ignore_patterns=config.get("ignore_patterns", []),
                            log_missing_keys=config.get("log_missing_strings", False),
                            auto_fill_missing=config.get("auto_fill_missing", False),
                            mt_settings=mt_settings
                        )
                        
                        file_missing_keys = len(set(source_dict.keys()) - set(target_dict.keys()))
                        file_obsolete_keys = len(set(target_dict.keys()) - set(source_dict.keys()))
                        total_missing_overall += file_missing_keys
                        total_obsolete_overall += file_obsolete_keys
                        
                        current_file_result = {
                            'comparison': comparison_output,
                            'source_dict': source_dict, 'target_dict': target_dict,
                            'stats': {
                                'total_keys': len(source_dict),
                                'missing_keys': file_missing_keys,
                                'obsolete_keys': file_obsolete_keys
                            }
                        }
                    except (UnsupportedFormatError, ParsingError) as e:
                        logger.error(f"Skipping file pair {filename} due to parsing error: {e}")
                        current_file_result = {'error': str(e), 'stats': {'total_keys': 0, 'missing_keys': 0, 'obsolete_keys': 0}}
                    except Exception as e:
                        logger.error(f"Unexpected error processing file pair {filename}: {e}", exc_info=True)
                        current_file_result = {'error': f"Unexpected error: {e}", 'stats': {'total_keys': 0, 'missing_keys': 0, 'obsolete_keys': 0}}
                    
                    file_results[filename] = current_file_result
                    if progress_callback:
                        current_prog = progress_base + (i + 1) * progress_per_file
                        progress_callback(min(0.95, current_prog))
                
                with self._lock:
                    self._results[task_id] = {
                        'status': 'completed',
                        'result': {
                            'file_results': file_results,
                            'stats': {
                                'total_files': len(common_files),
                                'total_missing': total_missing_overall,
                                'total_obsolete': total_obsolete_overall
                            }
                        }, 'error': None, 'timestamp': time.time()
                    }
                if progress_callback: progress_callback(1.0)

            except Exception as e: # Broad exception for directory walk or setup issues
                logger.error(f"Error in directory comparison ({source_dir} vs {target_dir}): {e}", exc_info=True)
                with self._lock:
                    self._results[task_id] = {'status': 'error', 'result': None, 'error': f"An unexpected error occurred: {e}", 'timestamp': time.time()}
                if progress_callback: progress_callback(1.0)
            finally:
                with self._lock:
                    if task_id in self._workers: del self._workers[task_id]
        
        thread = threading.Thread(target=_work)
        thread.daemon = True
        with self._lock:
            self._workers[task_id] = (thread, 'running')
            self._results[task_id] = {'status': 'running', 'result': None, 'error': None, 'timestamp': time.time()}
        thread.start()
        return task_id

    def get_task_status(self, task_id: str) -> Dict[str, Any]:
        with self._lock:
            res = self._results.get(task_id)
            if res: return res.copy()
            return {'status': 'not_found', 'result': None, 'error': "Task not found", 'timestamp': time.time()}
    
    def is_task_complete(self, task_id: str) -> bool:
        status_info = self.get_task_status(task_id)
        return status_info['status'] in ['completed', 'error']
    
    def wait_for_task(self, task_id: str, timeout: Optional[float] = None) -> Dict[str, Any]:
        start_time = time.time()
        while True:
            if self.is_task_complete(task_id):
                return self.get_task_status(task_id)
            if timeout is not None and (time.time() - start_time) > timeout:
                return {'status': 'timeout', 'result': None, 'error': "Operation timed out", 'timestamp': time.time()}
            time.sleep(0.1)
    
    def clean_old_results(self, max_age: float = 3600):
        with self._lock:
            current_time = time.time()
            tasks_to_delete = [
                tid for tid, res in self._results.items()
                if (current_time - res['timestamp']) > max_age and tid not in self._workers
            ]
            for tid in tasks_to_delete:
                del self._results[tid]
                logger.debug(f"Removed old result for task {tid}")
            if tasks_to_delete:
                logger.info(f"Cleaned up {len(tasks_to_delete)} old task results")
    
    def _cleanup(self):
        with self._lock:
            running_threads = [worker_info[0] for worker_info in self._workers.values() if worker_info[0].is_alive()]
            for thread in running_threads:
                logger.info(f"Waiting for task {thread.name} to complete...") # Tasks are not named here, but thread name can be set.
                thread.join(timeout=1.0)
            self._workers.clear()
            self._results.clear()
            logger.info("FileProcessingService cleanup complete")

file_processing_service = FileProcessingService()