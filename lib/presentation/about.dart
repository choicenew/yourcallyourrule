import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

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
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.aboutTitle),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 顶部区域 - 应用信息
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 32.0),
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  // 应用图标
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: colorScheme.shadow..withValues(alpha:0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/app_logo.png',
                        width: 80,
                        height: 80,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // 应用名称
                  Text(
                    AppLocalizations.of(context)!.callerIdApp,
                    style: textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // 版本号
                  Text(
                    'Version: $version',
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onPrimaryContainer..withValues(alpha:0.8),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // 应用描述
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      AppLocalizations.of(context)!.thisAppIsAPowerfulCallerIdToolThatAllows,
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onPrimaryContainer,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            
            // 功能特点区域
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.features,
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildFeatureCard(
                    context, 
                    Icons.cloud, 
                    AppLocalizations.of(context)!.onlineCallerIdSubscription
                  ),
                  const SizedBox(height: 12),
                  _buildFeatureCard(
                    context, 
                    Icons.star_half, 
                    AppLocalizations.of(context)!.wildcardSupportForFlexibleFiltering
                  ),
                  const SizedBox(height: 12),
                  _buildFeatureCard(
                    context, 
                    Icons.block, 
                    AppLocalizations.of(context)!.blacklistingAndWhitelisting
                  ),
                  const SizedBox(height: 12),
                  _buildFeatureCard(
                    context, 
                    Icons.telegram, 
                    AppLocalizations.of(context)!.joinTheTelegramChannelAndGroupForMoreInfo
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // 教程链接
                  Card(
                    elevation: 0,
                    color: colorScheme.surfaceContainerHighest,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      leading: Icon(Icons.school, color: colorScheme.primary),
                      title: Text(
                        AppLocalizations.of(context)!.tutorial,
                        style: textTheme.titleMedium,
                      ),
                      trailing: Icon(Icons.chevron_right, color: colorScheme.primary),
                      onTap: () => _launchUrl(Uri.parse('https://github.com/choicenew/yourcallrule')),
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // 联系我们区域
                  Center(
                    child: Column(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.contactUs,
                          style: textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        // 社交媒体按钮
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildSocialMediaButton(
                              context, 
                              Icons.code, // 使用代码图标替代GitHub图标
                              'https://github.com/choicenew/yourcallrule',
                              AppLocalizations.of(context)!.github,
                            ),
                            const SizedBox(width: 24),
                            _buildSocialMediaButton(
                              context, 
                              Icons.telegram, 
                              'https://t.me/yourcallyourrule',
                              AppLocalizations.of(context)!.telegram,
                            ),
                            const SizedBox(width: 24),
                            _buildSocialMediaButton(
                              context, 
                              Icons.email, 
                              'mailto:oakjeol@gmail.com',
                              AppLocalizations.of(context)!.email,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 构建功能卡片
  Widget _buildFeatureCard(BuildContext context, IconData icon, String title) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Card(
      elevation: 0,
      color: colorScheme.surfaceVariant,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: colorScheme.primary..withValues(alpha:0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: colorScheme.primary),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 构建社交媒体按钮
  Widget _buildSocialMediaButton(BuildContext context, IconData icon, String url, String label) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Column(
      children: [
        InkWell(
          onTap: () => _launchUrl(Uri.parse(url)),
          borderRadius: BorderRadius.circular(30),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: colorScheme.primary,
              size: 28,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
