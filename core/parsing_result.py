from typing import Dict, Optional, Any, List

class ParsingResult:
    """
    Represents the result of a parsing operation.
    """
    def __init__(self,
                 translations: Dict[str, str],
                 line_numbers: Optional[Dict[str, int]] = None,
                 metadata: Optional[Dict[str, Any]] = None,
                 errors: Optional[List[str]] = None,
                 warnings: Optional[List[str]] = None):
        """
        Initializes the ParsingResult.

        Args:
            translations: A dictionary of translation keys to their string values.
            line_numbers: An optional dictionary mapping translation keys to their line numbers in the source file.
            metadata: An optional dictionary for any other parser-specific metadata
                      (e.g., plurals, comments, language codes).
            errors: An optional list of critical error messages encountered during parsing.
            warnings: An optional list of non-critical warning messages encountered during parsing.
        """
        self.translations: Dict[str, str] = translations
        self.line_numbers: Optional[Dict[str, int]] = line_numbers if line_numbers is not None else {}
        self.metadata: Optional[Dict[str, Any]] = metadata if metadata is not None else {}
        self.errors: Optional[List[str]] = errors if errors is not None else []
        self.warnings: Optional[List[str]] = warnings if warnings is not None else []

    def __repr__(self) -> str:
        return (f"ParsingResult(translations_count={len(self.translations)}, "
                f"has_line_numbers={bool(self.line_numbers)}, "
                f"metadata_keys={list(self.metadata.keys()) if self.metadata else []}, "
                f"errors_count={len(self.errors)}, "
                f"warnings_count={len(self.warnings)})")

    def __bool__(self) -> bool:
        """
        Consider the result successful if there are translations and no critical errors (implicitly).
        Actual error state might be more nuanced based on the 'errors' list content.
        """
        return bool(self.translations)
