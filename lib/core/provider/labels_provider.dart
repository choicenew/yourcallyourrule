import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/label/label_phone_entry.dart';
import 'package:yourcallyourrule/core/repositories/rule_repository_impl.dart';
import 'package:yourcallyourrule/features/labels/services/label_service.dart';
import 'package:yourcallyourrule/features/labels/services/predefined_label_service.dart';

import 'label_phone_service_provider.dart';

/// 标签服务提供者
/// 提供统一的标签服务入口
final labelServiceProvider = Provider<LabelService>((ref) {
  final ruleRepository = ref.watch(ruleRepositoryProvider);
  final predefinedLabelService = ref.watch(predefinedLabelServiceProvider);
  
  return LabelService(ruleRepository, predefinedLabelService);
});

/// 标签数据提供者 - 直接引用labelPhonesProvider
final labelsProvider = Provider<LabelPhoneNotifier>((ref) {
  return ref.read(labelPhonesProvider.notifier);
});

/// 标签系统服务提供者
/// 整合标签、预定义标签和电话标签服务的统一入口
final labelSystemProvider = Provider<LabelService>((ref) {
  final labelService = ref.watch(labelServiceProvider);
  return labelService;
});