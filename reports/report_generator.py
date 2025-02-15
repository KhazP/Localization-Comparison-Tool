import csv
import os
from datetime import datetime
from typing import Dict, List, Tuple
from pathlib import Path

class ReportGenerator:
    @staticmethod
    def generate_csv_report(data: Dict[str, List[Tuple[str, str]]], source_file: str, target_file: str) -> str:
        """Generate a CSV report from comparison data"""
        output = []
        headers = ["Type", "Key", "Source Value", "Target Value", "Status"]
        
        # Add metadata
        metadata = [
            ["Report Generated", datetime.now().strftime("%Y-%m-%d %H:%M:%S")],
            ["Source File", source_file],
            ["Target File", target_file],
            [],  # Empty line
            headers
        ]
        output.extend(metadata)
        
        # Add missing keys
        for key, value in data.get("missing", []):
            output.append(["Missing", key, value, "", "Key not found in target"])
            
        # Add obsolete keys
        for key, value in data.get("obsolete", []):
            output.append(["Obsolete", key, "", value, "Key not found in source"])
            
        # Add modified/changed keys
        for key, (source_val, target_val) in data.get("modified", []):
            output.append(["Modified", key, source_val, target_val, "Values differ"])
        
        return output

    @staticmethod
    def generate_html_report(data: Dict[str, List[Tuple[str, str]]], source_file: str, target_file: str) -> str:
        """Generate an HTML report from comparison data"""
        html_template = """
        <!DOCTYPE html>
        <html>
        <head>
            <title>Localization Comparison Report</title>
            <style>
                body { font-family: Arial, sans-serif; margin: 20px; }
                table { border-collapse: collapse; width: 100%; margin-top: 20px; }
                th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
                th { background-color: #f5f5f5; }
                .missing { background-color: #ffebee; }
                .obsolete { background-color: #e8f5e9; }
                .modified { background-color: #fff3e0; }
                .metadata { margin-bottom: 20px; }
            </style>
        </head>
        <body>
            <div class="metadata">
                <h2>Localization Comparison Report</h2>
                <p><strong>Generated:</strong> {timestamp}</p>
                <p><strong>Source File:</strong> {source_file}</p>
                <p><strong>Target File:</strong> {target_file}</p>
            </div>
            
            <table>
                <tr>
                    <th>Type</th>
                    <th>Key</th>
                    <th>Source Value</th>
                    <th>Target Value</th>
                    <th>Status</th>
                </tr>
                {rows}
            </table>
        </body>
        </html>
        """
        
        rows = []
        
        # Add missing keys
        for key, value in data.get("missing", []):
            rows.append(f"""
                <tr class="missing">
                    <td>Missing</td>
                    <td>{key}</td>
                    <td>{value}</td>
                    <td></td>
                    <td>Key not found in target</td>
                </tr>
            """)
        
        # Add obsolete keys
        for key, value in data.get("obsolete", []):
            rows.append(f"""
                <tr class="obsolete">
                    <td>Obsolete</td>
                    <td>{key}</td>
                    <td></td>
                    <td>{value}</td>
                    <td>Key not found in source</td>
                </tr>
            """)
        
        # Add modified keys
        for key, (source_val, target_val) in data.get("modified", []):
            rows.append(f"""
                <tr class="modified">
                    <td>Modified</td>
                    <td>{key}</td>
                    <td>{source_val}</td>
                    <td>{target_val}</td>
                    <td>Values differ</td>
                </tr>
            """)
            
        return html_template.format(
            timestamp=datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
            source_file=source_file,
            target_file=target_file,
            rows="\n".join(rows)
        )

    @staticmethod
    def parse_report(report_path: str) -> Dict[str, List[Tuple[str, str]]]:
        """Parse a saved report file and return structured data"""
        ext = Path(report_path).suffix.lower()
        data = {"missing": [], "obsolete": [], "modified": []}
        
        if ext == '.csv':
            with open(report_path, 'r', encoding='utf-8') as f:
                reader = csv.reader(f)
                # Skip metadata and headers
                for _ in range(5):
                    next(reader)
                    
                for row in reader:
                    if len(row) >= 5:
                        type_, key, source_val, target_val, _ = row
                        if type_ == "Missing":
                            data["missing"].append((key, source_val))
                        elif type_ == "Obsolete":
                            data["obsolete"].append((key, target_val))
                        elif type_ == "Modified":
                            data["modified"].append((key, (source_val, target_val)))
        
        return data

from pathlib import Path
import json
from datetime import datetime
from typing import Dict, Any

