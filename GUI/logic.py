import os
import sys
import logging
from ..utils.logger_service import logger_service  # Changed to relative
from ..core.errors import ParsingError # Changed to relative
from ..core.constants import SUPPORTED_FORMATS, USER_MESSAGES # Changed to relative

# Add parent directory to Python path to find modules
# This line might become redundant or even problematic with consistent relative imports.
# For now, keeping it as per original structure, but it's a candidate for removal later
# if all modules correctly use relative imports and the package structure is sound.
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
