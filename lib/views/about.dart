import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yourcallyourrule/new_set_icons.dart';

import '../generated/l10n.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

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
            _buildFeatureTile(
                context, S.of(context).onlineCallerIdSubscription),
            _buildFeatureTile(
                context, S.of(context).wildcardSupportForFlexibleFiltering),
            _buildFeatureTile(
                context, S.of(context).blacklistingAndWhitelisting),
            _buildFeatureTile(context,
                S.of(context).joinTheTelegramChannelAndGroupForMoreInfo),
            const SizedBox(height: 32),
            // 添加教程链接
            InkWell(
              onTap: () => _launchUrl(Uri.parse(
                  'https://github.com/haygcao/yourcallyourruletranslation')),
              child: Text(
                S.of(context).tutorial,
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            Text(
              S.of(context).contactUs,
              style: TextStyle(
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
          ],
        ),
      ),
    );
  }

  // 构建功能列表项
  Widget _buildFeatureTile(BuildContext context, String feature) {
    return ListTile(
      leading: const Icon(Icons.check),
      title: Text(feature),
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
