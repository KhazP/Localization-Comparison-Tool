class BaseLocalizerError(Exception):
    """Base class for exceptions in this application."""
    pass

class ParsingError(BaseLocalizerError):
    """Raised when a file cannot be parsed."""
    def __init__(self, message, filepath=None, original_exception=None):
        super().__init__(message)
        self.filepath = filepath
        self.original_exception = original_exception
    
    def __str__(self):
        msg = super().__str__()
        if self.filepath:
            msg = f"{msg} (File: {self.filepath})"
        if self.original_exception:
            msg = f"{msg}\nOriginal error: {self.original_exception}"
        return msg

class UnsupportedFormatError(BaseLocalizerError):
    """Raised when a file format is not supported by a parser."""
    def __init__(self, message, filepath=None):
        super().__init__(message)
        self.filepath = filepath

    def __str__(self):
        msg = super().__str__()
        if self.filepath:
            msg = f"{msg} (File: {self.filepath})"
        return msg
