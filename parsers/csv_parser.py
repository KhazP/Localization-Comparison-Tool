import csv
from io import StringIO
from typing import Dict, Optional, Tuple, Union
from .base_parser import TranslationParser
try:
    from ..utils.logger_service import logger_service
    from ..core.errors import CSVParsingError
except ImportError:
    # Handle case when running directly
    import sys
    from pathlib import Path
    sys.path.append(str(Path(__file__).parent.parent))
    from utils.logger_service import logger_service
    from core.errors import CSVParsingError

logger = logger_service.get_logger()

class CSVParser(TranslationParser):
    def __init__(self, 
                 delimiter: str = ',',
                 has_header: bool = True,
                 key_column: Union[str, int] = 'key',
                 value_column: Union[str, int] = 'value',
                 quoting: int = csv.QUOTE_MINIMAL):
        """
        Initialize CSV parser with configurable options.
        
        Args:
            delimiter: CSV field delimiter (default: ',')
            has_header: Whether CSV has header row (default: True)
            key_column: Column name or index for keys (default: 'key')
            value_column: Column name or index for values (default: 'value')
            quoting: CSV quoting style (default: QUOTE_MINIMAL)
        """
        self.delimiter = delimiter
        self.has_header = has_header
        self.key_column = key_column
        self.value_column = value_column
        self.quoting = quoting
        
    def _validate_columns(self, fieldnames: list) -> None:
        """Validate column specifications against CSV headers."""
        if isinstance(self.key_column, str) and self.key_column not in fieldnames:
            raise CSVParsingError(f"Key column '{self.key_column}' not found in headers: {fieldnames}")
        if isinstance(self.value_column, str) and self.value_column not in fieldnames:
            raise CSVParsingError(f"Value column '{self.value_column}' not found in headers: {fieldnames}")

    def _get_column_indices(self, row: list) -> Tuple[int, int]:
        """Get column indices for key and value columns."""
        try:
            if isinstance(self.key_column, str):
                key_idx = row.index(self.key_column)
            else:
                key_idx = self.key_column

            if isinstance(self.value_column, str):
                val_idx = row.index(self.value_column)
            else:
                val_idx = self.value_column

            if key_idx >= len(row) or val_idx >= len(row):
                raise CSVParsingError(f"Column index out of range. Row has {len(row)} columns.")
                
            return key_idx, val_idx
            
        except ValueError as e:
            raise CSVParsingError(f"Column not found: {str(e)}")

    def parse(self, content: str) -> Dict[str, str]:
        """
        Parse CSV content into a dictionary of translations.
        
        Args:
            content: CSV content as string
            
        Returns:
            Dictionary of key-value translations
            
        Raises:
            CSVParsingError: If CSV parsing fails
        """
        if not content.strip():
            logger.warning("Empty content provided to CSV parser")
            return {}

        translations = {}
        line_numbers = {}  # Track line numbers for error reporting
        
        try:
            # Remove BOM if present and split into lines
            content = content.strip().lstrip('\ufeff')
            csv_file = StringIO(content)
            
            # Try to detect dialect
            try:
                dialect = csv.Sniffer().sniff(content[:1024])
                logger.debug(f"Detected CSV dialect: delimiter='{dialect.delimiter}'")
                if self.delimiter != dialect.delimiter:
                    logger.warning(
                        f"Provided delimiter '{self.delimiter}' differs from detected "
                        f"delimiter '{dialect.delimiter}'"
                    )
            except csv.Error as e:
                logger.debug(f"Could not detect CSV dialect: {e}")
                dialect = None

            if self.has_header:
                reader = csv.DictReader(
                    csv_file,
                    delimiter=self.delimiter,
                    quoting=self.quoting
                )
                
                if not reader.fieldnames:
                    raise CSVParsingError("No header row found in CSV")
                    
                self._validate_columns(reader.fieldnames)
                
                for row_num, row in enumerate(reader, start=2):  # Start from 2 to account for header
                    try:
                        key = row[self.key_column]
                        value = row[self.value_column]
                        
                        if not key:
                            logger.warning(f"Empty key in row {row_num}, skipping")
                            continue
                            
                        translations[key] = value or ''
                        line_numbers[key] = row_num
                        logger.debug(f"Parsed row {row_num}: {key}={value}")
                        
                    except KeyError as e:
                        logger.error(f"Missing column in row {row_num}: {e}")
                        raise CSVParsingError(f"Row {row_num}: Missing column {e}")
                        
            else:
                reader = csv.reader(
                    csv_file,
                    delimiter=self.delimiter,
                    quoting=self.quoting
                )
                
                # Get column indices from first row
                first_row = next(reader, None)
                if not first_row:
                    raise CSVParsingError("Empty CSV file")
                    
                key_idx, val_idx = self._get_column_indices(first_row)
                
                # Parse rows
                for row_num, row in enumerate(reader, start=1):
                    if len(row) <= max(key_idx, val_idx):
                        logger.warning(f"Row {row_num}: Insufficient columns, skipping")
                        continue
                        
                    key = row[key_idx]
                    if not key:
                        logger.warning(f"Empty key in row {row_num}, skipping")
                        continue
                        
                    translations[key] = row[val_idx] or ''
                    line_numbers[key] = row_num
                    logger.debug(f"Parsed row {row_num}: {key}={translations[key]}")

        except csv.Error as e:
            error_msg = f"CSV parsing error: {str(e)}"
            logger.error(error_msg)
            raise CSVParsingError(error_msg)
            
        except (KeyError, IndexError) as e:
            error_msg = f"CSV column error: {str(e)}"
            logger.error(error_msg)
            raise CSVParsingError(error_msg)
            
        except (UnicodeDecodeError, UnicodeError) as e:
            error_msg = f"CSV encoding error: {str(e)}"
            logger.error(error_msg)
            raise CSVParsingError(error_msg)
            
        except OSError as e:
            error_msg = f"File system error: {str(e)}"
            logger.error(error_msg)
            raise CSVParsingError(error_msg)
            
        except Exception as e:
            error_msg = f"Unexpected error parsing CSV: {str(e)}"
            logger.error(error_msg)
            raise CSVParsingError(error_msg)

        logger.info(f"Successfully parsed {len(translations)} translations from CSV")
        return {
            "translations": translations,
            "line_numbers": line_numbers
        }
