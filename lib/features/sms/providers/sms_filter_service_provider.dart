import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/provider/basic_provider/sms_regex_rule_repository_provider.dart';
import 'package:yourcallyourrule/features/call_statistic/domain/providers/blocked_call_repository_provider.dart';
import 'package:yourcallyourrule/features/sms/repositories/sms_regex_rule_repository.dart';
import 'package:yourcallyourrule/features/sms/services/sms_filter_service.dart';
import 'package:yourcallyourrule/platform/sms_channel_switcher.dart';
import 'package:yourcallyourrule/core/entities/sms/sms_regex_rule.dart';






/// SmsFilterService的Provider
final smsFilterServiceProvider = Provider<SmsFilterService>((ref) {
  final smsRuleRepository = ref.watch(smsRegexRuleRepositoryProvider);
  final blockedCallRepository = ref.watch(blockedCallRepositoryProvider);
  
  // 获取初始规则列表
  List<SmsRegexRule> initialRules = [];
  
  // 获取SMS通道管理器
  final smsChannelManager = SmsChannelSwitcher.getPlatformChannelManager();
  
  final service = SmsFilterService(
    smsChannelManager: smsChannelManager,
    initialRules: initialRules,
    blockedCallRepository: blockedCallRepository,
  );
  
  // 异步初始化
  Future.microtask(() async {
    // 从仓库加载规则
    final rules = await smsRuleRepository.getAll();
    service.addRules(rules);
    await service.initialize();
  });
  
  return service;
});