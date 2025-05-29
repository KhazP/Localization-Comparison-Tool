**Analysis and Design: Detailed Diff View for Modified Strings**

**1. Introduction:**
   - **Purpose:** To provide users with a clear, visual, character-level or word-level representation of differences between a source and a target translation string. This will help users quickly identify changes, verify machine translations, or pinpoint errors in modified strings.

**2. Diffing Library Choice:**
   - **Recommendation:** Python's `difflib` module.
   - **Justification:**
      - It is a standard library module, requiring no new external dependencies, which simplifies packaging and distribution.
      - The `difflib.SequenceMatcher` class, specifically its `get_opcodes()` method, provides a structured way to identify segments that are 'equal', 'replaced', 'deleted' (from source), or 'inserted' (in target). This maps directly to the needs of a styled diff view.
      - While other libraries like `diff-match-patch` exist and offer advanced algorithms, `difflib` is generally sufficient for comparing single strings of text, as is common in localization, and meets the project's preference for standard library solutions where possible.

**3. Flet UI Design:**
   - **Primary Control:** `flet.Text` using its `spans: List[flet.TextSpan]` attribute. This allows for applying different styles (color, background, weight, decoration) to various segments of a single text string.
   - **Styling (using `flet.TextStyle`):**
      - **Added Text:** `flet.TextStyle(bgcolor=flet.colors.GREEN_ACCENT_100)` (Light green background for newly added text in the target string). Alternatively, `flet.colors.LIGHT_GREEN_ACCENT_100` or similar shades can be used.
      - **Removed Text:** `flet.TextStyle(bgcolor=flet.colors.RED_ACCENT_100, decoration=flet.TextDecoration.LINE_THROUGH)` (Light red background with strikethrough for text removed from the source string). Alternatively, `flet.colors.PINK_100` or a similar light red/pink shade.
      - **Common Text:** Default `flet.TextStyle()` (no special styling, inherits from parent or theme).
      - **Placeholder for Alignment (Optional):** If strict character-by-character visual alignment is needed in a side-by-side view where one side has a deletion/insertion, a `flet.TextStyle(color=flet.colors.TRANSPARENT)` or a very subtle background for empty space could be used, though this adds complexity. A simpler approach is to just show the text in its respective panel.
   - **Layout Recommendation:** Side-by-side view.
      - **Implementation:** A `flet.Row` control containing two `flet.Column` controls (or directly `flet.Text` controls if no additional labels per side are needed). Each `flet.Column` would hold a `flet.Text("Source Text", weight=flet.FontWeight.BOLD)` label and the `flet.Text` control with the styled spans for the source string, and similarly for the target string.
      - **Justification:** This layout is generally clearer for comparing strings, especially if they are longer or have multiple small changes. It allows users to scan corresponding lines or segments more easily. An inline (unified) diff can become confusing for anything beyond simple insertions/deletions.
   - **Textual Mockup (Side-by-Side):**
     - Source String: "The quick brown fox jumps."
     - Target String: "The very agile brown fox leaps!"

     ```
     -------------------------------------------------------------------
     | Source Text                      | Target Text                    |
     -------------------------------------------------------------------
     | The quick       brown fox jumps. | The VERY AGILE brown fox LEAPS!|
     |     (RED,strike)           (RED,strike) |     (GREEN) (GREEN)        (GREEN)|
     -------------------------------------------------------------------
     ```
     - **Visual Key:**
       - "quick": In the Source Text panel, it would have a light red background and strikethrough.
       - "VERY AGILE": In the Target Text panel, these words would have a light green background.
       - "jumps.": In the Source Text panel, it would have a light red background and strikethrough.
       - "LEAPS!": In the Target Text panel, it would have a light green background.
       - "The", "brown", "fox": Would have default styling in both panels.

