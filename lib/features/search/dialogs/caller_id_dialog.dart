import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dlibphonenumber/dlibphonenumber.dart' as dlibphone;
import 'package:yourcallyourrule/features/caller_id/services/caller_id_service.dart';
import 'package:yourcallyourrule/features/language/provider/language_provider.dart';

/// 来电显示信息对话框
/// 用于显示来电显示信息
class CallerIdDialog extends StatefulWidget {
  final String phoneNumber;
  final String? countryCode;

  const CallerIdDialog({
    super.key,
    required this.phoneNumber,
    this.countryCode,
  });

  @override
  State<CallerIdDialog> createState() => _CallerIdDialogState();

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

class _CallerIdDialogState extends State<CallerIdDialog> {
  bool _isLoading = true;
  String? _errorMessage;
  dynamic _callerIdData;

  @override
  void initState() {
    super.initState();
    _fetchCallerIdData();
  }

  Future<void> _fetchCallerIdData() async {
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    final callerIdService = Provider.of<CallerIdService>(context, listen: false);

    // 创建 dlibphone.Locale
    final dlibLocale = dlibphone.Locale(
      language: localeProvider.locale.languageCode,
      country: widget.countryCode ?? localeProvider.locale.countryCode ?? 'US',
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
        _errorMessage = '获取来电显示信息失败: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Dialog(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('正在获取来电显示信息...'),
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
                child: const Text('关闭'),
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
            Text('号码: ${_callerIdData.phoneNumber}'),
            const SizedBox(height: 8),
            Text('名称: ${_callerIdData.name}'),
            if (_callerIdData.countryName != null) ...[                  
              const SizedBox(height: 8),
              Text('国家: ${_callerIdData.countryName}'),
            ],
            if (_callerIdData.region != null) ...[                  
              const SizedBox(height: 8),
              Text('地区: ${_callerIdData.region}'),
            ],
            if (_callerIdData.carrier != null) ...[                  
              const SizedBox(height: 8),
              Text('运营商: ${_callerIdData.carrier}'),
            ],
            if (_callerIdData.labels != null) ...[                  
              const SizedBox(height: 8),
              Text('标签: ${_callerIdData.labels!.map((l) => l.label).join(', ')}'),
            ],
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('关闭'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}