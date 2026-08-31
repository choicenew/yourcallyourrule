import 'dart:async';

import 'package:yourcallyourrule/features/call/call_filter/call_filter_service.dart';
import 'package:yourcallyourrule/features/call/time_interceptor/service/time_interceptor_service.dart';
import 'package:yourcallyourrule/features/local_filter/services/local_count_filter_service.dart';
import 'package:yourcallyourrule/features/remote_filter/services/remote_number_filter_service.dart';



import 'package:dlibphonenumber/locale.dart' as dlibphone;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/adwidgets/native_ads.dart';
import 'package:yourcallyourrule/ads/google_ad.dart';
import 'package:yourcallyourrule/core/entities/caller_id_data.dart';
import 'package:yourcallyourrule/core/entities/rule/regex_rule.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart' as vo;
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/overlay_handler.dart';
import 'package:yourcallyourrule/features/language/provider/language_provider.dart';
import 'package:yourcallyourrule/core/entities/plugin/plugin_source_data.dart';

// [重构]: 导入所有需要的 Provider，而不是 Service 定义。

import 'package:yourcallyourrule/common/utils/phone_utils.dart';
import 'package:yourcallyourrule/features/caller_id/providers/caller_id_service_provider.dart';



// [重构]: 导入 Config Notifier Provider 以获取最新配置
import 'package:yourcallyourrule/features/call/call_filter/providers/call_filter_provider.dart';


class VerificationPage extends ConsumerStatefulWidget {
  final String? initialPhoneNumber;
  const VerificationPage({super.key, this.initialPhoneNumber});

  @override
  VerificationPageState createState() => VerificationPageState();
}

