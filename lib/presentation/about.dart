import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';



class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  String version = '';

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      version = info.version;
    });
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).about),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 添加 Logo 或 App Icon
            Image.asset(
              'assets/app_logo.png', // 替换成您的 logo 图片路径
              width: 100,
              height: 100,
            ),
            const SizedBox(height: 24),
            Text(
              S.of(context).callerIdApp,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              S.of(context).thisAppIsAPowerfulCallerIdToolThatAllows,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            // 使用 ListTile 构建功能列表
            _buildFeatureCard(context, Icons.cloud,
                    S.of(context).onlineCallerIdSubscription),
            _buildFeatureCard(context, Icons.star_half,
                    S.of(context).wildcardSupportForFlexibleFiltering),
            _buildFeatureCard(context, Icons.block,
                    S.of(context).blacklistingAndWhitelisting),
            _buildFeatureCard(context, Icons.telegram,
                    S.of(context).joinTheTelegramChannelAndGroupForMoreInfo),
            const SizedBox(height: 32),
            // 添加教程链接
            ListTile(
              leading: Icon(Icons.school, color: Theme.of(context).colorScheme.primary),
              title: Text(S.of(context).tutorial),
              trailing: Icon(Icons.chevron_right),
              onTap: () => _launchUrl(Uri.parse('https://github.com/haygcao/yourcallyourruletranslation')),
            ),
            Text(
              S.of(context).contactUs,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 16),

            // 使用 Row 和 IconButton 构建社交媒体链接
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSocialMediaButton(context, NewSet.github,
                    'https://github.com/haygcao/yourcallyourruletranslation'),
                const SizedBox(width: 16),
                _buildSocialMediaButton(
                    context, Icons.telegram, 'https://t.me/yourcallyourrule'),
                const SizedBox(width: 16),
                _buildSocialMediaButton(
                    context, Icons.email, 'mailto:oakjeol@gmail.com'),
              ],
            ),
            const SizedBox(height: 16),
                        Text(
              'Version: $version', // 显示版本号
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  // 构建功能列表项
  Widget _buildFeatureCard(BuildContext context, IconData icon, String title) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.onSurfaceVariant),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 构建社交媒体按钮
  Widget _buildSocialMediaButton(
      BuildContext context, IconData icon, String url) {
    return IconButton(
      onPressed: () => _launchUrl(Uri.parse(url)),
      icon: Icon(icon),
    );
  }
}
