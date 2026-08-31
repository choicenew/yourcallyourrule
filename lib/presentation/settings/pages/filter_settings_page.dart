import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// [重构]: 不再需要导入任何 Service 或 Service Provider，因为子 Widget 已经自包含。
import 'package:yourcallyourrule/features/call/call_filter/presentation/widgets/enhanced_composite_filter_settings_widget.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 过滤器设置页面
/// [注释]: 这个页面现在是一个纯粹的容器，负责展示所有过滤器的设置。
class FilterSettingsPage extends ConsumerWidget {
  static const String routeName = '/filter-settings';

  const FilterSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF5),
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.filterSettingsTitle,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 20, color: Colors.black87),
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
      body: const EnhancedCompositeFilterSettingsWidget(),
    );
  }

  // [重构]: _buildEnhancedFilterControlWidget 方法已被完全移除，因为其逻辑已内联到 build 方法中，
  // 并且所有手动获取和传递依赖的逻辑都已被删除。
}