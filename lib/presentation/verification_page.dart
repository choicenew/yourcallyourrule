import 'dart:async';

import 'package:dlibphonenumber/locale.dart' as dlibphone;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/adwidgets/native_ads.dart';
import 'package:yourcallyourrule/ads/google_ad.dart';
import 'package:yourcallyourrule/cloud_sync/provider/backup_restore_provider.dart';
import 'package:yourcallyourrule/core/entities/caller_id_data.dart';
import 'package:yourcallyourrule/core/entities/rule/regex_rule.dart';

import 'package:yourcallyourrule/core/provider/basic_provider/call_log_repository_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/allowed_blocked_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/call_filter_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/caller_id_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/local_count_filter_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/regex_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/remote_number_filter_service_provider.dart';

import 'package:yourcallyourrule/core/provider/providers/rule_management_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/time_interceptor_service_provider.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart' as vo;
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/call/call_filter/call_filter_service.dart';
import 'package:yourcallyourrule/features/call/time_interceptor/time_interceptor_service.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/overlay_handler.dart';
import 'package:yourcallyourrule/features/language/provider/language_provider.dart';
import 'package:yourcallyourrule/core/entities/plugin/plugin_data.dart';
import 'package:yourcallyourrule/features/local_filter/services/local_count_filter_service.dart';
import 'package:yourcallyourrule/features/remote_filter/provider/remote_number_service_provider.dart';
import 'package:yourcallyourrule/features/remote_filter/services/remote_number_filter_service.dart';

class VerificationPage extends ConsumerStatefulWidget {
  const VerificationPage({super.key});

  @override
  VerificationPageState createState() => VerificationPageState();
}

