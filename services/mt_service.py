import logging
import html
import requests # Ensure this dependency is listed in requirements.txt
from typing import Optional, Dict, List, Tuple, Callable, Any

logger = logging.getLogger(__name__)

# Consider making the API URL and other constants configurable if needed
GOOGLE_TRANSLATE_API_URL = "https://translation.googleapis.com/language/translate/v2"

class MachineTranslationService:
    """
    Service for performing machine translation using external APIs.
    Currently supports Google Cloud Translate API.
    """

    def machine_translate(self,
                          text: str,
                          source_lang: str,
                          target_lang: str,
                          api_key: str,
                          api_url: str = GOOGLE_TRANSLATE_API_URL) -> Optional[str]:
        """
        Translate text using a specified translation API (defaults to Google Cloud Translate).

        Args:
            text: The text to translate.
            source_lang: The source language code (e.g., "en").
            target_lang: The target language code (e.g., "es").
            api_key: The API key for the translation service.
            api_url: The base URL for the translation API.

        Returns:
            The translated text as a string, or None if translation fails.
        """
        if not api_key:
            logger.error("Machine Translation Error: API key is not provided.")
            return None
        if not text: # No need to call API for empty text
            return ""

        payload = {
            'q': text,
            'source': source_lang,
            'target': target_lang,
            'key': api_key,
            'format': 'text' # Request plain text translation
        }

        result_json = None # Initialize for logging in case of early error
        try:
            response = requests.post(api_url, params=payload, timeout=10) # Added timeout
            response.raise_for_status()  # Raises HTTPError for bad responses (4XX or 5XX)

            result_json = response.json()

            if 'data' in result_json and 'translations' in result_json['data'] and \
               isinstance(result_json['data']['translations'], list) and \
               len(result_json['data']['translations']) > 0 and \
               'translatedText' in result_json['data']['translations'][0]:

                translated_text = result_json['data']['translations'][0]['translatedText']
                # Decode HTML entities that might be in the response
                return html.unescape(translated_text)
            else:
                logger.error(f"Machine Translation Error: Unexpected API response format: {result_json}")
                return None

        except requests.exceptions.Timeout:
            logger.error(f"Machine Translation Error: Request timed out to {api_url}.")
            return None
        except requests.exceptions.HTTPError as http_err:
            # Log the response text if available
            response_text = ""
            if http_err.response is not None:
                response_text = http_err.response.text
            logger.error(f"Machine Translation Error: HTTP error occurred: {http_err} - Response: {response_text}")
            return None
        except requests.exceptions.RequestException as req_err: # Catch other request-related errors
            logger.error(f"Machine Translation Error: Request exception occurred: {req_err}")
            return None
        except (KeyError, IndexError, TypeError) as e: # More specific exceptions for parsing response
            logger.error(f"Machine Translation Error: Error parsing API response: {e} - Response JSON: {result_json}")
            return None
        except Exception as e: # Catch-all for other unexpected errors
            logger.error(f"Machine Translation Error: Unexpected error during translation: {e}", exc_info=True)
            return None

    def translate_missing_keys(self,
                               source_dict: Dict[str, str],
                               target_dict: Dict[str, str],
                               source_lang: str,
                               target_lang: str,
                               api_key: str,
                               progress_callback: Optional[Callable[[float], None]] = None,
                               keys_to_translate: Optional[List[str]] = None) -> Tuple[Dict[str, str], List[str]]:
        """
        Translates missing keys from a source dictionary to a target dictionary.

        Args:
            source_dict: Dictionary of source language translations.
            target_dict: Dictionary of target language translations (will be updated).
            source_lang: Source language code.
            target_lang: Target language code.
            api_key: API key for the translation service.
            progress_callback: Optional callback function to report progress (0.0 to 1.0).
            keys_to_translate: Optional list of specific keys to translate. If None, all missing keys are translated.


        Returns:
            A tuple containing:
                - updated_target_dict: The target dictionary updated with new translations.
                - errors: A list of error messages for keys that failed to translate.
        """
        if not api_key:
            logger.error("translate_missing_keys: API key not provided.")
            if progress_callback: progress_callback(1.0) # Ensure progress completes
            return target_dict, ["Machine translation disabled: No API key provided."]

        updated_target_dict = target_dict.copy()
        errors: List[str] = []

        if keys_to_translate is None:
            # Identify keys present in source_dict but not in target_dict, and source value is not empty
            missing_keys = [key for key in source_dict if source_dict[key] and key not in updated_target_dict]
        else:
            # Filter provided keys to ensure they exist in source, source value is not empty,
            # and are missing or empty in target
            missing_keys = [
                key for key in keys_to_translate
                if key in source_dict and source_dict[key] and
                   (key not in updated_target_dict or not updated_target_dict[key])
            ]

        if not missing_keys:
            logger.info("translate_missing_keys: No missing keys to translate or all target keys already have content.")
            if progress_callback:
                progress_callback(1.0)
            return updated_target_dict, errors

        total_keys_to_process = len(missing_keys)
        processed_count = 0

        for key in missing_keys:
            text_to_translate = source_dict[key]
            # Already checked for empty source_dict[key] when building missing_keys list

            try:
                translated_text = self.machine_translate(text_to_translate, source_lang, target_lang, api_key)
                if translated_text is not None:
                    updated_target_dict[key] = translated_text
                else:
                    errors.append(f"Failed to translate value for key '{key}': API returned no translation.")
            except Exception as e:
                logger.error(f"Error translating key '{key}': {e}", exc_info=True)
                errors.append(f"Error translating key '{key}': {str(e)}")

            processed_count += 1
            if progress_callback:
                progress_callback(processed_count / total_keys_to_process)

        if progress_callback:
            progress_callback(1.0)

        return updated_target_dict, errors
