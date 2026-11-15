import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pyro_cloud_drive_ui/pyro_cloud_drive_ui.dart' as cloud_ui;
import 'package:yourcallyourrule/features/common/router/app_router.dart';

/// 云端与本地备份恢复页面 —— 去除重复 Outer Scaffold/AppBar，解决双层 Toolbar 问题
class BackupRestorePage extends ConsumerWidget {
  const BackupRestorePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        if (GoRouter.of(context).canPop()) {
          context.pop();
        } else {
          GoRouter.of(context).goNamed(AppRouter.home);
        }
      },
      child: const cloud_ui.CloudSettingsPage(),
    );
  }
}
