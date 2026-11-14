import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_cloud_drive_ui/pyro_cloud_drive_ui.dart' as cloud_ui;

/// 云盘设置页面 —— 100% 渲染包内 pyro_cloud_drive_ui 自注册标准页面
class CloudSettingsPage extends ConsumerWidget {
  const CloudSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Localizations(
      locale: Localizations.localeOf(context),
      delegates: const [
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      child: const cloud_ui.CloudSettingsPage(),
    );
  }
}
