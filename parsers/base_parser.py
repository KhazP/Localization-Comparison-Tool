from core.parsing_result import ParsingResult

class TranslationParser:
    """Base class for all translation file parsers.

    This class defines the common interface that all parser implementations
    must follow. Subclasses should implement the parse method to handle
    specific file formats.
    """

    def parse(self, content: str) -> ParsingResult:
        """Parse the content and return a ParsingResult object.
        
        Args:
            content: The string content of the translation file to parse
            
        Returns:
            ParsingResult: An object containing the parsed translations,
                           line numbers, metadata, and any errors.
            
        Raises:
            NotImplementedError: This method must be implemented by subclasses
        """
        raise NotImplementedError("Subclasses must implement parse")
