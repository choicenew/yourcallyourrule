import 'package:flutter/material.dart';

import '../../services/plugin_manager_service.dart';
import '../subpage_style.dart';

class SelectPluginsDialog extends StatefulWidget {
  final List<Plugin> plugins;

  const SelectPluginsDialog({super.key, required this.plugins});

  @override
  SelectPluginsDialogState createState() => SelectPluginsDialogState();
}

class SelectPluginsDialogState extends State<SelectPluginsDialog> {
  late List<Plugin> _plugins;
  final Set<Plugin> _selectedPlugins = <Plugin>{};
  bool _isSelectAll = false;
  String _keyword = '';

  @override
  void initState() {
    super.initState();
    _plugins = widget.plugins;
  }

  @override
  Widget build(BuildContext context) {
    final filteredPlugins = _plugins
        .where((plugin) =>
            plugin.name.toLowerCase().contains(_keyword.toLowerCase()))
        .toList();

    return AlertDialog(
      title: Text('Select Plugins'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Search plugins',
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
                      for (var plugin in filteredPlugins) {
                        if (_selectedPlugins.contains(plugin)) {
                          _selectedPlugins.remove(plugin);
                        } else {
                          _selectedPlugins.add(plugin);
                        }
                      }
                    });
                  },
                ),
                Text('Select All', style: SubscriptionPageStyles.tabLabelStyle),
              ],
            ),
            SizedBox(height: 16.0),
            ListBody(
              children: filteredPlugins
                  .map(
                    (plugin) => CheckboxListTile(
                      title: Text(plugin.name),
                      value: _isSelectAll || _selectedPlugins.contains(plugin),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value != null && value) {
                            _selectedPlugins.add(plugin);
                          } else {
                            _selectedPlugins.remove(plugin);
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
            Navigator.of(context).pop(_selectedPlugins.toList());
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}
