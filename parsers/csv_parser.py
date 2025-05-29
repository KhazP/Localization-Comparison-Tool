import csv
from typing import Dict, List, Union # Removed Optional, Tuple. Added List.
from .base_parser import BaseParser
from ..core.errors import ParsingError # Use ..core.errors

class CsvParser(BaseParser): # Renamed and changed parent class
    def __init__(self, 
                 delimiter: str = ',',
                 has_header: bool = True,
                 key_column: Union[str, int] = 'key', # Default to string 'key'
                 value_column: Union[str, int] = 'value', # Default to string 'value'
                 quoting: int = csv.QUOTE_MINIMAL,
                 encoding: str = 'utf-8' # Added encoding parameter
                 ):
        self.delimiter = delimiter
        self.has_header = has_header
        self.key_column = key_column
        self.value_column = value_column
        self.quoting = quoting
        self.encoding = encoding # Store encoding

    def _validate_columns(self, fieldnames: List[str], filepath: str) -> None:
        """Validate column specifications against CSV headers."""
        if isinstance(self.key_column, str) and self.key_column not in fieldnames:
            raise ParsingError(f"Key column '{self.key_column}' not found in headers: {fieldnames}", filepath=filepath)
        if isinstance(self.value_column, str) and self.value_column not in fieldnames:
            raise ParsingError(f"Value column '{self.value_column}' not found in headers: {fieldnames}", filepath=filepath)

    def _get_column_indices(self, header_row: List[str], filepath: str) -> tuple[int, int]:
        """
        Get column indices for key and value columns.
        If has_header is false, header_row is effectively the first data row.
        """
        key_idx: int
        val_idx: int

        if isinstance(self.key_column, str):
            if not self.has_header:
                raise ParsingError("key_column cannot be string if has_header is False and no header is available to map names.", filepath=filepath)
            try:
                key_idx = header_row.index(self.key_column)
            except ValueError:
                raise ParsingError(f"Key column '{self.key_column}' not found in header.", filepath=filepath)
        else:
            key_idx = self.key_column

        if isinstance(self.value_column, str):
            if not self.has_header:
                raise ParsingError("value_column cannot be string if has_header is False and no header is available to map names.", filepath=filepath)
            try:
                val_idx = header_row.index(self.value_column)
            except ValueError:
                raise ParsingError(f"Value column '{self.value_column}' not found in header.", filepath=filepath)
        else:
            val_idx = self.value_column
        
        # Validate indices against a generic row length if possible (deferred to row processing)
        return key_idx, val_idx


    def parse(self, file_path: str) -> Dict[str, str]:
        translations: Dict[str, str] = {}
        try:
            # Use newline='' for csv module, as recommended in its documentation
            with open(file_path, 'r', encoding=self.encoding, newline='') as csvfile:
                # Sniffing dialect can be helpful but might override explicit settings.
                # For now, rely on constructor parameters.
                # content_sample = csvfile.read(1024)
                # csvfile.seek(0) # Reset file pointer
                # try:
                #     dialect = csv.Sniffer().sniff(content_sample)
                #     # Could compare dialect.delimiter with self.delimiter here
                # except csv.Error:
                #     pass # Stick to provided delimiter

                if self.has_header:
                    reader = csv.DictReader(csvfile, delimiter=self.delimiter, quoting=self.quoting)
                    if not reader.fieldnames:
                        raise ParsingError("No header row found in CSV or CSV is empty.", filepath=file_path)
                    self._validate_columns(reader.fieldnames, file_path)
                    
                    key_col_name = self.key_column if isinstance(self.key_column, str) else reader.fieldnames[self.key_column]
                    val_col_name = self.value_column if isinstance(self.value_column, str) else reader.fieldnames[self.value_column]

                    for row_num, row_dict in enumerate(reader, start=2 if self.has_header else 1):
                        try:
                            key = row_dict.get(key_col_name)
                            value = row_dict.get(val_col_name)

                            if key is None: # Key column might be missing for this row if CSV is ragged
                                # Or if key_col_name was an out-of-bounds index converted to name
                                raise ParsingError(f"Key column '{key_col_name}' not found in row {row_num}.", filepath=file_path)
                            
                            if not str(key).strip(): # Skip rows with empty keys
                                continue
                            
                            translations[str(key)] = str(value) if value is not None else ""
                        except IndexError as e: # Should not happen with DictReader if fieldnames are correct
                             raise ParsingError(f"Column index error in row {row_num}: {e}", filepath=file_path, original_exception=e)
                        except KeyError as e: # If a string key_column/value_column is not in a specific row (should be caught by _validate_columns or earlier)
                            raise ParsingError(f"Column name error in row {row_num}: {e}", filepath=file_path, original_exception=e)

                else: # No header row
                    reader = csv.reader(csvfile, delimiter=self.delimiter, quoting=self.quoting)
                    
                    # Determine key_idx and val_idx using the first row or direct integer values
                    # If key/value_column are strings, this path is problematic without headers.
                    # _get_column_indices needs to be called carefully or its logic adapted.
                    # For now, assume key_column and value_column are integer indices if no_header.
                    if isinstance(self.key_column, str) or isinstance(self.value_column, str):
                        raise ParsingError("key_column and value_column must be integers when has_header is False.", filepath=file_path)

                    key_idx, val_idx = int(self.key_column), int(self.value_column)

                    for row_num, row_list in enumerate(reader, start=1):
                        if not row_list: # Skip empty rows
                            continue
                        try:
                            if max(key_idx, val_idx) >= len(row_list):
                                # Skip row if key or value column index is out of bounds
                                continue 
                            
                            key = row_list[key_idx]
                            value = row_list[val_idx]

                            if not str(key).strip(): # Skip rows with empty keys
                                continue
                            
                            translations[str(key)] = str(value) if value is not None else ""
                        except IndexError:
                            # This handles rows that are too short for the specified key/value indices
                            continue # Skip malformed/short rows silently, or raise ParsingError

        except FileNotFoundError:
            raise ParsingError(f"File not found.", filepath=file_path)
        except csv.Error as e: # Catch-all for csv specific errors (e.g. formatting, delimiter issues)
            raise ParsingError(f"CSV parsing error: {e}", filepath=file_path, original_exception=e)
        except Exception as e: # Catch other potential errors (e.g., permission errors, unexpected issues)
            raise ParsingError(f"An unexpected error occurred during CSV parsing: {e}", filepath=file_path, original_exception=e)
        
        return translations

    def get_supported_extensions(self) -> List[str]:
        return ['.csv']
