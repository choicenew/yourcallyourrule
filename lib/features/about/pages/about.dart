import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:pyro_about/pyro_about.dart' as pkg_about;
import 'package:yourcallyourrule/features/common/router/app_router.dart';

/// 主 App 关于页面 —— 全量直接调配与消费 pyro_about 微包组件
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
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
      child: Localizations(
        locale: Localizations.localeOf(context),
        delegates: const [
          DefaultMaterialLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
        ],
        child: const pkg_about.AboutPage(
          config: pkg_about.AboutConfig(
            appName: 'Your Call Your Rule',
            version: '4.25.1',
          ),
        ),
      ),
    );
  }
}
