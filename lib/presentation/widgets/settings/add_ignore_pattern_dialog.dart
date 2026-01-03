import 'package:flutter/material.dart';

/// Dialog for adding a new ignore pattern with live regex testing.
class AddIgnorePatternDialog extends StatefulWidget {
  /// Creates an add ignore pattern dialog.
  const AddIgnorePatternDialog({
    super.key,
    required this.onSubmit,
    this.autofocus = true,
  });

  /// Called when a valid pattern is submitted.
  final ValueChanged<String> onSubmit;

  /// Whether the pattern field should request focus on open.
  final bool autofocus;

  @override
  State<AddIgnorePatternDialog> createState() => _AddIgnorePatternDialogState();
}

class _AddIgnorePatternDialogState extends State<AddIgnorePatternDialog> {
  final TextEditingController _patternController = TextEditingController();
  String? _errorMessage;
  String _testString = '';
  bool? _matchResult;

  @override
  void dispose() {
    _patternController.dispose();
    super.dispose();
  }

  void _submit() {
    final pattern = _patternController.text;
    if (pattern.isEmpty || _errorMessage != null) {
      return;
    }
    widget.onSubmit(pattern);
    Navigator.of(context).pop();
  }

  void _validateAndTest(String pattern) {
    try {
      final regex = RegExp(pattern);
      setState(() {
        _errorMessage = null;
        if (_testString.isNotEmpty && pattern.isNotEmpty) {
          _matchResult = regex.hasMatch(_testString);
        } else {
          _matchResult = null;
        }
      });
    } catch (_) {
      setState(() {
        _errorMessage = 'Invalid regex pattern';
        _matchResult = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final canSubmit =
        _errorMessage == null && _patternController.text.isNotEmpty;

    return AlertDialog(
      title: const Text('Add Ignore Pattern'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            key: const Key('addPattern_textField'),
            controller: _patternController,
            decoration: InputDecoration(
              hintText: 'e.g., ^temp_.*',
              labelText: 'Pattern (regex)',
              errorText: _errorMessage,
            ),
            autofocus: widget.autofocus,
            onChanged: _validateAndTest,
            onSubmitted: (_) => _submit(),
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              labelText: 'Test String',
              hintText: 'Enter a key to test against pattern',
              suffixIcon: _matchResult == null
                  ? null
                  : Icon(
                      _matchResult! ? Icons.check_circle : Icons.cancel,
                      color: _matchResult! ? Colors.green : Colors.red,
                    ),
            ),
            onChanged: (value) {
              _testString = value;
              _validateAndTest(_patternController.text);
            },
          ),
          if (_matchResult != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                _matchResult!
                    ? '✓ Pattern matches test string'
                    : '✗ Pattern does not match',
                style: TextStyle(
                  color: _matchResult! ? Colors.green : Colors.red,
                  fontSize: 12,
                ),
              ),
            ),
        ],
      ),
      actions: [
        TextButton(
          key: const Key('addPattern_cancelButton'),
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          key: const Key('addPattern_addButton'),
          onPressed: canSubmit ? _submit : null,
          child: const Text('Add'),
        ),
      ],
    );
  }
}
