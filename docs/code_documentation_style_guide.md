# Code Documentation Style Guide

This style guide outlines how code should be documented in the Localization Comparison Tool project to maintain consistency and clarity.

## General Principles

- Document all public modules, classes, methods, and functions
- Make documentation concise yet comprehensive
- Use proper English grammar and punctuation
- Keep comments up-to-date with code changes
- Document the "why" and "how" in addition to the "what"

## Python Docstrings

We use the [Google style](https://github.com/google/styleguide/blob/gh-pages/pyguide.md#38-comments-and-docstrings) for Python docstrings:

### Module Docstrings

Every Python module (.py file) should have a docstring at the top:

```python
"""
Module description and purpose.

This module provides functionality for...
"""
```

### Class Docstrings

```python
class ExampleClass:
    """Summary of class purpose and behavior.
    
    More detailed description of the class functionality,
    its attributes, its methods, and its usage.
    
    Attributes:
        attr1 (type): Description of attr1.
        attr2 (type): Description of attr2.
    """
```

### Function and Method Docstrings

```python
def example_function(param1, param2, optional_param=None):
    """Summary of function purpose.
    
    More detailed description of the function's purpose and behavior.
    
    Args:
        param1 (type): Description of param1.
        param2 (type): Description of param2.
        optional_param (type, optional): Description of optional_param. Defaults to None.
    
    Returns:
        type: Description of return value.
        
    Raises:
        ExceptionType: When and why this exception is raised.
    
    Examples:
        >>> example_function('a', 'b')
        'expected result'
    """
```

## Type Hints

Use Python's type hints in addition to docstrings:

```python
from typing import Dict, List, Optional, Tuple

def parse_file(file_path: str, file_format: Optional[str] = None) -> Dict[str, str]:
    """Parse a localization file and return key-value pairs."""
```

## Code Comments

- Use inline comments sparingly and only when necessary to explain complex sections
- Avoid obvious comments that duplicate what the code already states
- Use block comments for explaining algorithms or complex logic:

```python
# This algorithm works by:
# 1. First parsing the input files
# 2. Creating a mapping of keys to values
# 3. Comparing the maps to find differences
```

## Example Documentation

Here's an example of a well-documented function:

```python
def compare_files(source_file: str, target_file: str, 
                 file_format: Optional[str] = None) -> ComparisonResult:
    """Compare two localization files and identify differences.
    
    This function parses both files and compares the keys and values
    to identify added, removed, and modified translation strings.
    
    Args:
        source_file (str): Path to the source localization file.
        target_file (str): Path to the target localization file.
        file_format (str, optional): Format of the files. If None,
            the format will be inferred from file extensions. Defaults to None.
    
    Returns:
        ComparisonResult: An object containing the comparison results with
            added, removed, and modified entries.
    
    Raises:
        FileNotFoundError: If either source_file or target_file doesn't exist.
        UnsupportedFormatError: If the file format isn't supported.
    
    Examples:
        >>> result = compare_files('en_US.csv', 'fr_FR.csv')
        >>> print(f"Added: {len(result.added)}")
        Added: 5
    """
```

## Best Practices

1. **Document as you code**: Write documentation while writing the code, not after
2. **Keep it updated**: Update documentation when you change code
3. **Don't repeat code**: Documentation should explain the "why" and "how", not just repeat what the code does
4. **Document edge cases**: Be sure to document error conditions, exceptions, and edge cases
5. **Add examples**: Whenever possible, include usage examples

## Documentation Tools

Consider using these tools to help with documentation:

- [Sphinx](https://www.sphinx-doc.org/): For generating API documentation
- [pylint](https://www.pylint.org/) or [flake8](https://flake8.pycqa.org/): For checking docstring style
- [mypy](http://mypy-lang.org/): For checking type hints