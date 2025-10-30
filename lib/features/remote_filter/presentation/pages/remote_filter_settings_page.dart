import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/remote_filter/presentation/widgets/remote_filter_settings_widget.dart';
import 'package:yourcallyourrule/features/remote_filter/provider/remote_number_filter_provider.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';


// [重构]: 页面现在是一个简单的容器。
class RemoteFilterSettingsPage extends ConsumerWidget {
  const RemoteFilterSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // [注释]: 监听状态仅用于在 AppBar 中显示加载指示器。
    final configAsync = ref.watch(remoteNumberFilterConfigProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.remoteFilterSettingsPageTitle),
        actions: [
          // [注释]: 当配置正在后台更新时 (isReloading)，显示一个加载指示器。
          if (configAsync.isReloading)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white)),
            )
        ],
      ),
      // [重构]: body 直接渲染自包含的 RemoteFilterSettingsWidget。
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: RemoteFilterSettingsWidget(),
        ),
      ),
    );
  }
}