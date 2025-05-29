import requests
import html
import logging
from typing import Optional

# It's good practice to get a logger specific to this module
# from utils.logger_service import logger_service
# logger = logger_service.get_logger(__name__)
# For now, using a standard logger. If logger_service is available and preferred,
# this can be changed. Let's assume a standard logger for now to avoid
# dependency on logger_service if it's not fundamental to this utility's operation.
logger = logging.getLogger(__name__)

def machine_translate(text: str, source_lang: str, target_lang: str, api_key: str) -> Optional[str]:
    """Translate text using Google Cloud Translate API."""
    if not api_key:
        logger.warning("Machine translation called without API key.")
        return None
        
    try:
        url = "https://translation.googleapis.com/language/translate/v2"
        payload = {
            'q': text,
            'source': source_lang, # API might also support 'auto' for source_lang
            'target': target_lang,
            'key': api_key,
            'format': 'text' # Specify format to avoid HTML in simple text translation
        }
        
        response = requests.post(url, params=payload)
        response.raise_for_status() # Raises HTTPError for bad responses (4XX or 5XX)
        
        result = response.json()
        
        if result and 'data' in result and 'translations' in result['data'] and \
           isinstance(result['data']['translations'], list) and \
           len(result['data']['translations']) > 0 and \
           'translatedText' in result['data']['translations'][0]:
            translated_text = result['data']['translations'][0]['translatedText']
            # html.unescape might still be needed if the API returns HTML entities
            # despite format=text, or for other reasons.
            return html.unescape(translated_text)
        else:
            logger.error(f"Unexpected API response format from Google Translate: {result}")
            return None
            
    except requests.exceptions.RequestException as e:
        logger.error(f"Translation API request error: {e}")
    except Exception as e: # Catch-all for other unexpected issues like JSON parsing
        logger.error(f"Unexpected error during machine translation: {e}")
        
    return None
