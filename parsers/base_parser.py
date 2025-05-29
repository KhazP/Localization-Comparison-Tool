from abc import ABC, abstractmethod
from typing import Dict, List

class BaseParser(ABC):
    @abstractmethod
    def parse(self, file_path: str) -> Dict[str, str]:
        """Parses the given file and returns a dictionary of key-value pairs."""
        pass

    @abstractmethod
    def get_supported_extensions(self) -> List[str]:
        """Returns a list of file extensions supported by this parser (e.g., ['.json', '.yaml'])."""
        pass
