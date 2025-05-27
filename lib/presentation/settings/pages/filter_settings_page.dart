import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourcallyourrule/features/call/call_filter/call_filter_service.dart';
import 'package:yourcallyourrule/features/call/call_filter/enhanced_composite_filter_service.dart';
import 'package:yourcallyourrule/features/call/call_filter/sim_slot_rule_service.dart';
import 'package:yourcallyourrule/features/call/time_interceptor/time_interceptor_service.dart';
import 'package:yourcallyourrule/features/call/call_filter/presentation/widgets/enhanced_composite_filter_settings_widget.dart';
import 'package:yourcallyourrule/features/local_filter/services/local_count_filter_service.dart';
import 'package:yourcallyourrule/features/remote_filter/services/remote_number_filter_service.dart';

/// 过滤器设置页面
/// 用于展示和控制所有过滤器的设置
class FilterSettingsPage extends StatelessWidget {
  static const String routeName = '/filter-settings';

  const FilterSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('过滤器设置'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _buildEnhancedFilterControlWidget(context),
        ),
      ),
    );
  }

  Widget _buildEnhancedFilterControlWidget(BuildContext context) {
    // 从Provider获取各服务实例
    final callFilterService = Provider.of<CallFilterService>(context);
    final localCountFilterService = Provider.of<LocalCountFilterService>(context);
    final remoteNumberFilterService = Provider.of<RemoteNumberFilterService>(context);
    final timeInterceptorService = Provider.of<TimeInterceptorService>(context);
    final enhancedCompositeFilterService = Provider.of<EnhancedCompositeFilterService>(context);
    final simSlotRuleService = Provider.of<SimSlotRuleService>(context);

    // 使用EnhancedCompositeFilterSettingsWidget显示所有过滤器控制
    return EnhancedCompositeFilterSettingsWidget(
      enhancedCompositeFilterService: enhancedCompositeFilterService,
      localCountFilterService: localCountFilterService,
      remoteNumberFilterService: remoteNumberFilterService,
     
      simSlotRuleService: simSlotRuleService,
      callFilterConfig: callFilterService.callFilterConfig,
    );
  }
}