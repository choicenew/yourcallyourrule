import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/call/call_filter/presentation/widgets/call_filter_settings_widget.dart';
import 'package:yourcallyourrule/features/call/call_filter/providers/call_filter_provider.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';



// [重构]: 页面现在是一个简单的容器，负责展示自包含的子 Widget。
class CallFilterSettingsPage extends ConsumerWidget {
  const CallFilterSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // [注释]: 监听状态仅用于在 AppBar 中显示加载指示器。
    final configAsync = ref.watch(callFilterConfigProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.callFilterSettings),
        actions: [
          // [注释]: 当配置正在后台更新时 (isReloading)，显示一个加载指示器。
          if (configAsync.isReloading)
            const Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Center(
                child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2.0, color: Colors.white)),
              ),
            ),
        ],
      ),
      // [重构]: body 现在非常简单，直接渲染自包含的 CallFilterSettingsWidget。
      // 它不再需要任何参数，也不需要 .when 来处理状态，因为子 Widget 会自己处理。
      body: const SingleChildScrollView(
        child: CallFilterSettingsWidget(),
      ),
    );
  }
}