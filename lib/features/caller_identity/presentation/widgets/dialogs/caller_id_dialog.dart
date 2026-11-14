import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dlibphonenumber/dlibphonenumber.dart' as dlibphone;
import 'package:yourcallyourrule/features/caller_identity/services/caller_identity_service.dart';
import 'package:yourcallyourrule/features/language/provider/language_provider.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 来电显示信息对话框 (归位至 caller_identity/presentation/widgets/dialogs/)
class CallerIdDialog extends ConsumerStatefulWidget {
  final String phoneNumber;
  final String? countryCode;

  const CallerIdDialog({
    super.key,
    required this.phoneNumber,
    this.countryCode,
  });

  @override
  ConsumerState<CallerIdDialog> createState() => _CallerIdDialogState();

  static void show(BuildContext context, String phoneNumber, {String? countryCode}) {
    showDialog(
      context: context,
      builder: (context) => CallerIdDialog(
        phoneNumber: phoneNumber,
        countryCode: countryCode,
      ),
    );
  }
}

class _CallerIdDialogState extends ConsumerState<CallerIdDialog> {
  bool _isLoading = true;
  String? _errorMessage;
  dynamic _callerIdData;

  @override
  void initState() {
    super.initState();
    _fetchCallerIdData();
  }

  Future<void> _fetchCallerIdData() async {
    final locale = await ref.read(localeProvider.future);
    final callerIdentityService = ref.read(callerIdentityServiceProvider);

    final dlibLocale = dlibphone.Locale(
      language: locale.languageCode,
      country: widget.countryCode ?? locale.countryCode ?? 'US',
    );

    try {
      final callerIdData = await callerIdentityService.getCallerId(widget.phoneNumber, dlibLocale);

      setState(() {
        _callerIdData = callerIdData;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = AppLocalizations.of(context).failedToGetCallerIdInfo(e.toString());
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(AppLocalizations.of(context).fetchingCallerIdInfo),
            ],
          ),
        ),
      );
    }

    if (_errorMessage != null) {
      return Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error, color: Colors.red, size: 48),
              const SizedBox(height: 16),
              Text(_errorMessage!),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text(AppLocalizations.of(context).closeButton),
              ),
            ],
          ),
        ),
      );
    }

    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${AppLocalizations.of(context).number}: ${_callerIdData.phoneNumber}'),
            const SizedBox(height: 8),
            Text('${AppLocalizations.of(context).name}: ${_callerIdData.name}'),
            if (_callerIdData.countryName != null) ...[                  
              const SizedBox(height: 8),
              Text('${AppLocalizations.of(context).country}: ${_callerIdData.countryName}'),
            ],
            if (_callerIdData.region != null) ...[                  
              const SizedBox(height: 8),
              Text('${AppLocalizations.of(context).region}: ${_callerIdData.region}'),
            ],
            if (_callerIdData.carrier != null) ...[                  
              const SizedBox(height: 8),
              Text('${AppLocalizations.of(context).carrier}: ${_callerIdData.carrier}'),
            ],
            if (_callerIdData.labels != null) ...[                  
              const SizedBox(height: 8),
              Text('${AppLocalizations.of(context).labels}: ${_callerIdData.labels!.map((l) => l.label).join(', ')}'),
            ],
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(AppLocalizations.of(context).closeButton),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
