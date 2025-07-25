import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dlibphonenumber/dlibphonenumber.dart' as dlibphone;
import 'package:yourcallyourrule/features/caller_id/services/caller_id_service.dart';
import 'package:yourcallyourrule/features/language/provider/language_provider.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/core/provider/providers/caller_id_service_provider.dart';

/// 来电显示信息对话框
/// 用于显示来电显示信息
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

  /// 显示来电显示信息对话框的静态方法
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
    final localeState = ref.read(localeProvider);
    final callerIdService = ref.read(callerIdServiceProvider);

    // 创建 dlibphone.Locale
    final dlibLocale = dlibphone.Locale(
      language: localeState.locale.languageCode,
      country: widget.countryCode ?? localeState.locale.countryCode ?? 'US',
    );

    try {
      // 获取来电显示信息
      final callerIdData = await callerIdService.getCallerId(widget.phoneNumber, dlibLocale);

      setState(() {
        _callerIdData = callerIdData;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = AppLocalizations.of(context)!.failedToGetCallerIdInfo(e.toString());
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
              Text(AppLocalizations.of(context)!.fetchingCallerIdInfo),
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
                child: Text(AppLocalizations.of(context)!.closeButton),
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
            Text('${AppLocalizations.of(context)!.number}: ${_callerIdData.phoneNumber}'),
            const SizedBox(height: 8),
            Text('${AppLocalizations.of(context)!.name}: ${_callerIdData.name}'),
            if (_callerIdData.countryName != null) ...[                  
              const SizedBox(height: 8),
              Text('${AppLocalizations.of(context)!.country}: ${_callerIdData.countryName}'),
            ],
            if (_callerIdData.region != null) ...[                  
              const SizedBox(height: 8),
              Text('${AppLocalizations.of(context)!.region}: ${_callerIdData.region}'),
            ],
            if (_callerIdData.carrier != null) ...[                  
              const SizedBox(height: 8),
              Text('${AppLocalizations.of(context)!.carrier}: ${_callerIdData.carrier}'),
            ],
            if (_callerIdData.labels != null) ...[                  
              const SizedBox(height: 8),
              Text('${AppLocalizations.of(context)!.labels}: ${_callerIdData.labels!.map((l) => l.label).join(', ')}'),
            ],
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(AppLocalizations.of(context)!.closeButton),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}