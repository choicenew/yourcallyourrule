import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_sms_protocol/pyro_sms_protocol.dart';
import 'package:pyro_sms_hub/pyro_sms_hub.dart';

part 'sms_filter_service.g.dart';

@Riverpod(keepAlive: true)
SmsFilterService smsFilterService(Ref ref) {
  return SmsFilterService();
}

/// 宿主 App 短信过滤服务代理层 —— 全量委托给 packages/sms/ (pyro_sms_hub)
class SmsFilterService {
  final SmsScreeningPipeline _pipeline;
  bool _isEnabled = true;
  bool _useLocalNotification = true;

  SmsFilterService({SmsHub? hub})
      : _pipeline = SmsScreeningPipeline(hub ?? SmsHub.instance);

  /// 全量交由 pyro_sms_hub 的 SmsScreeningPipeline 进行评估
  Future<SmsScreeningResult> screenMessage(SmsMessageEntity message) async {
    return await _pipeline.evaluate(message);
  }

  Future<bool> shouldNotify(String phoneNumber, String messageContent) async {
    if (!_isEnabled) return true;
    final result = await screenMessage(SmsMessageEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      sender: phoneNumber,
      body: messageContent,
      timestamp: DateTime.now(),
    ));
    return result.recommendedAction == SmsFilterAction.allow;
  }

  Future<void> setEnabled(bool enabled) async {
    _isEnabled = enabled;
  }

  Future<void> setUseLocalNotification(bool useLocal) async {
    _useLocalNotification = useLocal;
  }

  Future<void> closeLocalNotification(bool cancelLocal) async {
    _useLocalNotification = !cancelLocal;
  }

  Future<List<dynamic>> getRules() async => [];
  Future<void> updateRules(List<dynamic> rules) async {}
  Future<void> addRules(List<dynamic> rules) async {}
}
