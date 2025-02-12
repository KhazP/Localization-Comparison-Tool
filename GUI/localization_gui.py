import tkinter as tk
from tkinter import filedialog, messagebox
from tkinter import ttk  # Use ttk for modern themed widgets
import os
import csv
import git
import xml.etree.ElementTree as ET
from colorama import init, Fore, Style
import sys

# Initialize colorama for command-line output
init()

VALID_COLORS = [
    "black", "red", "green", "yellow", "blue", "magenta", "cyan", "white",
    "lightblack_ex", "lightred_ex", "lightgreen_ex", "lightyellow_ex",
    "lightblue_ex", "lightmagenta_ex", "lightcyan_ex", "lightwhite_ex"
]

def get_color(color_name):
    """Gets the colorama Fore color object from a color name (case-insensitive)."""
    color_name = color_name.lower()
    if color_name not in VALID_COLORS:
        return None
    return getattr(Fore, color_name.upper())

def read_csv_file(filepath, delimiter=None, has_header=True, key_column='key', value_column='value'):
    """Reads CSV data with improved auto-delimiter detection."""
    translations = {}
    try:
        with open(filepath, "r", encoding="utf-8", newline='') as f:
            content = f.read()

            # Auto-detect if delimiter is empty/None or set to 'auto'
            if not delimiter or delimiter.lower() == 'auto':
                try:
                    dialect = csv.Sniffer().sniff(content[:1024])
                    delimiter = dialect.delimiter
                    print(f"Auto-detected delimiter: {repr(delimiter)}")  # Debug
                except csv.Error as e:
                    messagebox.showwarning("Warning", 
                        f"Could not detect delimiter: {e}. Using fallback ','")
                    delimiter = ','

            if has_header:
                reader = csv.DictReader(content.splitlines(), delimiter=delimiter)
                if key_column not in reader.fieldnames or value_column not in reader.fieldnames:
                    messagebox.showwarning("Warning", "CSV data is missing specified key/value columns.")
                    return {}
                for row_number, row in enumerate(reader, start=1):
                    try:
                        translations[row[key_column]] = row[value_column]
                    except KeyError:
                        messagebox.showerror("Error", "Missing key or value column in CSV data.")
                        return {}
            else:
                reader = csv.reader(content.splitlines(), delimiter=delimiter)
                # ... (rest of no-header CSV reading logic - no changes) ...

    except FileNotFoundError:
        messagebox.showerror("Error", f"File not found: {filepath}")
        return {}
    except Exception as e:
        messagebox.showerror("Error", f"An unexpected error occurred: {e}")
        return {}
    return translations

def read_lang_file(content, trim_whitespace=False):
    """Reads a plain text .lang file (key=value format) and returns a dictionary."""
    translations = {}
    try:
        for line_number, line in enumerate(content.splitlines(), start=1):
            line = line.strip()
            if line and not line.startswith("#"):
                try:
                    key, value = line.split("=", 1)
                    if trim_whitespace:
                        key = key.strip()
                        value = value.strip()
                    translations[key] = value
                except ValueError:
                    messagebox.showerror("Error",f"Invalid key-value pair in .lang file at line {line_number}")
                    return {}
    except Exception as e:
        messagebox.showerror("Error",f"An unexpected error occurred while reading the .lang file: {e}")
        return {}
    return translations

def read_xml_lang_file(filepath, trim_whitespace=False):
    """Reads a .lang file (XML format), preprocesses it, and returns a dictionary."""
    translations = {}
    try:
        with open(filepath, "r", encoding="utf-8") as f:
            content = f.read()
        # --- Pre-processing ---
        content = content.replace("&", "&")  # Correct escaping
        content = content.replace("&amp;", "&") # Fix double escapes
        try:
            root = ET.fromstring(content)
        except ET.ParseError as e:
            messagebox.showerror("Error", f"Error parsing XML in '{filepath}': {e}")
            return {}
        for string_elem in root.findall('string'):
            key = string_elem.get('name')
            value = string_elem.text
            if key is not None:
                if trim_whitespace:
                    if value is not None:
                        value = value.strip()
                    key = key.strip()
                translations[key] = value
    except FileNotFoundError:
        messagebox.showerror("Error", f"File not found: {filepath}")
        return {}
    except Exception as e:
        messagebox.showerror("Error", f"An unexpected error occurred: {e}")
        return {}
    return translations

