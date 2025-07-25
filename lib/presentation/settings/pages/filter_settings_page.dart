import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/provider/providers/call_filter_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/enhanced_composite_filter_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/local_count_filter_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/remote_number_filter_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/sim_slot_rule_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/time_interceptor_service_provider.dart';
import 'package:yourcallyourrule/features/call/call_filter/call_filter_service.dart';
import 'package:yourcallyourrule/features/call/call_filter/enhanced_composite_filter_service.dart';
import 'package:yourcallyourrule/features/call/call_filter/sim_slot_rule_service.dart';
import 'package:yourcallyourrule/features/call/time_interceptor/time_interceptor_service.dart';
import 'package:yourcallyourrule/features/call/call_filter/presentation/widgets/enhanced_composite_filter_settings_widget.dart';
import 'package:yourcallyourrule/features/local_filter/services/local_count_filter_service.dart';
import 'package:yourcallyourrule/features/remote_filter/services/remote_number_filter_service.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 过滤器设置页面
/// 用于展示和控制所有过滤器的设置
class FilterSettingsPage extends ConsumerWidget {
  static const String routeName = '/filter-settings';

  const FilterSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.filterSettingsTitle),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _buildEnhancedFilterControlWidget(context, ref),
        ),
      ),
    );
  }

  Widget _buildEnhancedFilterControlWidget(BuildContext context, WidgetRef ref) {
    // 从Provider获取各服务实例
    final callFilterService = ref.read(callFilterServiceProvider);
    final localCountFilterService = ref.read(localCountFilterServiceProvider);
    final remoteNumberFilterService = ref.read(remoteNumberFilterServiceProvider);
    final timeInterceptorService = ref.read(timeInterceptorServiceProvider);
    final enhancedCompositeFilterService = ref.read(enhancedCompositeFilterServiceProvider);
    final simSlotRuleService = ref.read(simSlotRuleServiceProvider);

    // 使用EnhancedCompositeFilterSettingsWidget显示所有过滤器控制
    return SizedBox(
      height: MediaQuery.of(context).size.height - 100, // 设置固定高度
      child: EnhancedCompositeFilterSettingsWidget(
        enhancedCompositeFilterService: enhancedCompositeFilterService,
        localCountFilterService: localCountFilterService,
        remoteNumberFilterService: remoteNumberFilterService,
        simSlotRuleService: simSlotRuleService,
        callFilterConfig: callFilterService.callFilterConfig,
      ),
    );
  }
}