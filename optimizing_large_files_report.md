**Report: Optimizing Large File Handling in Localization Comparison Tool**

**1. Introduction:**
   - Handling very large localization files (e.g., hundreds of megabytes or millions of key-value pairs) poses a significant challenge to the current system. Standard parsing methods often load entire files into memory, leading to high memory consumption and potential performance degradation or crashes. This report outlines strategies to optimize this by adopting stream-based processing for problematic file formats.

**2. Problematic File Formats:**
   - **JSON (`.json`):** Standard `json.load()` or `json.loads()` builds a full in-memory dictionary. Large JSON files with many keys, large string values, or deep nesting consume significant memory.
   - **XML-based (`.xml`, `.resx`, `.xliff`, Android XML):** DOM parsers like `xml.etree.ElementTree` load the entire XML tree into memory. Large XML files, especially those with numerous elements or extensive text content, are memory-intensive.
   - **YAML (`.yaml`, `.yml`):** Similar to JSON, `yaml.safe_load()` typically creates a full in-memory representation. YAML's features like anchors and aliases can create complex, memory-heavy object graphs if the file is large.
   - **CSV (`.csv`):** While the `csv` module supports row-by-row reading, our current `CsvParser` (and others) accumulates all data into a dictionary, which is problematic for large CSV files with many rows.
   - **Properties (`.properties`), Lang (`.lang`):** These line-based formats are less problematic in terms of complex parsing structures. However, our current parsers read the entire file content and then process it into a dictionary, making them inefficient for very large files.

**3. Stream-Based Parsing Options:**
   - **JSON:**
      - **Recommended:** `ijson` library.
      - **Pros:** Highly memory-efficient, can parse specific parts of a JSON document without loading everything, event-driven or incremental object building.
      - **Cons:** More complex API than the standard `json` module. May have slight overhead for very small files.
      - **Alternative:** `json.JSONDecoder` can be used for lower-level control, but requires more manual implementation.
   - **XML:**
      - **Recommended:** `xml.etree.ElementTree.iterparse()` (standard library).
      - **Pros:** Event-driven, allows processing and discarding elements to save memory. Standard library means no new dependencies.
      - **Cons:** Requires careful manual management of events and element tree (e.g., `element.clear()`) to achieve memory benefits. Can be more verbose than DOM parsing.
      - **Alternative:** `lxml.etree.iterparse()` offers a similar API, potentially with better performance for very large files, but adds an external dependency.
   - **YAML:**
      - **Challenges:** Full streaming is difficult due to YAML's features like anchors and aliases, which may require look-backs or having significant portions of the document available.
      - **Potential Approaches:** `PyYAML` offers event-based parsing (`yaml.parse()`, `yaml.scan()`).
      - **Pros:** Allows processing without building the full object model.
      - **Cons:** Very low-level API, making it complex to reconstruct simple key-value pairs reliably for all YAML features. May not be feasible for true "one key-value pair at a time" streaming for all YAML files. Further investigation needed for a robust streaming solution.
   - **CSV, Properties, Lang:**
      - **Recommendation:** These formats are inherently line-based or row-based.
      - **CSV:** The standard `csv` module already reads row-by-row. The `CsvParser` should be modified to yield rows/key-value pairs iteratively instead of loading all into a dictionary.
      - **Properties/Lang:** These parsers should be modified to read and process the file line-by-line, yielding key-value pairs, instead of reading the whole content first. Python's file iteration (`for line in file_obj:`) is efficient for this.

