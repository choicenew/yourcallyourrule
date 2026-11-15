import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:pyro_about/pyro_about.dart' as pkg_about;
import 'package:yourcallyourrule/features/common/router/app_router.dart';

/// 主 App 关于页面 —— 消费 pyro_about 标准微包，全量包含联系方式、Telegram、Discord、官网与隐私条款
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
        child: pkg_about.AboutPage(
          config: pkg_about.AboutConfig(
            appName: 'Your Call Your Rule',
            version: '4.25.1',
            buildNumber: '4251',
            tagline: 'Your Call, Your Rule - NextGen Spam Call & SMS Interceptor',
            description: 'Powerful, privacy-first offline phone call and SMS filter engine with multi-SIM slot rules, remote crowdsourcing intelligence, and cloud drive backup.',
            developers: const [
              pkg_about.DeveloperInfo(
                name: 'Pyro Dev Team',
                role: 'Core Architecture',
                email: 'support@yourcallyourrule.com',
                githubUrl: 'https://github.com/choicenew',
              ),
            ],
            contactLinks: const [
              pkg_about.ContactLink(
                type: pkg_about.ContactChannelType.website,
                url: 'https://yourcallyourrule.com',
                title: 'Official Website',
                customIcon: Icons.public,
              ),
              pkg_about.ContactLink(
                type: pkg_about.ContactChannelType.discord,
                url: 'https://discord.gg/sbZyXKPbq6',
                title: 'Discord Community',
                customIcon: Icons.forum_rounded,
              ),
              pkg_about.ContactLink(
                type: pkg_about.ContactChannelType.telegram,
                url: 'https://t.me/yourcallyourrule_official',
                title: 'Telegram Group',
                customIcon: Icons.send,
              ),
              pkg_about.ContactLink(
                type: pkg_about.ContactChannelType.email,
                url: 'mailto:support@yourcallyourrule.com',
                title: 'Support Email',
                customIcon: Icons.email_outlined,
              ),
            ],
            privacyPolicyUrl: 'https://yourcallyourrule.com/privacy',
            termsOfServiceUrl: 'https://yourcallyourrule.com/terms',
          ),
        ),
      ),
    );
  }
}
