class TranslationParser:
    """Base class for all translation file parsers.
    
    This class defines the common interface that all parser implementations
    must follow. Subclasses should implement the parse method to handle
    specific file formats.
    """

    def parse(self, content: str) -> dict:
        """Parse the content and return a dictionary of translations.
        
        Args:
            content: The string content of the translation file to parse
            
        Returns:
            dict: A dictionary containing the parsed translations with keys as
                 translation identifiers and values as the translated strings
            
        Raises:
            NotImplementedError: This method must be implemented by subclasses
        """
        raise NotImplementedError("Subclasses must implement parse")
