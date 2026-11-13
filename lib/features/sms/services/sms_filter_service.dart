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

  SmsFilterService({SmsHub? hub})
      : _pipeline = SmsScreeningPipeline(hub ?? SmsHub.instance);

  /// 全量交由 pyro_sms_hub 的 SmsScreeningPipeline 进行评估
  Future<SmsScreeningResult> screenMessage(SmsMessageEntity message) async {
    return await _pipeline.evaluate(message);
  }

  Future<bool> shouldNotify(String phoneNumber, String messageContent) async {
    final result = await screenMessage(SmsMessageEntity(
      sender: phoneNumber,
      body: messageContent,
      timestamp: DateTime.now(),
    ));
    return result.recommendedAction == SmsFilterAction.allow;
  }
}
