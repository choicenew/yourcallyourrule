
import 'package:flutter/material.dart';

import '../generated/l10n.dart'; // 导入BuildContext



// 扩展方法
extension StringExtension on String {
  String translate(BuildContext context) {
    return translateString(this, context);
  }
}

String translateString(String text, BuildContext context) {
  switch (text) {
    // ... 其他已有的翻译
    case "SubscriptionModel":
      return S.of(context).subscriptionmodel;
    case "ContactSubscription":
      return S.of(context).contactsubscription;
    case "AutoBackup":
      return S.of(context).autobackup;
    case "PluginUpdate":
      return S.of(context).pluginupdate;
    case "RecordBackup":
      return S.of(context).recordbackup;
    default:
      return text;
  }
}

