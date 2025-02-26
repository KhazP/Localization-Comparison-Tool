import json
from pathlib import Path
from typing import Dict, Any, Optional
from dataclasses import dataclass
import difflib
import flet as ft

@dataclass
class SnapshotMismatch:
    """Contains details about a snapshot mismatch"""
    path: str
    expected: Any
    actual: Any
    diff: str

class SnapshotComparator:
    """Handles snapshot comparison with detailed diff reporting"""
    
    def __init__(self, snapshot_dir: str):
        self.snapshot_dir = Path(snapshot_dir)
        self.snapshot_dir.mkdir(exist_ok=True, parents=True)
        
    def compare(self, data: Dict, name: str, update: bool = False) -> Optional[SnapshotMismatch]:
        """
        Compare data with saved snapshot.
        
        Args:
            data: The data to compare
            name: Name of the snapshot
            update: Whether to update existing snapshots
            
        Returns:
            SnapshotMismatch if comparison fails, None if successful
        """
        snapshot_path = self.snapshot_dir / f"{name}.json"
        
        if not snapshot_path.exists() or update:
            self._save_snapshot(data, snapshot_path)
            return None
            
        with open(snapshot_path, 'r') as f:
            saved_data = json.load(f)
            
        if data != saved_data:
            diff = self._generate_diff(saved_data, data)
            return SnapshotMismatch(
                path=str(snapshot_path),
                expected=saved_data,
                actual=data,
                diff=diff
            )
            
        return None
        
    def _save_snapshot(self, data: Dict, path: Path):
        """Save data as a snapshot file"""
        with open(path, 'w') as f:
            json.dump(data, f, indent=2, sort_keys=True)
            
    def _generate_diff(self, expected: Dict, actual: Dict) -> str:
        """Generate a readable diff between expected and actual data"""
        expected_lines = json.dumps(expected, indent=2, sort_keys=True).splitlines()
        actual_lines = json.dumps(actual, indent=2, sort_keys=True).splitlines()
        
        diff = difflib.unified_diff(
            expected_lines,
            actual_lines,
            fromfile='expected',
            tofile='actual',
            lineterm=''
        )
        
        return '\n'.join(diff)

def _format_value(value):
    """Helper function to format special types"""
    if isinstance(value, (int, float, str, bool)) or value is None:
        return value
    elif isinstance(value, (list, tuple)):
        return [_format_value(item) for item in value]
    elif isinstance(value, dict):
        return {k: _format_value(v) for k, v in value.items()}
    else:
        # Convert custom objects to their string representation or a dict
        try:
            return value.to_dict() if hasattr(value, 'to_dict') else str(value)
        except:
            return str(value)

def format_component(component) -> Dict:
    """Format a Flet component for snapshot testing"""
    if component is None:
        return None
        
    result = {
        "type": component.__class__.__name__
    }
    
    # Handle all common properties
    properties = [
        "text", "value", "disabled", "visible", "tooltip", "color", 
        "bgcolor", "width", "height", "expand", "alignment", "spacing",
        "horizontal_alignment", "vertical_alignment", "weight", "size",
        "font_family", "icon", "icon_color", "min_lines", "max_lines",
        "read_only", "multiline", "border_radius", "elevation",
        "scroll", "wrap", "opacity", "offset", "animate", "blur",
        "rotate", "scale", "selected_index", "label", "hint_text"
    ]
    
    for prop in properties:
        if hasattr(component, prop):
            value = getattr(component, prop)
            if value is not None:
                result[prop] = _format_value(value)
    
    # Handle special properties that need conversion
    if hasattr(component, "padding") and component.padding:
        if isinstance(component.padding, (int, str)):
            result["padding"] = component.padding
        else:
            result["padding"] = {
                "left": component.padding.left,
                "top": component.padding.top,
                "right": component.padding.right,
                "bottom": component.padding.bottom
            }
            
    if hasattr(component, "margin") and component.margin:
        if isinstance(component.margin, (int, str)):
            result["margin"] = component.margin
        else:
            result["margin"] = {
                "left": component.margin.left,
                "top": component.margin.top,
                "right": component.margin.right,
                "bottom": component.margin.bottom
            }
            
    if hasattr(component, "border") and component.border:
        if isinstance(component.border, (str, int)):
            result["border"] = component.border
        else:
            try:
                result["border"] = {
                    "width": component.border.width,
                    "color": component.border.color,
                }
            except AttributeError:
                result["border"] = {
                    "top": {"width": component.border.top.width, "color": component.border.top.color},
                    "right": {"width": component.border.right.width, "color": component.border.right.color},
                    "bottom": {"width": component.border.bottom.width, "color": component.border.bottom.color},
                    "left": {"width": component.border.left.width, "color": component.border.left.color}
                }
    
    # Handle list properties
    list_properties = ["data", "tabs", "items"]
    for prop in list_properties:
        if hasattr(component, prop) and getattr(component, prop):
            result[prop] = _format_value(getattr(component, prop))
    
    # Handle controls recursively
    if hasattr(component, "controls") and component.controls:
        result["controls"] = [
            format_component(control) for control in component.controls
        ]
        
    # Handle content recursively
    if hasattr(component, "content") and component.content:
        result["content"] = format_component(component.content)
        
    return result