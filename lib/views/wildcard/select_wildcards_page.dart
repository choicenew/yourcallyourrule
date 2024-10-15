import 'package:flutter/material.dart';

import '../../services/regex_service.dart';
import '../subpage_style.dart';

class SelectRegexPatternsDialog extends StatefulWidget {
  final List<RegexPattern> patterns;

  const SelectRegexPatternsDialog({super.key, required this.patterns});

  @override
  SelectRegexPatternsDialogState createState() =>
      SelectRegexPatternsDialogState();
}

class SelectRegexPatternsDialogState
    extends State<SelectRegexPatternsDialog> {
  final Set<RegexPattern> _selectedPatterns = <RegexPattern>{};
  bool _isSelectAll = false;
  String _keyword = '';

  @override
  Widget build(BuildContext context) {
    final filteredPatterns = widget.patterns
        .where((pattern) =>
            pattern.name.toLowerCase().contains(_keyword.toLowerCase()) ||
            pattern.pattern.toLowerCase().contains(_keyword.toLowerCase()))
        .toList();

    return AlertDialog(
      title: Text('Select Regex Patterns'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Search patterns',
                labelStyle: inputTextStyle,
                suffixIcon: _keyword.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _keyword = '';
                          });
                        },
                      )
                    : null,
              ),
              onChanged: (keyword) {
                setState(() {
                  _keyword = keyword;
                });
              },
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Checkbox(
                  value: _isSelectAll,
                  onChanged: (value) {
                    setState(() {
                      _isSelectAll = value!;
                      for (var pattern in filteredPatterns) {
                        if (_isSelectAll) {
                          _selectedPatterns.add(pattern);
                        } else {
                          _selectedPatterns.remove(pattern);
                        }
                      }
                    });
                  },
                ),
                Text('Select All', style: SubscriptionPageStyles.tabLabelStyle),
              ],
            ),
            ListBody(
              children: filteredPatterns
                  .map(
                    (pattern) => CheckboxListTile(
                      title: Text(pattern.name),
                      subtitle: Text(pattern.pattern),
                      value:
                          _isSelectAll || _selectedPatterns.contains(pattern),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value != null && value) {
                            _selectedPatterns.add(pattern);
                          } else {
                            _selectedPatterns.remove(pattern);
                          }
                        });
                      },
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(_selectedPatterns.toList());
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}
