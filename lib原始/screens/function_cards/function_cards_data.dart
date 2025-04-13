import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../../new_set_icons.dart';
import '../../views/allowed/allowed_page.dart';
import '../../views/blacklist/blacklist_page.dart';
import '../../views/blocked/blocked_page.dart';
import '../../views/contact_Subscription/contact_page.dart';
import '../../views/label/label_page.dart';
import '../../views/plugins/plugins_page.dart';
import '../../views/sms_no_blacklist/blacklist_page.dart';
import '../../views/sms_no_whitelist/whitelist_page.dart';
import '../../views/sms_subscription/subscription_page.dart';
import '../../views/sms_text_blacklist/blacklist_page.dart';
import '../../views/sms_text_whitelist/whitelist_page.dart';
import '../../views/subscription/subscription_page.dart';
import '../../views/sync/backup_restore_page.dart';
import '../../views/whitelist/whitelist_page.dart';
import '../../views/wildcard/regex_page.dart';
import 'function_card.dart';

// 创建 卡片实例
List<FunctionCard> getFunctionCards() {
  return [
    FunctionCard(
      page: const SubscriptionListView(),
      startColor: const Color.fromRGBO(231, 70, 69, 1),
      endColor: const Color.fromRGBO(231, 70, 69, 1),
      iconBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
      icon: NewSet.subscription,
      title: S.current.subscribe,
      titleColor: Colors.white,
    ),
    FunctionCard(
      page: const ContactSubscriptionListView(),
      startColor: const Color(0xFF86D293),
      endColor: const Color(0xFF86D293),
      iconBackgroundColor: Colors.white,
      icon: NewSet.contact,
      title: S.current.contacts,
      titleColor: Colors.white,
    ),
    FunctionCard(
      page: const WhitelistPageView(),
      startColor: const Color.fromRGBO(250, 181, 122, 1),
      endColor: const Color.fromRGBO(250, 181, 122, 1),
      iconBackgroundColor: Colors.white,
      icon: NewSet.whitelist,
      title: S.current.whitelist,
      titleColor: Colors.white,
    ),
    FunctionCard(
      page: const BlacklistPageView(),
      startColor: const Color(0xFF00CCDD),
      endColor: const Color(0xFF00CCDD),
      iconBackgroundColor: Colors.white,
      icon: NewSet.blacklist_fill,
      title: S.current.blacklist,
      titleColor: Colors.white,
    ),
    FunctionCard(
      page: const AllowedPageView(),
      startColor: const Color(0xFFA594F9),
      endColor: const Color(0xFFA594F9),
      iconBackgroundColor: Colors.white,
      icon: NewSet.allowed,
      title: S.current.allowed,
      titleColor: Colors.white,
    ),
    FunctionCard(
      page: const BlockedPageView(),
      startColor: const Color(0xFF78B7D0),
      endColor: const Color(0xFF78B7D0),
      iconBackgroundColor: Colors.white,
      icon: NewSet.blocked,
      title: S.current.blocked,
      titleColor: Colors.white,
    ),
    FunctionCard(
      page: const RegexPageView(),
      startColor: const Color(0xFFFCCD2A),
      endColor: const Color(0xFFFCCD2A),
      iconBackgroundColor: Colors.white,
      icon: NewSet.wildcard,
      title: S.current.regex,
      titleColor: Colors.white,
    ),
    FunctionCard(
      page: const BackupRestoreView(),
      startColor: const Color(0xFF7695FF),
      endColor: const Color(0xFF7695FF),
      iconBackgroundColor: Colors.white,
      icon: NewSet.cloud_sync,
      title: S.current.sync,
      titleColor: Colors.white,
    ),
    FunctionCard(
      page: const LabelPageView(),
      startColor: const Color(0xFF82CD47),
      endColor: const Color(0xFF82CD47),
      iconBackgroundColor: Colors.white,
      icon: NewSet.label,
      title: S.current.label,
      titleColor: Colors.white,
    ),
    FunctionCard(
      page: const PluginsPageView(),
      startColor: const Color(0xFFF875AA),
      endColor: const Color(0xFFF875AA),
      iconBackgroundColor: Colors.white,
      icon: Icons.extension,
      title: S.current.plugins,
      titleColor: Colors.white,
    ),
    FunctionCard(
      page: const SmsSubscriptionListView(),
      startColor: const Color(0xFFFFB1B1),
      endColor: const Color(0xFFFFB1B1),
      iconBackgroundColor: Colors.white,
      icon: Icons.format_list_bulleted_add,
      title: S.current.smsSubscribe,
      titleColor: Colors.white,
    ),
    FunctionCard(
      page: const SmsBlacklistPageView(),
      startColor: const Color(0xFF08C1FF),
      endColor: const Color(0xFF08C1FF),
      iconBackgroundColor: Colors.white,
      icon: NewSet.chat_off,
      title: S.current.smsBlacklist,
      titleColor: Colors.white,
    ),
    FunctionCard(
      page: const SmsWhitelistPageView(),
      startColor: const Color(0xFFFFD09B),
      endColor: const Color(0xFFFFD09B),
      iconBackgroundColor: Colors.white,
      icon: NewSet.chat_check,
      title: S.current.smsWhitelist,
      titleColor: Colors.white,
    ),
    FunctionCard(
      page: const SmsTextBlacklistPageView(),
      startColor: const Color(0xFF6A9AB0),
      endColor: const Color(0xFF6A9AB0),
      iconBackgroundColor: Colors.white,
      icon: NewSet.chat_delete,
      title: S.current.smsTextBlacklist,
      titleColor: Colors.white,
    ),
    FunctionCard(
      page: const SmsTextWhitelistPageView(),
      startColor: const Color(0xFF90D14F),
      endColor: const Color(0xFF90D14F),
      iconBackgroundColor: Colors.white,
      icon: NewSet.chat_quote,
      title: S.current.smsTextwhitelist,
      titleColor: Colors.white,
    ),
  ];
}
