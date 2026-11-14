import 'package:material_ui/material_ui.dart';
import 'package:pyro_sms_protocol/pyro_sms_protocol.dart';
import '../l10n/sms_localizations.dart';

/// Modal bottom sheet allowing users to toggle messaging apps protected by NotificationListener
class ProtectedAppsSelectorSheet extends StatefulWidget {
  final List<ProtectedAppInfo> apps;
  final Function(List<String> selectedPackageNames)? onSave;

  const ProtectedAppsSelectorSheet({
    super.key,
    this.apps = ProtectedAppInfo.defaults,
    this.onSave,
  });

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => const ProtectedAppsSelectorSheet(),
    );
  }

  @override
  State<ProtectedAppsSelectorSheet> createState() => _ProtectedAppsSelectorSheetState();
}

class _ProtectedAppsSelectorSheetState extends State<ProtectedAppsSelectorSheet> {
  late Map<String, bool> _selection;

  @override
  void initState() {
    super.initState();
    _selection = {for (var app in widget.apps) app.packageName: app.isEnabled};
  }

  @override
  Widget build(BuildContext context) {
    final l10n = SmsLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.protectedMessagingAppsTitle,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(l10n.protectedMessagingAppsSubtitle),
          const SizedBox(height: 16),
          ...widget.apps.map((app) {
            return SwitchListTile(
              title: Text(app.appName),
              subtitle: Text(app.packageName),
              value: _selection[app.packageName] ?? true,
              onChanged: (val) {
                setState(() {
                  _selection[app.packageName] = val;
                });
              },
            );
          }),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              final selected = _selection.entries
                  .where((e) => e.value)
                  .map((e) => e.key)
                  .toList();
              widget.onSave?.call(selected);
              Navigator.pop(context);
            },
            child: Center(child: Text(l10n.saveProtectedAppsButton)),
          ),
        ],
      ),
    );
  }
}
