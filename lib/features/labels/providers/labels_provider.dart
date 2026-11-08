import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_phone_marking_protocol/pyro_phone_marking_protocol.dart';
import 'package:yourcallyourrule/features/rules/repositories/rule_repository_impl.dart';
import 'package:yourcallyourrule/features/labels/services/label_service.dart';
import 'package:yourcallyourrule/features/labels/services/predefined_label_service.dart';

import 'label_phone_service_provider.dart';

/// 标签服务提供�?
/// 提供统一的标签服务入�?
final labelServiceProvider = Provider<LabelService>((ref) {
  final ruleRepository = ref.watch(ruleRepositoryProvider);
  final predefinedLabelService = ref.watch(predefinedLabelServiceProvider);
  
  return LabelService(ruleRepository, predefinedLabelService);
});

/// 标签数据提供�?- 直接引用labelPhonesProvider
final labelsProvider = Provider<LabelPhoneNotifier>((ref) {
  return ref.read(labelPhonesProvider.notifier);
});

/// 标签系统服务提供�?
/// 整合标签、预定义标签和电话标签服务的统一入口
final labelSystemProvider = Provider<LabelService>((ref) {
  final labelService = ref.watch(labelServiceProvider);
  return labelService;
});