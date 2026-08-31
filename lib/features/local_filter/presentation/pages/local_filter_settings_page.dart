import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/local_filter/presentation/widgets/local_filter_settings_widget.dart';
import 'package:yourcallyourrule/features/local_filter/provider/local_count_filter_provider.dart';

import 'package:yourcallyourrule/generated/app_localizations.dart';


// [重构]: 页面现在是一个简单的容器。
class LocalFilterSettingsPage extends ConsumerWidget {
  const LocalFilterSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // [注释]: 监听状态仅用于在 AppBar 中显示加载指示器。
    final configAsync = ref.watch(localCountFilterConfigProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF5),
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.localCountFilterSettings,
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
        actions: [
          // [注释]: 当配置正在后台更新时，显示加载指示器。
          if (configAsync.isReloading)
            const Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Center(
                child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2.0, color: Color(0xFFFF9500))),
              ),
            ),
        ],
      ),
      // [重构]: body 直接渲染自包含的 LocalFilterSettingsWidget。
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        children: const [
          LocalFilterSettingsWidget(),
        ],
      ),
    );
  }
}