import logging
import re
from typing import List, Tuple, Dict, Any, Set, Optional # Added Optional
from core.parsing_result import ParsingResult # Assuming ParsingResult is accessible

# If colorama is to be used for CLI output by this service, it needs to be handled.
# For a service, it's better to return structured data and let the caller handle presentation.
# So, we will remove direct colorama usage here.
# from colorama import Fore, Style, init
# init() # Initialize colorama if used

logger = logging.getLogger(__name__)

class ComparisonService:
    """
    Service for comparing translation data and validating placeholders.
    """

    def extract_placeholders(self, text: str) -> List[str]:
        """Extract all placeholders from a text string."""
        if not isinstance(text, str): # Ensure text is a string
            logger.warning(f"extract_placeholders received non-string input: {type(text)}")
            return []

        # Common placeholder patterns (from GUI/logic.py)
        # Order can matter if patterns are ambiguous or overlap.
        patterns = [
            r'\{[^{}]*?\}',              # {name}, {0}, {value} (non-greedy)
            r'%[0-9]*\.?[0-9]*[sdfeoxXg]',# %s, %d, %.2f, %1$s (more comprehensive C-style)
                                        # %1$s, %2$d (positional) - covered by above
            r'\$[a-zA-Z_][a-zA-Z0-9_]*', # $variable
            r'#[a-zA-Z_][a-zA-Z0-9_]*#', # #variable# (custom)
            r'\[\[.*?\]\]'              # [[variable]] (non-greedy custom)
        ]
        # Ensure patterns are not too greedy, e.g. by using *?

        combined_pattern = '|'.join(patterns)
        try:
            placeholders = re.findall(combined_pattern, text)
        except re.error as e:
            logger.error(f"Regex error in extract_placeholders: {e} for text: {text[:100]}")
            return [] # Return empty list on regex error
        return sorted(list(set(placeholders))) # Return unique, sorted placeholders


    def validate_placeholders(self, source_text: str, target_text: str) -> Tuple[bool, str, List[str], List[str]]:
        """
        Validate that placeholders match between source and target text.
        Returns (is_valid, error_message, missing_in_target, extra_in_target).
        """
        if not isinstance(source_text, str) or not isinstance(target_text, str):
            logger.warning(f"validate_placeholders received non-string input: source_type={type(source_text)}, target_type={type(target_text)}")
            if not isinstance(source_text, str): source_text = ""
            if not isinstance(target_text, str): target_text = ""

        source_placeholders = self.extract_placeholders(source_text)
        target_placeholders = self.extract_placeholders(target_text)

        # Using sets for finding differences
        set_source_placeholders = set(source_placeholders)
        set_target_placeholders = set(target_placeholders)

        if set_source_placeholders == set_target_placeholders:
            # Additionally check counts for repeated placeholders if strict order/count is needed.
            # For now, matching unique sets is the primary validation.
            # If counts must match: Counter(source_placeholders) == Counter(target_placeholders)
            return True, "", [], []

        missing_in_target = sorted(list(set_source_placeholders - set_target_placeholders))
        extra_in_target = sorted(list(set_target_placeholders - set_source_placeholders))

        error_messages = []
        if missing_in_target:
            error_messages.append(f"Missing in target: {', '.join(missing_in_target)}")
        if extra_in_target:
            error_messages.append(f"Extra in target: {', '.join(extra_in_target)}")

        return False, "; ".join(error_messages), missing_in_target, extra_in_target

    def compare_translations(self,
                             source_result: ParsingResult,
                             target_result: ParsingResult,
                             config: Optional[Dict[str, Any]] = None) -> Dict[str, Any]: # Output changed to Dict
        """
        Compares two sets of translations from ParsingResult objects.

        Args:
            source_result: ParsingResult object for the source/reference translations.
            target_result: ParsingResult object for the target/new translations.
            config: Dictionary with comparison settings:
                ignore_case_keys (bool): Ignore case in keys.
                compare_values (bool): Compare values of common keys (not just presence).
                ignore_whitespace_values (bool): Ignore leading/trailing whitespace in values during comparison.
                log_missing_keys (bool): Log if keys are missing (handled by return structure now).
                auto_fill_missing (bool): Not directly applicable here, relates to modifying target.

        Returns:
            A dictionary containing the comparison results:
            {
                "missing_in_target": {key: source_value},
                "obsolete_in_target": {key: target_value},
                "common_keys_count": int,
                "value_differences": {key: {"source": source_value, "target": target_value, "reason": "different_value"}},
                "placeholder_mismatches": {key: {"source_value": S, "target_value": T, "message": error_msg,
                                                "missing_placeholders": [...], "extra_placeholders": [...]}},
                "summary": {
                    "source_keys_count": int,
                    "target_keys_count": int,
                    "missing_count": int,
                    "obsolete_count": int,
                    "value_diff_count": int,
                    "placeholder_mismatch_count": int
                }
            }
        """
        cfg = config or {}
        ignore_case_keys = cfg.get('ignore_case_keys', False)

        source_translations = source_result.translations
        target_translations = target_result.translations

        def normalize_key(k: str) -> str:
            k_norm = k.strip()
            return k_norm.lower() if ignore_case_keys else k_norm

        norm_source_keys: Dict[str, str] = {normalize_key(k): k for k in source_translations.keys()}
        norm_target_keys: Dict[str, str] = {normalize_key(k): k for k in target_translations.keys()}

        set_norm_source_keys = set(norm_source_keys.keys())
        set_norm_target_keys = set(norm_target_keys.keys())

        missing_norm_keys = set_norm_source_keys - set_norm_target_keys
        obsolete_norm_keys = set_norm_target_keys - set_norm_source_keys
        common_norm_keys = set_norm_source_keys & set_norm_target_keys

        results: Dict[str, Any] = {
            "missing_in_target": {},
            "obsolete_in_target": {},
            "common_keys_count": len(common_norm_keys),
            "value_differences": {},
            "placeholder_mismatches": {}
        }

        for norm_k in missing_norm_keys:
            original_key = norm_source_keys[norm_k]
            results["missing_in_target"][original_key] = source_translations[original_key]

        for norm_k in obsolete_norm_keys:
            original_key = norm_target_keys[norm_k]
            results["obsolete_in_target"][original_key] = target_translations[original_key]

        compare_values_flag = cfg.get('compare_values', True)
        ignore_whitespace_values = cfg.get('ignore_whitespace_values', False)

        for norm_k in common_norm_keys:
            source_orig_key = norm_source_keys[norm_k]
            target_orig_key = norm_target_keys[norm_k]

            source_val = source_translations[source_orig_key]
            target_val = target_translations[target_orig_key]

            is_valid_ph, ph_error_msg, missing_ph, extra_ph = self.validate_placeholders(source_val, target_val)
            if not is_valid_ph:
                results["placeholder_mismatches"][source_orig_key] = {
                    "source_value": source_val,
                    "target_value": target_val,
                    "message": ph_error_msg,
                    "missing_placeholders": missing_ph,
                    "extra_placeholders": extra_ph
                }

            if compare_values_flag:
                processed_source_val = source_val.strip() if ignore_whitespace_values else source_val
                processed_target_val = target_val.strip() if ignore_whitespace_values else target_val

                if processed_source_val != processed_target_val:
                    results["value_differences"][source_orig_key] = {
                        "source_value": source_val,
                        "target_value": target_val,
                        "reason": "different_value"
                    }

        results["summary"] = {
            "source_keys_count": len(source_translations),
            "target_keys_count": len(target_translations),
            "missing_count": len(results["missing_in_target"]),
            "obsolete_count": len(results["obsolete_in_target"]),
            "value_diff_count": len(results["value_differences"]),
            "placeholder_mismatch_count": len(results["placeholder_mismatches"])
        }

        return results


    def format_comparison_as_text(self, comparison_results: Dict[str, Any], is_gui: bool = False) -> str:
        """
        Formats the structured comparison results into a human-readable text report.
        """
        output_lines = []

        max_key_length = 0
        all_keys_for_length_calc: Set[str] = set()
        all_keys_for_length_calc.update(comparison_results["missing_in_target"].keys())
        all_keys_for_length_calc.update(comparison_results["obsolete_in_target"].keys())
        all_keys_for_length_calc.update(comparison_results["value_differences"].keys())
        all_keys_for_length_calc.update(comparison_results["placeholder_mismatches"].keys())
        if all_keys_for_length_calc:
            max_key_length = max(len(k) for k in all_keys_for_length_calc) if all_keys_for_length_calc else 0
        max_key_length = max(max_key_length, len("Summary"))


        if comparison_results["placeholder_mismatches"]:
            output_lines.append("--- Placeholder Mismatches ---")
            for key, data in sorted(comparison_results["placeholder_mismatches"].items()):
                line = f"~ {key.ljust(max_key_length)} : (Target: '{data['target_value'][:50]}...') ({data['message']})"
                output_lines.append(line)
            output_lines.append("")

        if comparison_results["missing_in_target"]:
            output_lines.append("--- Missing in Target ---")
            for key, value in sorted(comparison_results["missing_in_target"].items()):
                line = f"+ {key.ljust(max_key_length)} : (Source value: '{value[:50]}...')"
                output_lines.append(line)
            output_lines.append("")

        if comparison_results["obsolete_in_target"]:
            output_lines.append("--- Obsolete in Target ---")
            for key, value in sorted(comparison_results["obsolete_in_target"].items()):
                line = f"- {key.ljust(max_key_length)} : (Target value: '{value[:50]}...')"
                output_lines.append(line)
            output_lines.append("")

        if comparison_results["value_differences"]:
            output_lines.append("--- Value Differences (Common Keys) ---")
            for key, data in sorted(comparison_results["value_differences"].items()):
                line = f"! {key.ljust(max_key_length)} : (Source: '{data['source_value'][:50]}...', Target: '{data['target_value'][:50]}...')"
                output_lines.append(line)
            output_lines.append("")

        summary = comparison_results["summary"]
        output_lines.append("--- Summary ---")
        output_lines.append(f"Source Keys Total: {summary['source_keys_count']}")
        output_lines.append(f"Target Keys Total: {summary['target_keys_count']}")
        output_lines.append(f"Common Keys: {comparison_results['common_keys_count']}")
        output_lines.append(f"Missing in Target: {summary['missing_count']}")
        output_lines.append(f"Obsolete in Target: {summary['obsolete_count']}")
        output_lines.append(f"Value Differences: {summary['value_diff_count']}")
        output_lines.append(f"Placeholder Mismatches: {summary['placeholder_mismatch_count']}")

        return "\n".join(output_lines)
