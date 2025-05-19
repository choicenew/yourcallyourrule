import 'package:flutter/material.dart';

/// 会员特权管理服务
/// 负责管理所有与会员特权相关的功能和标签
class MembershipFeatureService {
  // 获取会员特权标签
  List<String> getMembershipLabels() {
    return ['无广告', '云备份', '来电识别增强', '语音识别'];
  }

  // 获取临时会员特权标签
  List<String> getTempMembershipLabels() {
    return ['云备份', '来电识别增强', '语音识别'];
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
    return [
      buildTableRow(
        '功能',
        '普通用户',
        'VIP用户',
        '临时VIP',
        isHeader: true,
      ),
      buildTableRow('移除广告', '❌', '✅', '❌'),
      buildTableRow('云备份', '❌', '✅', '✅'),
      buildTableRow('来电识别增强', '❌', '✅', '✅'),
      buildTableRow('语音识别', '❌', '✅', '✅'),
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