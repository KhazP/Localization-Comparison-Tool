import os
import logging
from pathlib import Path

class LoggerService:
    """Singleton logger service for the Localizer application."""
    
    _instance = None
    DEFAULT_LOG_LEVEL = logging.INFO
    
    def __new__(cls):
        if cls._instance is None:
            cls._instance = super(LoggerService, cls).__new__(cls)
            cls._instance._initialized = False
        return cls._instance
        
    def __init__(self):
        if self._initialized:
            return
            
        self._initialized = True
        
        # Setup log directory in user's AppData folder
        self.log_dir = os.path.join(os.getenv('APPDATA') or os.getenv('TEMP'), 'LocalizerApp', 'logs')
        os.makedirs(self.log_dir, exist_ok=True)
        
        # Configure main logger
        self.logger = logging.getLogger('LocalizerApp')
        self.logger.setLevel(self.DEFAULT_LOG_LEVEL)
        
        # File handler with rotation
        log_file = os.path.join(self.log_dir, 'localizer.log')
        file_handler = logging.FileHandler(log_file, encoding='utf-8')
        file_handler.setLevel(logging.DEBUG)
        file_formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
        file_handler.setFormatter(file_formatter)
        
        # Console handler
        console_handler = logging.StreamHandler()
        console_handler.setLevel(logging.WARNING)
        console_formatter = logging.Formatter('%(levelname)s: %(message)s')
        console_handler.setFormatter(console_formatter)
        
        # Add handlers
        self.logger.addHandler(file_handler)
        self.logger.addHandler(console_handler)
    
    def get_logger(self):
        """Get the configured logger instance."""
        return self.logger
    
    def get_log_dir(self):
        """Get the configured log directory path."""
        return self.log_dir

# Global instance
logger_service = LoggerService()