class VerificationPageState extends ConsumerState<VerificationPage> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _countryCodeController =
      TextEditingController(text: "US");
  bool _isLoading = false;
  Map<String, bool> _verificationResults = {};
  CallerIdData? _callerIdData;
  Map<String, dynamic> _legacyPluginData = {};
  PluginData? _pluginData;

  late CallFilterService _callFilterService;
  late TimeInterceptorService _timeInterceptorService;
  late LocalCountFilterService _localCountFilterService;
  late RemoteNumberFilterService _remoteNumberFilterService;
  late StreamSubscription<Map<String, dynamic>> _legacyPluginSubscription;
  late StreamSubscription<PluginData> _pluginSubscription;

  @override
  void initState() {
    super.initState();
    final configRepo = ref.read(configRepositoryProvider);
    final regexService = ref.read(regexServiceProvider);
    final allowedBlockedService = ref.read(allowedBlockedServiceProvider);
    final ruleManagementService = ref.read(ruleManagementServiceProvider);
    final callerIdService = ref.read(callerIdServiceProvider);
    final remoteNumberService = ref.read(remoteNumberServiceProvider);

    _localCountFilterService = ref.read(localCountFilterServiceProvider);

    _remoteNumberFilterService = ref.read(remoteNumberFilterServiceProvider);

    _callFilterService = ref.read(callFilterServiceProvider);

    // 获取CallLogRepository实例
    final callLogRepository = ref.read(callLogRepositoryProvider);
    _timeInterceptorService = ref.read(timeInterceptorServiceProvider);
    _legacyPluginSubscription =
        callerIdService.legacyPluginDataStream.listen((data) {
      setState(() => _legacyPluginData = data);
    });
    
    _pluginSubscription =
        callerIdService.pluginDataStream.listen((data) {
      setState(() => _pluginData = data);
    });
    _loadInterceptorConfig();
  }

  Future<void> _loadInterceptorConfig() async {
    await _timeInterceptorService.initialize();
    setState(() {});
  }

  // 更新后的 _verifyPhoneNumber 方法
  Future<void> _verifyPhoneNumber() async {
    setState(() => _isLoading = true);

    final number = vo.PhoneNumber.fromString(_phoneNumberController.text);
    final countryCode = _countryCodeController.text.toUpperCase();
    final currentLocale = ref.read(localeProvider).locale;
    final dlibLocale = dlibphone.Locale(
      language: currentLocale.languageCode,
      country: countryCode,
    );

    _callerIdData = await ref
        .read(callerIdServiceProvider)
        .getCallerId(number.value, dlibLocale);

    
    final rules = await _callFilterService.verifyAllRules(number);
    _verificationResults = {
      'Allowed': rules.any((rule) => rule.action.type == RuleActionType.allow),
      'Blocked': rules.any((rule) => rule.action.type == RuleActionType.block),
      'Silenced': rules.any((rule) => rule.action.type == RuleActionType.silence),
      'None Action': rules.any((rule) => rule.action.type == RuleActionType.none),
      'Global Reject': _callFilterService.callFilterConfig.rejectAllNumbers,
      'Blacklist': rules.any((rule) => rule.action.type == RuleActionType.block),
      'Whitelist': rules.any((rule) => rule.action.type == RuleActionType.allow),
      'Regex': rules.any((rule) => rule is RegexRule),
      'Time Rules': await _timeInterceptorService.shouldIntercept(number.value),
      'Local Count Filter': !await _localCountFilterService.shouldAcceptCall(number.value),
      'Remote Number Filter': !await _remoteNumberFilterService.shouldAcceptCall(number.value),
    };

    setState(() => _isLoading = false);
  }

  @override
  void dispose() {
    _legacyPluginSubscription.cancel();
    _pluginSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Phone Verification')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 统一广告组件参数配置
            const GoogleAdWidget(adInfo: AdManager.adaptiveBannerAd),
            _buildInputSection(),
            const GoogleAdWidget(adInfo: AdManager.adaptiveBannerAd),
            _buildResultsSection(),
            // 统一广告组件参数配置
            nativeAdWidgetMedium(adWidth: 320, adHeight: 390),
          ],
        ),
      ),
    );
  }

  Widget _buildInputSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _countryCodeController,
            decoration: const InputDecoration(
                labelText: 'Country Code (ISO 3166-1 alpha-2)',
                hintText: 'Example: US, CN, JP',
                icon: Icon(Icons.language)),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _phoneNumberController,
            decoration: const InputDecoration(
                labelText: 'Phone Number',
                hintText: 'Enter phone number (e.g. US)',
                icon: Icon(Icons.phone)),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _isLoading ? null : _verifyPhoneNumber,
            child: const Text('Verify Number'),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Verification Results:', style: TextStyle(fontSize: 18)),
          _buildResultItem(
              'Global Reject All', _verificationResults['Global Reject']),
          _buildResultItem('Allowed', _verificationResults['Allowed']),
          _buildResultItem('Blocked', _verificationResults['Blocked']),
          _buildResultItem('Silenced', _verificationResults['Silenced']),
          _buildResultItem('None Action', _verificationResults['None Action']),
          _buildResultItem(
              'Blacklist Check', _verificationResults['Blacklist']),
          _buildResultItem(
              'Whitelist Check', _verificationResults['Whitelist']),
          _buildResultItem('Time Rules', _verificationResults['Time Rules']),
          _buildResultItem('Regex Match', _verificationResults['Regex']),
          _buildResultItem('Local Count Filter', _verificationResults['Local Count Filter']),
          _buildResultItem('Remote Number Filter', _verificationResults['Remote Number Filter']),
          if (_callerIdData != null) ...[
            const Divider(),
            CircleAvatar(
              backgroundImage: _callerIdData?.avatarImage,
              radius: 28,
              child: _callerIdData?.avatarImage == null
                  ? Text(_callerIdData?.labels?.isNotEmpty == true
                      ? _callerIdData!.labels!.first.label[0].toUpperCase()
                      : '?')
                  : null,
            ),
            const SizedBox(height: 12),
            Text('Carrier: ${_callerIdData?.carrier}'),
            Text('Country: ${_callerIdData?.countryName}'),
            Text('Region: ${_callerIdData?.region}'),
            Text(
                'Label: ${_callerIdData?.labels?.map((l) => l.label).join(', ') ?? "Unknown"}'),
            Text('Number Type: ${_callerIdData?.numberType}'),
            Text('Count Times: ${_callerIdData?.count}'),
            Text('Caller Name: ${_callerIdData?.name}'),
            ElevatedButton(
                onPressed: _testShowCallerIdOverlay,
                child: const Text('Test Overlay'))
          ],
          if (_pluginData != null) ...[  
            const Divider(),
            const Text('Plugin Data:'),
            Text('Name: ${_pluginData?.name ?? "Unknown"}'),
            Text('SourceLabel: ${_pluginData?.sourceLabel ?? "Unknown"}'),            
            Text('Label: ${_pluginData?.predefinedLabel ?? _pluginData?.sourceLabel ?? "Unknown"}'),
            Text('Location: ${[_pluginData?.province, _pluginData?.city].where((e) => e != null).join(", ")}'),
            Text('Carrier: ${_pluginData?.carrier ?? "Unknown"}'),
            Text('Count: ${_pluginData?.count ?? 0}'),
            Text('Action: ${_pluginData?.action.toString() ?? "RuleAction.none"}'),
          ],
          ...[
            const Divider(),
            const Text('Plugin Data:'),
            ..._legacyPluginData.entries.map((e) => Text('${e.key}: ${e.value}'))
          ]
        ],
      ),
    );
  }

  Widget _buildResultItem(String label, bool? result) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        result == true ? Icons.block : Icons.check_circle,
        color: result == true ? Colors.red : Colors.green,
      ),
      title: Text('$label: ${result == true ? 'Blocked' : 'Allowed'}'),
    );
  }

  Future<void> _testShowCallerIdOverlay() async {
    if (_callerIdData != null) {
      await OverlayHandler().showCallerIdOverlay(
          _callerIdData!,
          null, // _stirInfo位置
          null // _simInfo位置
          );
    }
  }
}