def get_file_content(repo_path, file_path, commit_id):
    """Fetches the content of a file from a Git repository at a specific commit."""
    try:
        repo = git.Repo(repo_path, search_parent_directories=True)
        if commit_id == "working":
            # Read from the working tree (uncommitted changes)
            with open(os.path.join(repo.working_tree_dir, file_path), "r", encoding="utf-8") as f:
                content = f.read()
        else:
            commit = repo.commit(commit_id)
            blob = commit.tree / file_path
            content = blob.data_stream.read().decode("utf-8")
        return content
    except git.InvalidGitRepositoryError:
        messagebox.showerror("Error", f"Not a git repository: {repo_path}")
        return {}  # Return empty dict on error
    except git.NoSuchPathError:
        messagebox.showerror("Error", f"File not found in repository: {file_path}")
        return {}
    except (git.BadName, ValueError) as e:
        messagebox.showerror("Error", f"Invalid commit ID or file not found in commit: {commit_id}")
        return {}
    except FileNotFoundError:
        messagebox.showerror("Error", f"File not found in working tree: {file_path}")
        return {}
    except Exception as e:
        messagebox.showerror("Error", f"An unexpected error occurred: {e}")
        return {}

def compare_translations(old_translations, new_translations, ignore_case=False, ignore_whitespace=False, is_gui=False, compare_values=False):
    """Compare two translation dictionaries and return a formatted string of differences."""
    # Initialize variables
    output_lines = []
    added_count = 0
    removed_count = 0
    modified_count = 0
    
    # Get sets of keys
    old_keys = set(old_translations.keys())
    new_keys = set(new_translations.keys())
    
    # Find added and removed keys
    added_keys = new_keys - old_keys
    removed_keys = old_keys - new_keys
    common_keys = old_keys & new_keys

    # Calculate maximum key length for formatting
    all_keys = old_keys | new_keys
    max_key_length = max((len(key) for key in all_keys), default=0)

    # Show removed keys
    if removed_keys:
        output_lines.append("\n--- Removed Keys ---")
        for key in sorted(removed_keys):
            if is_gui:
                output_lines.append(f"- {key.ljust(max_key_length)} : {old_translations[key]}")
            else:
                output_lines.append(Fore.RED + f"- {key.ljust(max_key_length)} : {old_translations[key]}" + Style.RESET_ALL)
            removed_count += 1

    # Show added keys
    if added_keys:
        output_lines.append("\n--- Added Keys ---")
        for key in sorted(added_keys):
            if is_gui:
                output_lines.append(f"+ {key.ljust(max_key_length)} : {new_translations[key]}")
            else:
                output_lines.append(Fore.GREEN + f"+ {key.ljust(max_key_length)} : {new_translations[key]}" + Style.RESET_ALL)
            added_count += 1

    # Modified and unchanged keys
    if compare_values:  # Only process common keys IF compare_values is True
        output_lines.append("\n--- Modified Values ---")
        for key in sorted(common_keys):
            old_value = old_translations[key]
            new_value = new_translations[key]

            if ignore_case:
                old_value = old_value.lower()
                new_value = new_value.lower()

            if ignore_whitespace:
                old_value = old_value.strip()
                new_value = new_value.strip()

            if old_value == new_value:
                output_lines.append(f"  {key.ljust(max_key_length)} : {old_translations[key]}")  # Unchanged
            else:
                # Modified: Show old and new values
                if is_gui:
                    output_lines.append(f"M {key.ljust(max_key_length)} : {old_translations[key]}")
                    output_lines.append(f"  {key.ljust(max_key_length)} : {new_translations[key]}")
                else:
                    output_lines.append(Fore.YELLOW + f"- {key.ljust(max_key_length)} : {old_translations[key]}" + Style.RESET_ALL)
                    output_lines.append(Fore.YELLOW + f"+ {key.ljust(max_key_length)} : {new_translations[key]}" + Style.RESET_ALL)
                modified_count += 1

    output_lines.append("\n--- Summary ---")
    output_lines.append(f"Added:     {added_count}")
    output_lines.append(f"Removed:   {removed_count}")
    if compare_values:
        output_lines.append(f"Modified:  {modified_count}")
    
    return "\n".join(output_lines)