class ReportGenerator:
    def generate_report(self, comparison_data: Dict[str, Any], output_path: str, 
                       source_file: str = "", target_file: str = "") -> bool:
        """Generate a report from comparison data"""
        try:
            ext = Path(output_path).suffix.lower()
            
            if ext == '.html':
                return self._generate_html_report(comparison_data, output_path, source_file, target_file)
            elif ext == '.md':
                return self._generate_markdown_report(comparison_data, output_path, source_file, target_file)
            else:  # fallback to text
                return self._generate_text_report(comparison_data, output_path, source_file, target_file)
                
        except Exception as e:
            print(f"Error generating report: {str(e)}")
            return False

    def _generate_html_report(self, data: Dict[str, Any], output_path: str, 
                            source_file: str, target_file: str) -> bool:
        """Generate an HTML report"""
        template = """
        <!DOCTYPE html>
        <html>
        <head>
            <title>Localization Comparison Report</title>
            <style>
                body { font-family: Arial, sans-serif; margin: 20px; }
                .missing { color: #EF4444; }
                .obsolete { color: #22C55E; }
                .modified { color: #3B82F6; }
                .section { margin: 20px 0; }
                table { border-collapse: collapse; width: 100%; }
                th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
                th { background-color: #f8f9fa; }
            </style>
        </head>
        <body>
            <h1>Localization Comparison Report</h1>
            <p>Generated on: {date}</p>
            <p>Source file: {source_file}</p>
            <p>Target file: {target_file}</p>
            
            <div class="section">
                <h2>Missing Translations ({missing_count})</h2>
                <table>
                    <tr><th>Key</th><th>Source Value</th></tr>
                    {missing_rows}
                </table>
            </div>
            
            <div class="section">
                <h2>Obsolete Translations ({obsolete_count})</h2>
                <table>
                    <tr><th>Key</th><th>Target Value</th></tr>
                    {obsolete_rows}
                </table>
            </div>
            
            <div class="section">
                <h2>Modified Translations ({modified_count})</h2>
                <table>
                    <tr><th>Key</th><th>Source Value</th><th>Target Value</th></tr>
                    {modified_rows}
                </table>
            </div>
        </body>
        </html>
        """
        
        missing_rows = "\n".join(f"<tr><td>{key}</td><td>{value}</td></tr>" 
                               for key, value in data["missing"])
        obsolete_rows = "\n".join(f"<tr><td>{key}</td><td>{value}</td></tr>" 
                                for key, value in data["obsolete"])
        modified_rows = "\n".join(f"<tr><td>{key}</td><td>{source}</td><td>{target}</td></tr>" 
                                for key, (source, target) in data["modified"])
        
        content = template.format(
            date=datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
            source_file=source_file,
            target_file=target_file,
            missing_count=len(data["missing"]),
            obsolete_count=len(data["obsolete"]),
            modified_count=len(data["modified"]),
            missing_rows=missing_rows,
            obsolete_rows=obsolete_rows,
            modified_rows=modified_rows
        )
        
        with open(output_path, 'w', encoding='utf-8') as f:
            f.write(content)
            
        return True

    def _generate_markdown_report(self, data: Dict[str, Any], output_path: str, 
                                source_file: str, target_file: str) -> bool:
        """Generate a Markdown report"""
        template = """# Localization Comparison Report

Generated on: {date}
Source file: {source_file}
Target file: {target_file}

## Missing Translations ({missing_count})

| Key | Source Value |
|-----|--------------|
{missing_rows}

## Obsolete Translations ({obsolete_count})

| Key | Target Value |
|-----|--------------|
{obsolete_rows}

## Modified Translations ({modified_count})

| Key | Source Value | Target Value |
|-----|--------------|--------------|
{modified_rows}
"""
        
        missing_rows = "\n".join(f"| {key} | {value} |" 
                               for key, value in data["missing"])
        obsolete_rows = "\n".join(f"| {key} | {value} |" 
                                for key, value in data["obsolete"])
        modified_rows = "\n".join(f"| {key} | {source} | {target} |" 
                                for key, (source, target) in data["modified"])
        
        content = template.format(
            date=datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
            source_file=source_file,
            target_file=target_file,
            missing_count=len(data["missing"]),
            obsolete_count=len(data["obsolete"]),
            modified_count=len(data["modified"]),
            missing_rows=missing_rows,
            obsolete_rows=obsolete_rows,
            modified_rows=modified_rows
        )
        
        with open(output_path, 'w', encoding='utf-8') as f:
            f.write(content)
            
        return True

    def _generate_text_report(self, data: Dict[str, Any], output_path: str, 
                            source_file: str, target_file: str) -> bool:
        """Generate a plain text report"""
        content = [
            "Localization Comparison Report",
            "===========================",
            f"Generated on: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}",
            f"Source file: {source_file}",
            f"Target file: {target_file}",
            "",
            f"Missing Translations ({len(data['missing'])})",
            "-" * 30
        ]
        
        for key, value in data["missing"]:
            content.extend([f"Key: {key}", f"Value: {value}", ""])
            
        content.extend([
            f"Obsolete Translations ({len(data['obsolete'])})",
            "-" * 30
        ])
        
        for key, value in data["obsolete"]:
            content.extend([f"Key: {key}", f"Value: {value}", ""])
            
        content.extend([
            f"Modified Translations ({len(data['modified'])})",
            "-" * 30
        ])
        
        for key, (source, target) in data["modified"]:
            content.extend([
                f"Key: {key}",
                f"Source: {source}",
                f"Target: {target}",
                ""
            ])
            
        with open(output_path, 'w', encoding='utf-8') as f:
            f.write("\n".join(content))
            
        return True
