import 'package:flutter/material.dart';
import 'package:yourcallyourrule/core/router/app_router.dart';


import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 会员特权管理服务
/// 负责管理所有与会员特权相关的功能和标签
class MembershipFeatureService {
  // 获取会员特权标签
  List<String> getMembershipLabels() {
    final context = AppRouter.navigatorKey.currentContext!;
    return [
      AppLocalizations.of(context)!.noAds,
      AppLocalizations.of(context)!.cloudBackup,
      AppLocalizations.of(context)!.callerIdEnhancement,
      //AppLocalizations.of(context)!.voiceRecognition
    ];
  }

  // 获取临时会员特权标签
  List<String> getTempMembershipLabels() {
    final context = AppRouter.navigatorKey.currentContext!;
    return [
      AppLocalizations.of(context)!.cloudBackup,
      AppLocalizations.of(context)!.callerIdEnhancement,
      //AppLocalizations.of(context)!.voiceRecognition
    ];
  }
  
  // 构建功能表格行
  TableRow buildTableRow(String feature, String normal, String vip, String tempVip,
      {bool isHeader = false}) {
    final TextStyle style = TextStyle(
      fontSize: isHeader ? 16.0 : 14.0,
      fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
      color: Colors.white,
    );

    return TableRow(
      decoration: BoxDecoration(
        color: isHeader ? Colors.black26 : Colors.transparent,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(feature, style: style),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(child: Text(normal, style: style)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(child: Text(vip, style: style)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(child: Text(tempVip, style: style)),
        ),
      ],
    );
  }

  // 获取功能表格行列表
  List<TableRow> getFeatureTableRows() {
    final context = AppRouter.navigatorKey.currentContext!;
    return [
      buildTableRow(
        AppLocalizations.of(context)!.feature,
        AppLocalizations.of(context)!.normalUser,
        AppLocalizations.of(context)!.vipUser,
        AppLocalizations.of(context)!.temporaryVip,
        isHeader: true,
      ),
      buildTableRow(AppLocalizations.of(context)!.removeAds, '❌', '✅', '❌'),
      buildTableRow(AppLocalizations.of(context)!.cloudBackup, '❌', '✅', '✅'),
      buildTableRow(AppLocalizations.of(context)!.callerIdEnhancement, '❌', '✅', '✅'),
      //buildTableRow(AppLocalizations.of(context)!.voiceRecognition, '❌', '✅', '✅'),
    ];
  }

  // 获取产品ID列表
  Map<String, String> getProductIds() {
    return {
      'removeAds': 'remove_ads_product_id',
      'monthly': 'monthly_id_subscription',
      'quarterly': 'quarterly_id_subscription',
      'lifetime': 'lifetime_purchase_id',
    };
  }

  // 检查产品ID是否为订阅或永久购买
  bool isSubscriptionOrLifetime(String productId) {
    final ids = getProductIds();
    return productId == ids['monthly'] || 
           productId == ids['quarterly'] || 
           productId == ids['lifetime'];
  }

  // 检查产品ID是否为移除广告
  bool isRemoveAds(String productId) {
    return productId == getProductIds()['removeAds'];
  }
}