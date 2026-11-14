import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_sms_ui/pyro_sms_ui.dart' as sms_ui;
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 短信拦截配置页面 —— 100% 渲染包内 pyro_sms_ui 自注册标准页面
class SmsFilterPage extends ConsumerWidget {
  const SmsFilterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).smsFilterSettings,
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20, color: Theme.of(context).colorScheme.onSurface),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: Theme.of(context).colorScheme.onSurface),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
      body: const sms_ui.SmsScreeningSettingsPage(),
    );
  }
}
