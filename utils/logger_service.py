import logging
import os
from datetime import datetime
from pathlib import Path

class LoggerService:
    """Singleton logger service for the Localizer application.
    
    This class implements the singleton pattern to provide a centralized logging
    service. It configures both file and console logging handlers with appropriate
    formatting and log levels.
    """
    
    _instance = None
    
    def __new__(cls):
        """Create or return the singleton instance."""
        if cls._instance is None:
            cls._instance = super(LoggerService, cls).__new__(cls)
            cls._instance._initialized = False
        return cls._instance
    
    def __init__(self):
        """Initialize the logger service with file and console handlers.
        
        Creates log directory if needed and configures handlers with appropriate
        formatters and log levels. File handler captures all levels (DEBUG+) while
        console handler shows only warnings and above.
        """
        if self._initialized:
            return
            
        self._initialized = True
        
        # Create logs directory if it doesn't exist
        log_dir = Path("logs")
        log_dir.mkdir(exist_ok=True)
        
        # Create log file with timestamp
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        log_file = log_dir / f"localizer_{timestamp}.log"
        
        # Configure logging
        self.logger = logging.getLogger("LocalizerApp")
        self.logger.setLevel(logging.DEBUG)
        
        # File handler
        file_handler = logging.FileHandler(log_file, encoding='utf-8')
        file_handler.setLevel(logging.DEBUG)
        file_formatter = logging.Formatter(
            '%(asctime)s - %(name)s - %(levelname)s - %(message)s',
            datefmt='%Y-%m-%d %H:%M:%S'
        )
        file_handler.setFormatter(file_formatter)
        
        # Console handler
        console_handler = logging.StreamHandler()
        console_handler.setLevel(logging.WARNING)
        console_formatter = logging.Formatter('%(levelname)s: %(message)s')
        console_handler.setFormatter(console_formatter)
        
        self.logger.addHandler(file_handler)
        self.logger.addHandler(console_handler)

    def get_logger(self):
        """Get the configured logger instance.
        
        Returns:
            logging.Logger: The configured logger instance for the application
        """
        return self.logger

logger_service = LoggerService()
