import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/call/time_interceptor/presentation/widgets/time_interceptor_settings_widget.dart';

// [注释]: 导入 Provider 仅用于在 AppBar 中显示加载状态
import 'package:yourcallyourrule/features/call/time_interceptor/provider/time_interceptor_provider.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

// [重构]: 页面仍然是 ConsumerWidget，但其职责大大简化。
class TimeInterceptorSettingsPage extends ConsumerWidget {
  const TimeInterceptorSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // [注释]: 监听 Notifier 的状态，仅用于在 AppBar 中显示加载指示器。
    // body 部分的 TimeInterceptorSettingsWidget 会自己处理状态。
    final configAsyncValue = ref.watch(timeInterceptorConfigProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.timeInterceptorSettingsTitle),
        actions: [
          // [注释]: 当 Notifier 正在执行异步操作时 (isReloading)，在 AppBar 中显示一个加载指示器，
          // 提供即时的用户反馈。
          if (configAsyncValue.isReloading)
            const Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2.0, color: Colors.white),
                ),
              ),
            ),
        ],
      ),
      // [重构]: body 现在非常简单，直接渲染自包含的 TimeInterceptorSettingsWidget。
      // 不再需要传递任何参数，也不再需要使用 .when 来处理状态，因为子 Widget 自己会处理。
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          TimeInterceptorSettingsWidget(),
        ],
      ),
    );
  }
}