**4. Integration with Results Display:**
   - **Location of Trigger:** Ideally within the main comparison results view, likely managed by `components/results_view.py` or a similar component responsible for rendering the list/table of string differences.
   - **Trigger Mechanism:**
      - For each item in the results list that represents a "modified" string pair.
      - A new `flet.IconButton` (e.g., using `flet.icons.DIFFERENCE`, `flet.icons.FIND_REPLACE`, or `flet.icons.VISIBILITY`) placed next to the modified string pair.
      - **Alternative:** A context menu option on right-click, or an action button in a toolbar that becomes active when a modified string is selected. Double-clicking the item is also intuitive.
      - **Recommendation:** An `IconButton` per modified item is direct and user-friendly.
   - **Display Mechanism:**
      - **Recommendation:** `flet.AlertDialog` (Modal Dialog).
         - **Title:** "Detailed String Comparison" or "View Differences".
         - **Content:** The `flet.Row` containing the side-by-side styled `flet.Text` controls for source and target. The dialog should be wide enough to accommodate typical string lengths without excessive wrapping, or use `ScrollMode.ADAPTIVE` for the `Text` controls if content might overflow.
         - **Actions:** A single `flet.TextButton("Close")` to dismiss the dialog.
         - **Modal Behavior:** `modal=True` for the `AlertDialog` to ensure user focus.
      - **Justification:** A modal dialog provides a focused view for the detailed diff without disrupting the main results list layout. It's a common and easily understood UI pattern. Expandable sections can make the list jumpy, and a persistent separate panel might consume too much screen real estate if not always needed.

**5. Algorithm for `TextSpan` Generation (using `difflib.SequenceMatcher`):**
   - **Function Signature Idea:**
     `def generate_diff_spans(source_text: str, target_text: str) -> Tuple[List[flet.TextSpan], List[flet.TextSpan]]:`
   - **Styling Definitions (defined outside, passed in, or accessed globally/themed):**
     ```python
     added_style = flet.TextStyle(bgcolor=flet.colors.GREEN_ACCENT_100) # Or a more subtle green
     removed_style = flet.TextStyle(bgcolor=flet.colors.RED_ACCENT_100, decoration=flet.TextDecoration.LINE_THROUGH) # Or a more subtle red/pink
     common_style = flet.TextStyle() # Default style
     ```
   - **Algorithm Steps:**
      1. Initialize `source_spans: List[flet.TextSpan] = []` and `target_spans: List[flet.TextSpan] = []`.
      2. Create the `SequenceMatcher`: `matcher = difflib.SequenceMatcher(a=source_text, b=target_text, autojunk=False)`. `autojunk=False` can be important for seeing all differences, even in "noisy" sequences.
      3. Get opcodes: `opcodes = matcher.get_opcodes()`.
      4. Iterate through each `(tag, i1, i2, j1, j2)` in `opcodes`:
         - **If `tag == 'equal'`:**
           - `source_spans.append(flet.TextSpan(text=source_text[i1:i2], style=common_style))`
           - `target_spans.append(flet.TextSpan(text=target_text[j1:j2], style=common_style))`
         - **If `tag == 'delete'`:** (Text removed from source, not present in target)
           - `source_spans.append(flet.TextSpan(text=source_text[i1:i2], style=removed_style))`
           - To maintain some visual alignment in the target panel for this deleted segment, one might add empty space, but this is complex. A simpler approach is to only mark the deletion in the source panel. The target panel would simply not have corresponding text for this segment from `get_opcodes`.
         - **If `tag == 'insert'`:** (Text added to target, not present in source)
           - `target_spans.append(flet.TextSpan(text=target_text[j1:j2], style=added_style))`
           - Similar to 'delete', the source panel would not have corresponding text for this segment.
         - **If `tag == 'replace'`:** (Text in source replaced by different text in target)
           - `source_spans.append(flet.TextSpan(text=source_text[i1:i2], style=removed_style))`
           - `target_spans.append(flet.TextSpan(text=target_text[j1:j2], style=added_style))`
      5. Return `(source_spans, target_spans)`.

   - **Word-level vs. Character-level:**
     - `SequenceMatcher` by default works on sequences of lines, or sequences of characters if you pass strings directly to `a` and `b` (which is the case here).
     - To achieve a "word-level" diff using `SequenceMatcher`, the input strings would first need to be tokenized into words (e.g., `source_text.split()` or using a more sophisticated regex for word tokenization). The `opcodes` would then refer to indices in these lists of words. The `TextSpan` generation would then reconstruct strings from these word lists, adding spaces back appropriately.
     - **Recommendation for this feature:** Start with character-level diffs as it's more straightforward with `SequenceMatcher` and often more precise for localization changes (e.g., punctuation, single character typos). Word-level can be a future enhancement if character-level is too noisy for some use cases. The current algorithm outline implies character-level.

**6. Conclusion:**
   - Implementing a detailed diff view using `difflib` and `flet.Text.spans` will significantly enhance the user experience by providing immediate and clear visual feedback on the exact nature of modifications in translation strings. This aids in quicker reviews, better error spotting, and increased confidence in managing localization changes. The recommended side-by-side view presented in a modal dialog offers a good balance of clarity and usability.
```