class ToolTip:
    """Creates a tooltip for a given widget."""
    def __init__(self, widget, text):
        self.widget = widget
        self.text = text
        self.tooltip_window = None
        self.widget.bind("<Enter>", self.show_tooltip)
        self.widget.bind("<Leave>", self.hide_tooltip)

    def show_tooltip(self, event=None):
        x, y, _, _ = self.widget.bbox("insert")
        x += self.widget.winfo_rootx() + 25
        y += self.widget.winfo_rooty() + 25
        # creates a toplevel window
        self.tooltip_window = tk.Toplevel(self.widget)
        # Leaves only the border of the toplevel window
        self.tooltip_window.wm_overrideredirect(True)
        label = ttk.Label(self.tooltip_window, text=self.text, background="#f9f9f9", relief=tk.SOLID, borderwidth=1, padding=(5, 5))
        label.pack()
        self.tooltip_window.wm_geometry(f"+{x}+{y}")

    def hide_tooltip(self, event=None):
        tooltip_window = self.tooltip_window
        if tooltip_window:
            tooltip_window.destroy()
        self.tooltip_window = None

class App:
    def __init__(self, master):
        self.master = master
        master.title("Localization Comparison Tool - Modern")
        
        # --- Modern Theme Settings ---
        self.style = ttk.Style()
        self.style.theme_use('vista')  # More modern than 'xpnative'
        
        # Configure colors and fonts
        self.style.configure('TFrame', background='#f0f0f0')
        self.style.configure('TLabel', background='#f0f0f0', font=('Segoe UI', 9))
        self.style.configure('TButton', font=('Segoe UI', 9))
        self.style.configure('TNotebook.Tab', font=('Segoe UI', 9, 'bold'))

        # --- Main Container ---
        self.main_frame = ttk.Frame(master)
        self.main_frame.grid(row=0, column=0, sticky="nsew", padx=10, pady=10)
        
        # --- Notebook (Tabs) ---
        self.tabs = ttk.Notebook(self.main_frame)
        self.tabs.grid(row=2, column=0, columnspan=3, sticky="ew", pady=10)

        # Create tab frames
        self.file_tab = ttk.Frame(self.tabs)
        self.git_tab = ttk.Frame(self.tabs)
        self.csv_tab = ttk.Frame(self.tabs)
        
        self.tabs.add(self.file_tab, text="File Options")
        self.tabs.add(self.git_tab, text="Git Options")
        self.tabs.add(self.csv_tab, text="CSV Options")

        # --- File Selection (Now in File Options tab) ---
        ttk.Label(self.file_tab, text="Source File:").grid(row=0, column=0, sticky="e", padx=5, pady=5)
        self.old_file_entry = ttk.Entry(self.file_tab, width=50)
        self.old_file_entry.grid(row=0, column=1, padx=5, pady=5)
        ttk.Button(self.file_tab, text="Browse", command=lambda: self.browse_file("old")).grid(row=0, column=2, padx=5, pady=5)

        ttk.Label(self.file_tab, text="Target File:").grid(row=1, column=0, sticky="e", padx=5, pady=5)
        self.new_file_entry = ttk.Entry(self.file_tab, width=50)
        self.new_file_entry.grid(row=1, column=1, padx=5, pady=5)
        ttk.Button(self.file_tab, text="Browse", command=lambda: self.browse_file("new")).grid(row=1, column=2, padx=5, pady=5)

        # --- Git Options (Moved to Git Tab) ---
        ttk.Label(self.git_tab, text="Repository Path:").grid(row=0, column=0, sticky="e", padx=5, pady=5)
        self.git_repo_entry = ttk.Entry(self.git_tab, width=50)
        self.git_repo_entry.grid(row=0, column=1, padx=5, pady=5)
        ttk.Button(self.git_tab, text="Browse", command=lambda: self.browse_directory("git")).grid(row=0, column=2, padx=5, pady=5)

        ttk.Label(self.git_tab, text="Commit/Branch:").grid(row=1, column=0, sticky="e", padx=5, pady=5)
        self.git_commit_entry = ttk.Entry(self.git_tab, width=50)
        self.git_commit_entry.insert(0, "main")
        self.git_commit_entry.grid(row=1, column=1, padx=5, pady=5)

        # --- CSV Options (Moved to CSV Tab) ---
        ttk.Label(self.csv_tab, text="Delimiter:").grid(row=0, column=0, sticky="e", padx=5, pady=5)
        self.csv_delimiter_entry = ttk.Entry(self.csv_tab, width=5)
        self.csv_delimiter_entry.insert(0, "")  # Empty for auto-detection
        ToolTip(self.csv_delimiter_entry, "Leave empty for auto-detection\nor enter: , ; | \\t etc.")

        self.csv_no_header_var = tk.BooleanVar()
        ttk.Checkbutton(self.csv_tab, text="No Header Row", variable=self.csv_no_header_var).grid(row=0, column=2, padx=5, pady=5, sticky="w")

        ttk.Label(self.csv_tab, text="Key Column:").grid(row=1, column=0, sticky="e", padx=5, pady=5)
        self.csv_key_column_entry = ttk.Entry(self.csv_tab, width=15)
        self.csv_key_column_entry.insert(0, "key")
        self.csv_key_column_entry.grid(row=1, column=1, padx=5, pady=5, sticky="w")

        ttk.Label(self.csv_tab, text="Value Column:").grid(row=1, column=2, sticky="e", padx=5, pady=5)
        self.csv_value_column_entry = ttk.Entry(self.csv_tab, width=15)
        self.csv_value_column_entry.insert(0, "value")
        self.csv_value_column_entry.grid(row=1, column=3, padx=5, pady=5, sticky="w")

        # --- Status Bar ---
        self.status_label = ttk.Label(self.main_frame, text="Ready", relief=tk.SUNKEN, anchor=tk.W)
        self.status_label.grid(row=6, column=0, columnspan=2, sticky=tk.EW, pady=(0, 5))

        # --- Comparison Options (Under Main Frame) ---
        options_frame = ttk.Frame(self.main_frame)
        options_frame.grid(row=3, column=0, pady=10, sticky="w")

        self.ignore_case_var = tk.BooleanVar()
        ttk.Checkbutton(options_frame, text="Ignore Case", variable=self.ignore_case_var).pack(side=tk.LEFT, padx=10)
        
        self.ignore_whitespace_var = tk.BooleanVar()
        ttk.Checkbutton(options_frame, text="Ignore Whitespace", variable=self.ignore_whitespace_var).pack(side=tk.LEFT, padx=10)
        
        self.only_missing_var = tk.BooleanVar(value=True)
        ttk.Checkbutton(options_frame, text="Only Missing Keys", variable=self.only_missing_var).pack(side=tk.LEFT, padx=10)

        # --- Compare Button ---
        ttk.Button(self.main_frame, text="Compare Translations", style='Accent.TButton', 
                 command=self.compare_files).grid(row=4, column=0, pady=15)

        # --- Output Area ---
        self.output_text = tk.Text(self.main_frame, wrap=tk.WORD, width=100, height=25,
                                 font=('Consolas', 10), bg='#ffffff', fg='#333333')
        self.output_text.grid(row=5, column=0, sticky="nsew")
        
        # Add scrollbar
        scrollbar = ttk.Scrollbar(self.main_frame, orient=tk.VERTICAL, command=self.output_text.yview)
        scrollbar.grid(row=5, column=1, sticky='ns')
        self.output_text.config(yscrollcommand=scrollbar.set)

        # --- Configure Grid Resizing ---
        master.grid_rowconfigure(0, weight=1)
        master.grid_columnconfigure(0, weight=1)
        self.main_frame.grid_rowconfigure(5, weight=1)  # Output area
        self.main_frame.grid_rowconfigure(6, weight=0)  # Status bar
        self.main_frame.grid_columnconfigure(0, weight=1)

        # Add some padding to all widgets
        for child in self.main_frame.winfo_children():
            child.grid_configure(padx=5, pady=5)

    def browse_directory(self, dir_type):
        directory = filedialog.askdirectory()
        if directory:
            if dir_type == "git":
                self.git_repo_entry.delete(0, tk.END)
                self.git_repo_entry.insert(0, directory)

    def browse_file(self, file_type):
        filepath = filedialog.askopenfilename(
            filetypes=[("CSV Files", "*.csv"), ("LANG Files", "*.lang"), ("Text Files", "*.txt"), ("All Files", "*.*")]
        )
        if filepath:
            if file_type == "old":
                self.old_file_entry.delete(0, tk.END)
                self.old_file_entry.insert(0, filepath)
            elif file_type == "new":
                self.new_file_entry.delete(0, tk.END)
                self.new_file_entry.insert(0, filepath)

    def compare_files(self):
        old_filepath = self.old_file_entry.get()
        new_filepath = self.new_file_entry.get()

        if not old_filepath or not new_filepath:
            messagebox.showerror("Error", "Please select both old and new files.")
            return

        # Use lower-case extensions for comparison
        old_ext = os.path.splitext(old_filepath)[1].lower()
        new_ext = os.path.splitext(new_filepath)[1].lower()

        if old_ext != new_ext:
            messagebox.showerror("Error", "The old and new files must have the same file extension.")
            return

        trim_whitespace = False  # TODO: add a checkbox option for this if needed

        csv_delimiter = self.csv_delimiter_entry.get()
        if not csv_delimiter:
            self.status_label.config(text="CSV: Auto-detecting delimiter...")
        else:
            self.status_label.config(text=f"CSV: Using delimiter '{csv_delimiter}'")
        self.csv_delimiter_entry.update_idletasks()  # Added to ensure the entry is updated
        csv_no_header = self.csv_no_header_var.get()
        csv_key_column = self.csv_key_column_entry.get()
        csv_value_column = self.csv_value_column_entry.get()

        print(f"DEBUG: Delimiter from GUI: '{csv_delimiter}'") # Debug print <--- ADDED
        old_is_git = bool(self.git_repo_entry.get())
        new_is_git = old_is_git  # Simple assumption for now
        
        try:
            old_translations = self.get_translations(old_filepath, old_is_git)
            new_translations = self.get_translations(new_filepath, new_is_git)
        except Exception as e:
            self.status_label.config(text="Error loading files")
            messagebox.showerror("Error", f"Failed to load files: {str(e)}")
            return

        # Compare translations and update output
        if old_translations and new_translations:
            compare_values = not self.only_missing_var.get()
            result = compare_translations(
                old_translations,
                new_translations,
                ignore_case=self.ignore_case_var.get(),
                ignore_whitespace=self.ignore_whitespace_var.get(),
                is_gui=True,
                compare_values=compare_values
            )
            self.output_text.config(state=tk.NORMAL)
            self.output_text.delete("1.0", tk.END)
            self.output_text.insert("1.0", result)
            self.output_text.config(state=tk.DISABLED)
            self.status_label.config(text="Comparison completed successfully")
        else:
            self.status_label.config(text="Comparison failed - missing translations")
    def get_translations(self, filepath, is_git=False):
        if is_git:
            repo_path = self.git_repo_entry.get()
            commit_id = self.git_commit_entry.get()
            content = get_file_content(repo_path, filepath, commit_id)
            if not content:
                return {}
            if filepath.endswith(".csv"):
                return read_csv_file(filepath,  # Fix this line to use content
                                    delimiter=self.csv_delimiter_entry.get(),
                                    has_header=not self.csv_no_header_var.get(),
                                    key_column=self.csv_key_column_entry.get(),
                                    value_column=self.csv_value_column_entry.get())
            elif filepath.endswith(".lang"):
                return read_lang_file(content)
        else:
            # Existing local file logic here
            if filepath.endswith(".csv"):
                with open(filepath, 'r', encoding='utf-8') as f:
                    content = f.read()
                return read_csv_file(filepath,
                                    delimiter=self.csv_delimiter_entry.get(),
                                    has_header=not self.csv_no_header_var.get(),
                                    key_column=self.csv_key_column_entry.get(),
                                    value_column=self.csv_value_column_entry.get())
            elif filepath.endswith(".lang"):
                return read_xml_lang_file(filepath)
        return {}  # Add default return

        # Compare translations and update the output area.
        if old_translations is not None and new_translations is not None:
            compare_values = not self.only_missing_var.get()  # Use checkbox value
            result = compare_translations(
                old_translations,
                new_translations,
                ignore_case=self.ignore_case_var.get(),
                ignore_whitespace=self.ignore_whitespace_var.get(),
                is_gui=True,
                compare_values=compare_values
            )
            self.output_text.config(state=tk.NORMAL)
            self.output_text.delete("1.0", tk.END)
            self.output_text.insert("1.0", result)
            self.output_text.config(state=tk.DISABLED)
            self.status_label.config(text="Comparison complete.")
        else:
            self.status_label.config(text="Comparison failed.")

if __name__ == "__main__":
    root = tk.Tk()
    app = App(root)
    root.mainloop()