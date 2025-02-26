class ParsingError(Exception):
    """Base class for parsing related errors."""
    pass

class FileParsingError(ParsingError):
    """Base exception for file parsing issues."""
    pass

# Format-specific parsing errors
class CSVParsingError(FileParsingError):
    """Raised when CSV parsing fails."""
    pass

class XMLParsingError(FileParsingError):
    """Raised when XML parsing fails."""
    pass

class JSONParsingError(FileParsingError):
    """Raised when JSON parsing fails."""
    pass

class YAMLParsingError(FileParsingError):
    """Raised when YAML parsing fails."""
    pass

class PropertiesParsingError(FileParsingError):
    """Raised when .properties file parsing fails."""
    pass

class ResxParsingError(FileParsingError):
    """Raised when .resx file parsing fails."""
    pass

class LangParsingError(FileParsingError):
    """Raised when .lang file parsing fails."""
    pass

class XliffParsingError(FileParsingError):
    """Raised when XLIFF file parsing fails."""
    pass

class UnknownFormatError(FileParsingError):
    """Raised when file format is not recognized."""
    pass
