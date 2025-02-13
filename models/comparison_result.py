from dataclasses import dataclass
from enum import Enum
from typing import Dict, List, Optional

class ChangeType(Enum):
    ADDED = "added"
    REMOVED = "removed"
    MODIFIED = "modified"

@dataclass
class Change:
    key: str
    old_value: Optional[str]
    new_value: Optional[str]
    type: ChangeType
    line_number: Optional[int] = None

class ComparisonResult:
    def __init__(self):
        self.changes: Dict[ChangeType, List[Change]] = {
            ChangeType.ADDED: [],
            ChangeType.REMOVED: [],
            ChangeType.MODIFIED: []
        }
        self.stats = {
            "added": 0,
            "removed": 0,
            "modified": 0
        }
    
    def add_change(self, change: Change):
        self.changes[change.type].append(change)
        self.stats[change.type.value] += 1
    
    def get_changes_by_type(self, change_type: ChangeType) -> List[Change]:
        return self.changes[change_type]
