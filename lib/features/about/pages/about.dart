import 'package:flutter/material.dart';
import 'package:pyro_about/pyro_about.dart' as pkg_about;

/// 主 App 关于页面 —— 全量直接调配与消费 pyro_about 微包组件
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const pkg_about.AboutPage(
      config: pkg_about.AboutConfig(
        appName: 'Your Call Your Rule',
        version: '4.25.1',
      ),
    );
  }
}