class VerificationPageState extends ConsumerState<VerificationPage> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _countryCodeController = TextEditingController(text: "US");
  
  // [重构]: 只保留与UI直接相关的状态。
  bool _isLoading = false;
  Map<String, bool> _verificationResults = {};
  CallerIdData? _callerIdData;
  Map<String, dynamic> _legacyPluginData = {};
  PluginSourceData? _pluginSourceData;

  // [重构]: 移除所有 Service 成员变量。
  // late CallFilterService _callFilterService;
  // late TimeInterceptorService _timeInterceptorService;
  // ... etc.

  // [注释]: StreamSubscription 仍然需要在 State 中管理其生命周期。
  StreamSubscription<Map<String, dynamic>>? _legacyPluginSubscription;
  StreamSubscription<PluginSourceData>? _pluginSubscription;

  @override
  void initState() {
    super.initState();
    // [重构]: initState 现在非常干净。不应在此处使用 ref.read。
    // [注释]: 可以在 didChangeDependencies 或 build 方法中安全地访问 ref。
    
    if (widget.initialPhoneNumber != null && widget.initialPhoneNumber!.isNotEmpty) {
      _phoneNumberController.text = widget.initialPhoneNumber!;
      _detectCountryCode(widget.initialPhoneNumber!);
    }
  }

  Future<void> _detectCountryCode(String phoneNumber) async {
    try {
      final result = await PhoneUtils.parsePhoneNumber(phoneNumber);
      final countryCode = result['countryCode'];
      if (countryCode != null && countryCode.isNotEmpty) {
        if (mounted) {
          setState(() {
            _countryCodeController.text = countryCode;
          });
        }
      }
    } catch (e) {
      // ignore error, keep default "US"
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // [注释]: 订阅 Stream 的逻辑放在 didChangeDependencies 中更安全，
    // 因为它可以访问 ref 并且在依赖变化时可以重新订阅。
    // 我们只订阅一次。
    if (_pluginSubscription == null) {
      final callerIdService = ref.read(callerIdServiceProvider);
      _legacyPluginSubscription = callerIdService.legacyPluginDataStream.listen((data) {
        if (mounted) setState(() => _legacyPluginData = data);
      });
      _pluginSubscription = callerIdService.pluginDataStream.listen((data) {
        if (mounted) setState(() => _pluginSourceData = data);
      });
    }
  }

  // [重构]: 移除 _loadInterceptorConfig 方法，因为它不再需要。

  // [重构]: 核心修改部分，所有依赖都在方法执行时动态获取。
  Future<void> _verifyPhoneNumber() async {
    if (mounted) setState(() => _isLoading = true);

    // [注释]: 在异步方法中，使用 ref.read 是安全的。
    // 这将获取所有 Service 的最新实例。
    final callFilterService = ref.read(callFilterServiceProvider);
    final timeInterceptorService = ref.read(timeInterceptorServiceProvider);
    final localCountFilterService = ref.read(localCountFilterServiceProvider);
    final remoteNumberFilterService = ref.read(remoteNumberFilterServiceProvider);
    final callerIdService = ref.read(callerIdServiceProvider);
    
    // [注释]: 获取最新的配置状态也应该是异步的。
    final callFilterConfig = await ref.read(callFilterConfigProvider.future);

    final number = vo.PhoneNumber.fromString(_phoneNumberController.text);
    final countryCode = _countryCodeController.text.toUpperCase();
    final currentLocale = await ref.read(localeProvider.future);
    final dlibLocale = dlibphone.Locale(
      language: currentLocale.languageCode,
      country: countryCode,
    );

    _callerIdData = await callerIdService.getCallerId(number.value, dlibLocale);
    
    final rules = await callFilterService.verifyAllRules(number);
    
    // [重构]: 所有验证逻辑现在都使用在方法内实时获取的 service 和 config。
    _verificationResults = {
      'Allowed': rules.any((rule) => rule.action.type == RuleActionType.allow),
      'Blocked': rules.any((rule) => rule.action.type == RuleActionType.block),
      'Silenced': rules.any((rule) => rule.action.type == RuleActionType.silence),
      'None Action': rules.any((rule) => rule.action.type == RuleActionType.none),
      // [修正]: 从最新的配置对象中读取，而不是从过时的 service 实例中读取。
      'Global Reject': callFilterConfig.rejectAllNumbers,
      'Blacklist': rules.any((rule) => rule.action.type == RuleActionType.block),
      'Whitelist': rules.any((rule) => rule.action.type == RuleActionType.allow),
      'Regex': rules.any((rule) => rule is RegexRule),
      'Time Rules': await timeInterceptorService.shouldIntercept(number.value),
      'Local Count Filter': !await localCountFilterService.shouldAcceptCall(number.value),
      'Remote Number Filter': !await remoteNumberFilterService.shouldAcceptCall(number.value),
    };

    if (mounted) setState(() => _isLoading = false);
  }

  @override
  void dispose() {
    _legacyPluginSubscription?.cancel();
    _pluginSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF5),
      appBar: AppBar(
        title: const Text(
          'Phone Verification',
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20, color: Colors.black87),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        foregroundColor: Colors.black87,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: Colors.black87),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          children: [
            const GoogleAdWidget(adInfo: AdManager.adaptiveBannerAd),
            const SizedBox(height: 12),
            _buildInputSection(),
            const SizedBox(height: 14),
            const GoogleAdWidget(adInfo: AdManager.adaptiveBannerAd),
            const SizedBox(height: 14),
            _buildResultsSection(),
            const SizedBox(height: 14),
            nativeAdWidgetMedium(adWidth: 320, adHeight: 390),
          ],
        ),
      ),
    );
  }

  Widget _buildInputSection() {
    return Container(
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFEDE8DF),
          width: 1.1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          TextField(
            controller: _countryCodeController,
            decoration: InputDecoration(
              labelText: 'Country Code (ISO 3166-1 alpha-2)',
              labelStyle: TextStyle(fontSize: 13, color: Colors.grey[700], fontWeight: FontWeight.w600),
              hintText: 'Example: US, CN, JP',
              hintStyle: const TextStyle(fontSize: 13, color: Colors.black26),
              prefixIcon: const Icon(Icons.language_rounded, color: Color(0xFF2D9CDB), size: 20),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: Color(0xFFEDE8DF), width: 1.1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: Color(0xFF2D9CDB), width: 1.5),
              ),
              filled: true,
              fillColor: const Color(0xFFF7F5F0),
              contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            ),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: _phoneNumberController,
            decoration: InputDecoration(
              labelText: 'Phone Number',
              labelStyle: TextStyle(fontSize: 13, color: Colors.grey[700], fontWeight: FontWeight.w600),
              hintText: 'Enter phone number (e.g. US)',
              hintStyle: const TextStyle(fontSize: 13, color: Colors.black26),
              prefixIcon: const Icon(Icons.phone_rounded, color: Color(0xFFFF9500), size: 20),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: Color(0xFFEDE8DF), width: 1.1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: Color(0xFFFF9500), width: 1.5),
              ),
              filled: true,
              fillColor: const Color(0xFFF7F5F0),
              contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            ),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _isLoading ? null : _verifyPhoneNumber,
              icon: _isLoading 
                  ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : const Icon(Icons.verified_rounded, size: 18),
              label: const Text('Verify Number', style: TextStyle(fontWeight: FontWeight.w800)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF9500),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                padding: const EdgeInsets.symmetric(vertical: 13),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsSection() {
    return Container(
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFEDE8DF),
          width: 1.1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Verification Results:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.black87)),
          const SizedBox(height: 10),
          _buildResultItem('Global Reject All', _verificationResults['Global Reject']),
          _buildResultItem('Allowed', _verificationResults['Allowed']),
          _buildResultItem('Blocked', _verificationResults['Blocked']),
          _buildResultItem('Silenced', _verificationResults['Silenced']),
          _buildResultItem('None Action', _verificationResults['None Action']),
          _buildResultItem('Blacklist Check', _verificationResults['Blacklist']),
          _buildResultItem('Whitelist Check', _verificationResults['Whitelist']),
          _buildResultItem('Time Rules', _verificationResults['Time Rules']),
          _buildResultItem('Regex Match', _verificationResults['Regex']),
          _buildResultItem('Local Count Filter', _verificationResults['Local Count Filter']),
          _buildResultItem('Remote Number Filter', _verificationResults['Remote Number Filter']),
          if (_callerIdData != null) ...[
            const Divider(height: 24),
            CircleAvatar(
              backgroundImage: _callerIdData?.avatarImage,
              radius: 26,
              backgroundColor: const Color(0xFFFF9500),
              child: _callerIdData?.avatarImage == null
                  ? Text(
                      _callerIdData?.labels?.isNotEmpty == true
                          ? _callerIdData!.labels!.first.label[0].toUpperCase()
                          : '?',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    )
                  : null,
            ),
            const SizedBox(height: 10),
            Text('Carrier: ${_callerIdData?.carrier ?? "N/A"}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
            Text('Country: ${_callerIdData?.countryName ?? "N/A"}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
            Text('Region: ${_callerIdData?.region ?? "N/A"}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
            Text('Label: ${_callerIdData?.labels?.map((l) => l.label).join(', ') ?? "Unknown"}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
            Text('Number Type: ${_callerIdData?.numberType ?? "N/A"}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
            Text('Count Times: ${_callerIdData?.count ?? 0}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
            Text('Caller Name: ${_callerIdData?.name ?? "N/A"}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _testShowCallerIdOverlay,
              icon: const Icon(Icons.picture_in_picture_alt_rounded, size: 16),
              label: const Text('Test Overlay', style: TextStyle(fontWeight: FontWeight.w800)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6C5CE7),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
          if (_pluginSourceData != null) ...[  
            const Divider(height: 24),
            const Text('Plugin Data:', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
            const SizedBox(height: 6),
            Text('Name: ${_pluginSourceData?.name ?? "Unknown"}', style: const TextStyle(fontSize: 13)),
            Text('SourceLabel: ${_pluginSourceData?.sourceLabel ?? "Unknown"}', style: const TextStyle(fontSize: 13)),            
            Text('Label: ${_pluginSourceData?.predefinedLabel ?? _pluginSourceData?.sourceLabel ?? "Unknown"}', style: const TextStyle(fontSize: 13)),
            Text('Location: ${[_pluginSourceData?.province, _pluginSourceData?.city].where((e) => e != null).join(", ")}', style: const TextStyle(fontSize: 13)),
            Text('Carrier: ${_pluginSourceData?.carrier ?? "Unknown"}', style: const TextStyle(fontSize: 13)),
            Text('Count: ${_pluginSourceData?.count ?? 0}', style: const TextStyle(fontSize: 13)),
            Text('Action: ${_pluginSourceData?.action.toString() ?? "RuleAction.none"}', style: const TextStyle(fontSize: 13)),
          ],
          if (_legacyPluginData.isNotEmpty) ...[
            const Divider(height: 24),
            const Text('Legacy Plugin Data:', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
            const SizedBox(height: 6),
            ..._legacyPluginData.entries.map((e) => Text('${e.key}: ${e.value}', style: const TextStyle(fontSize: 13))),
          ]
        ],
      ),
    );
  }

  Widget _buildResultItem(String label, bool? result) {
    // [注释]: 这个纯UI构建方法保持不变。
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
    // [注释]: 这个方法的逻辑已经是正确的，因为它使用了 ref.read，保持不变。
    if (_callerIdData != null) {
        // 【核心修正】
      // 1. 不再手动创建 `OverlayHandler` 实例。
      // await OverlayHandler().showCallerIdOverlay(...); // <-- REMOVED

      // 2. 通过 `ref.read()` 从 Riverpod 容器中获取由 `overlayHandlerProvider` 提供的、
      //    全应用共享的唯一 `OverlayHandler` 实例。
      //    `ref` 在 `ConsumerState` 中是可直接访问的。
      final overlayHandler = ref.read(overlayHandlerProvider);

      // 3. 直接调用共享实例的 showCallerIdOverlay 方法。
      //    这个实例能够正确地访问它所依赖的其他 Provider（比如样式配置），
      //    确保显示的悬浮窗样式与自定义设置中的保持一致。
      //    我们传递 null 作为 stirInfo 和 simInfo，因为在这个测试页面中我们没有这些数据。
      await overlayHandler.showCallerIdOverlay(
          _callerIdData!,
          null, // _stirInfo
          null // _simInfo
      );
    }
  }
}