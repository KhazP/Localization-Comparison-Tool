class TranslationParser:
    def parse(self, content: str) -> dict:
        """Parse the content and return a dictionary of translations."""
        raise NotImplementedError("Subclasses must implement parse")