**4. Proposed `BaseParser` Interface Changes:**
   - The current `parse(self, file_path: str) -> Dict[str, str]` method, returning a full dictionary, is a bottleneck for large files.
   - **Suggestions:**
      1.  **New Method:** Introduce `parse_iter(self, file_path: str) -> Iterator[Tuple[str, str]]`.
          - This method would read the file incrementally and `yield` `(key, value)` string tuples.
          - Parsers capable of streaming (JSON, XML, CSV, Properties, Lang) would implement this.
      2.  **Retain `parse()` for Compatibility:** Keep the existing `parse()` method.
          - For parsers implementing `parse_iter()`, `parse()` can have a default implementation:
            `return {key: value for key, value in self.parse_iter(file_path)}`.
          - This ensures backward compatibility for components not yet updated for streaming.
          - Parsers that cannot easily stream (e.g., potentially complex YAML cases) would override `parse()` with their traditional full-load logic and might not implement `parse_iter()`.
      3.  **Capability Flag:** Add a method `supports_streaming(self) -> bool` to `BaseParser`.
          - Returns `True` if `parse_iter()` is implemented and recommended for large files.
          - Allows `FileProcessingService` to dynamically choose the parsing method.
   - **Implications:**
      - Requires significant refactoring for parser implementations that will support `parse_iter()`.
      - `FileProcessingService` and other data consumers would need to be updated to handle iterators.

**5. Adapting Comparison Logic for Streamed Data:**
   - `core.comparison_service.compare_translations` currently expects two full dictionaries.
   - **Proposed Strategy (Iterate One, Hold One):**
      1.  Modify `compare_translations` to accept, for example, `source_translations: Dict[str, str]` and `target_translations_iter: Iterator[Tuple[str, str]]`.
      2.  The `FileProcessingService` would be responsible for fully loading one file's data (e.g., the "source" or reference file, or the smaller of the two if identifiable) into the dictionary argument.
      3.  The other file (potentially very large) would be processed as an iterator.
      4.  **Logic:**
          - Iterate through `target_translations_iter`. For each `(key, value)`:
             - If `key` is in `source_translations`'s keys, it's a common key. Perform value/placeholder comparison. Remove the key from a temporary copy of `source_translations`'s keys to track processed source keys.
             - If `key` is not in `source_translations`'s keys, it's an "obsolete/extra" key in the target.
          - After the iterator is exhausted, any keys remaining in the temporary copy of `source_translations`'s keys are "missing" in the target.
   - **Alternative for Two Very Large Files (More Complex):**
      - If neither file fits comfortably in memory:
         - Stream both files, potentially sorting them by key using external sort techniques (if keys are not already sorted).
         - Perform a merge-join style comparison on the sorted streams.
         - This is significantly more complex and I/O intensive.
   - **Considerations:**
      - The "Iterate One, Hold One" strategy is a good balance for initial implementation.
      - Placeholders and value comparisons for common keys can be done when the key is matched.

**6. Recommendations and Phased Approach:**
   - **Phase 1: Implement Core Streaming Infrastructure & Parsers:**
      - Modify `BaseParser` interface (`parse_iter()`, `supports_streaming()`).
      - Implement `parse_iter()` for formats where it's most straightforward and impactful:
         - JSON (using `ijson`).
         - XML-based formats (using `xml.etree.ElementTree.iterparse()`).
         - CSV, Properties, Lang (by adapting existing line/row processing).
      - Update `FileProcessingService` to use `parse_iter()` when available, initially focusing on the `parse_file_async` path. For comparison methods, it might still convert iterators to dicts as an interim step if `compare_translations` is not yet updated.
   - **Phase 2: Adapt Comparison Logic:**
      - Refactor `core.comparison_service.compare_translations` to use the "Iterate One, Hold One" strategy.
      - Update `FileProcessingService`'s comparison methods (`compare_files_async`, `compare_directories_async`) to pass iterators to the comparison service for at least one of the files.
   - **Phase 3: Advanced YAML & Further Optimizations:**
      - Conduct deeper research into robust, efficient, and practical stream-based parsing for complex YAML files that yields simple key-value pairs.
      - Evaluate the "External Sort / Merge-like Join" or database-backed strategies for comparison if the "Iterate One, Hold One" approach proves insufficient for extreme cases.
   - **Prerequisites/Impact:**
      - The GUI and any other direct consumers of parsed data might need changes to handle potentially iterative data or to trigger full loading explicitly if they require random access to all data.
      - Error handling within iterators needs careful design.

**7. Conclusion:**
   - Adopting stream-based processing, especially for JSON and XML files, will significantly improve the tool's ability to handle large localization files by reducing memory footprint and potentially speeding up processing for certain operations. While it requires substantial changes to parsers and data handling logic, a phased approach can make the transition manageable and deliver incremental benefits.
```
