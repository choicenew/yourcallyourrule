import 'package:material_ui/material_ui.dart';
import 'package:pyro_cloud_drive_crypto/pyro_cloud_drive_crypto.dart';
import 'package:pyro_cloud_drive_ui/src/l10n/generated/app_localizations.dart';
import '../l10n/generated/app_localizations_en.dart';

class EncryptionPasswordDialog extends StatefulWidget {
  final CloudDriveSecureStorage storage;

  const EncryptionPasswordDialog({
    super.key,
    required this.storage,
  });

  @override
  State<EncryptionPasswordDialog> createState() => _EncryptionPasswordDialogState();
}

class _EncryptionPasswordDialogState extends State<EncryptionPasswordDialog> {
  final _controller = TextEditingController();
  bool _obscure = true;
  String? _error;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submit(AppLocalizations l10n) async {
    final password = _controller.text.trim();
    if (password.isEmpty) {
      setState(() => _error = l10n.passwordEmptyError);
      return;
    }
    await widget.storage.setEncryptionPassword(password);
    if (mounted) Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations) ?? AppLocalizationsEn();

    return AlertDialog(
      title: Text(l10n.setPasswordTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(l10n.setPasswordDescription),
          const SizedBox(height: 16),
          TextField(
            controller: _controller,
            obscureText: _obscure,
            decoration: InputDecoration(
              labelText: l10n.masterPasswordLabel,
              errorText: _error,
              suffixIcon: IconButton(
                icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
                onPressed: () => setState(() => _obscure = !_obscure),
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(false), child: Text(l10n.cancel)),
        FilledButton(onPressed: () => _submit(l10n), child: Text(l10n.saveAndEnable)),
      ],
    );
  }
}


