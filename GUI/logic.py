import os
import sys
import logging
from utils.logger_service import logger_service
from core.errors import ParsingError # Kept for potential future use or consistency
from core.constants import SUPPORTED_FORMATS, USER_MESSAGES # Kept as they might be used by GUI components

# Add parent directory to Python path to find modules
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from colorama import init as colorama_init

logger = logger_service.get_logger(__name__)

colorama_init(autoreset=True)

logger.info("GUI logic module initialized. Core functionalities have been refactored to services.")

# All specific logic functions previously in this file have been moved to:
# - core.comparison_service
# - utils.translation_service
# - utils.exporter_service
# - utils.git_utils
# - utils.string_utils
# This file remains for general GUI package-level setup (like logging) 
# and potential future UI-specific helpers not belonging to components.
