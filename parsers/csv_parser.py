import csv
from io import StringIO
from typing import Dict, Optional, Tuple, Union, List # Added List
from .base_parser import TranslationParser
from core.parsing_result import ParsingResult # Import the new class
try:
    # Assuming these are for a larger project structure
    from ..utils.logger_service import logger_service
    from ..core.errors import CSVParsingError
except ImportError:
    # Fallback for standalone execution or simpler project structure
    import logging as logger_service # Use standard logging as a fallback
    class CSVParsingError(ValueError): pass # Define a basic error class

# If using standard logging as fallback, get a logger instance
logger = logger_service.getLogger(__name__) if hasattr(logger_service, 'getLogger') else logger_service

class CSVParser(TranslationParser):
    def __init__(self, 
                 delimiter: str = ',',
                 has_header: bool = True,
                 key_column: Union[str, int] = 'key',
                 value_column: Union[str, int] = 'value',
                 quoting: int = csv.QUOTE_MINIMAL):
        self.delimiter = delimiter
        self.has_header = has_header
        self.key_column = key_column
        self.value_column = value_column
        self.quoting = quoting
        
    def _validate_columns(self, fieldnames: list) -> None:
        if not self.has_header: return # No fieldnames to validate if no header
        if isinstance(self.key_column, str) and self.key_column not in fieldnames:
            raise CSVParsingError(f"Key column '{self.key_column}' not found in headers: {fieldnames}")
        if isinstance(self.value_column, str) and self.value_column not in fieldnames:
            raise CSVParsingError(f"Value column '{self.value_column}' not found in headers: {fieldnames}")

    def _get_column_indices_from_header(self, fieldnames: List[str]) -> Tuple[int, int]:
        try:
            key_idx = fieldnames.index(self.key_column) if isinstance(self.key_column, str) else int(self.key_column)
            val_idx = fieldnames.index(self.value_column) if isinstance(self.value_column, str) else int(self.value_column)

            if not (0 <= key_idx < len(fieldnames) and 0 <= val_idx < len(fieldnames)):
                raise CSVParsingError(f"Column index out of range for header. Fields: {fieldnames}")
            return key_idx, val_idx
        except ValueError as e: # Handles .index not found or int conversion error
            raise CSVParsingError(f"Column not found in header or invalid index: {e}. Fields: {fieldnames}")
        except TypeError: # Handles int(self.key_column) if it's not int-like
             raise CSVParsingError(f"Invalid column index type. Key: '{self.key_column}', Value: '{self.value_column}'")


    def _get_column_indices_no_header(self) -> Tuple[int, int]:
        try:
            key_idx = int(self.key_column)
            val_idx = int(self.value_column)
            if key_idx < 0 or val_idx < 0:
                raise CSVParsingError("Column indices must be non-negative for no-header CSV.")
            return key_idx, val_idx
        except (ValueError, TypeError):
            raise CSVParsingError(
                f"Invalid column index. For no-header CSV, key_column ('{self.key_column}') and "
                f"value_column ('{self.value_column}') must be integers."
            )

    def parse(self, content: str) -> ParsingResult: # Update return type annotation
        if not content.strip():
            logger.warning("Empty content provided to CSV parser")
            return ParsingResult(translations={}, errors=["Empty content provided."])

        translations: Dict[str, str] = {}
        line_numbers: Dict[str, int] = {}
        parsing_errors: List[str] = []
        
        try:
            content = content.strip().lstrip('\ufeff') # Remove BOM
            csv_file = StringIO(content)
            
            dialect = None
            try:
                # Sniff first 1024 bytes for dialect, ensure there's content to sniff
                sample = content[:1024]
                if sample:
                    dialect = csv.Sniffer().sniff(sample)
                    logger.debug(f"Detected CSV dialect: delimiter='{dialect.delimiter}', quotechar='{dialect.quotechar}'")
                    # Optionally, you could override self.delimiter and self.quoting if dialect is found
                    # For now, just log it.
                else:
                    logger.debug("Content too short to sniff CSV dialect reliably.")
            except csv.Error as e:
                logger.debug(f"Could not auto-detect CSV dialect: {e}. Using provided settings.")

            reader_kwargs = {'delimiter': self.delimiter, 'quoting': self.quoting}
            if dialect: # If dialect detected, prefer its delimiter and quotechar
                reader_kwargs['delimiter'] = dialect.delimiter
                reader_kwargs['quotechar'] = dialect.quotechar
                # Note: Sniffer might not detect all quoting styles correctly, so self.quoting is still a fallback.


            if self.has_header:
                reader = csv.reader(csv_file, **reader_kwargs)
                header = next(reader, None)
                if not header:
                    return ParsingResult(translations={}, errors=["CSV file is empty or contains only a header."])
                
                self._validate_columns(header) # Validates string key/value columns against header names
                key_idx, val_idx = self._get_column_indices_from_header(header)
                
                start_line_num = 2 # Data starts from line 2 if header is present
            else:
                reader = csv.reader(csv_file, **reader_kwargs)
                key_idx, val_idx = self._get_column_indices_no_header()
                start_line_num = 1 # Data starts from line 1 if no header

            for row_num, row in enumerate(reader, start=start_line_num):
                try:
                    if len(row) <= max(key_idx, val_idx):
                        msg = f"Row {row_num}: Insufficient columns ({len(row)}). Expected at least {max(key_idx, val_idx)+1}."
                        logger.warning(msg)
                        parsing_errors.append(msg)
                        continue
                        
                    key = row[key_idx].strip() # Keys are usually stripped
                    value = row[val_idx] # Values might need to preserve whitespace

                    if not key:
                        msg = f"Row {row_num}: Empty key found, skipping."
                        logger.warning(msg)
                        parsing_errors.append(msg)
                        continue

                    if key in translations:
                        msg = f"Row {row_num}: Duplicate key '{key}' found. Value will be overwritten."
                        logger.warning(msg)
                        parsing_errors.append(msg)
                        
                    translations[key] = value or '' # Store empty string if value is None
                    line_numbers[key] = row_num
                    # logger.debug(f"Parsed row {row_num}: {key}={value}")

                except IndexError: # Should be caught by len(row) check, but as a safeguard
                    msg = f"Row {row_num}: Column index out of range. Row content: {row}"
                    logger.warning(msg)
                    parsing_errors.append(msg)

        except CSVParsingError as e: # Catch config errors (e.g. bad column names)
            logger.error(f"CSV configuration error: {str(e)}")
            return ParsingResult(translations={}, errors=[f"CSV configuration error: {str(e)}"])
        except csv.Error as e: # Catch errors from the csv module itself
            error_msg = f"CSV parsing error: {str(e)}"
            logger.error(error_msg)
            return ParsingResult(translations={}, line_numbers=line_numbers, errors=[error_msg] + parsing_errors)
        except Exception as e: # Catch any other unexpected errors
            error_msg = f"Unexpected error parsing CSV: {str(e)}"
            logger.error(error_msg, exc_info=True) # Log with stack trace
            return ParsingResult(translations={}, errors=[error_msg] + parsing_errors)

        if not translations and not parsing_errors:
             logger.info("CSV parsing yielded no translations and no errors.")
        elif not translations and parsing_errors:
             logger.warning(f"CSV parsing yielded no translations, but {len(parsing_errors)} warnings/errors occurred.")


        return ParsingResult(
            translations=translations,
            line_numbers=line_numbers,
            errors=parsing_errors if parsing_errors else None
        )
