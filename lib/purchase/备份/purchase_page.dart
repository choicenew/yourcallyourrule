import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourcallyourrule/purchase/modern_purchase_card.dart';
import 'package:yourcallyourrule/purchase/purchase_provider.dart';
import 'package:yourcallyourrule/purchase/purchase_state.dart';

/// 现代化设计的购买页面
class PurchasePage extends StatefulWidget {
  const PurchasePage({super.key});

  @override
  PurchasePageState createState() => PurchasePageState();
}

class PurchasePageState extends State<PurchasePage> {
  late PurchaseProvider purchaseProvider;

  @override
  void initState() {
    super.initState();
    final purchaseState = Provider.of<PurchaseState>(context, listen: false);
    purchaseProvider = PurchaseProvider(context, purchaseState);
    purchaseState.loadState(); // 加载保存的状态
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PurchaseState>(
      builder: (context, purchaseState, child) {
        // 获取会员特权标签
        final vipLabels = purchaseProvider.getMembershipLabels();
        final tempVipLabels = purchaseProvider.getTempMembershipLabels();
        
        // 构建功能表格行
        final tableRows = [
          _buildTableRow(
            '功能',
            '普通用户',
            'VIP用户',
            '临时VIP',
            isHeader: true,
          ),
          _buildTableRow('移除广告', '❌', '✅', '❌'),
          _buildTableRow('云备份', '❌', '✅', '✅'),
          _buildTableRow('来电识别增强', '❌', '✅', '✅'),
          _buildTableRow('语音识别', '❌', '✅', '✅'),
        ];
        
        // 构建功能卡片
        final featureCard = ModernFeatureTableCard(
          title: '会员特权',
          tableRows: tableRows,
          gradientColors: const [Color(0xFF5C6BC0), Color(0xFF3949AB)],
          icon: Icons.star,
        );
        
        // 构建购买卡片
        final purchaseCards = [
          // 移除广告卡片
          ModernPurchaseCard(
            title: '移除广告',
            description: '永久移除应用内所有广告，享受更流畅的使用体验',
            price: 'USD3.99',
            buttonText: '购买',
            onTap: () {
              purchaseProvider.purchaseNonConsumable('remove_ads_product_id');
            },
            gradientColors: const [Color(0xFFFFB74D), Color(0xFFFF9800)],
            icon: Icons.block,
            labels: ['无广告'],
          ),
          const SizedBox(height: 16.0),
          
          // 订阅卡片（月度和季度）
          Row(
            children: [
              Expanded(
                child: ModernPurchaseCard(
                  title: '月度会员',
                  description: '解锁所有高级功能，每月自动续费',
                  price: 'USD2.99/月',
                  buttonText: '订阅',
                  onTap: () {
                    purchaseProvider.purchaseNonConsumable('monthly_id_subscription');
                  },
                  gradientColors: const [Color(0xFF64B5F6), Color(0xFF2196F3)],
                  icon: Icons.calendar_month,
                  isSmall: true,
                  labels: vipLabels,
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: ModernPurchaseCard(
                  title: '季度会员',
                  description: '解锁所有高级功能，每季度自动续费',
                  price: 'USD6.99/季',
                  buttonText: '订阅',
                  onTap: () {
                    purchaseProvider.purchaseNonConsumable('quarterly_id_subscription');
                  },
                  gradientColors: const [Color(0xFF7986CB), Color(0xFF3F51B5)],
                  icon: Icons.calendar_today,
                  isSmall: true,
                  labels: vipLabels,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          
          // 终身会员卡片
          ModernPurchaseCard(
            title: '终身会员',
            description: '一次性购买，永久解锁所有高级功能和未来更新',
            price: 'USD9.99',
            buttonText: '购买',
            onTap: () {
              purchaseProvider.purchaseNonConsumable('lifetime_purchase_id');
            },
            gradientColors: const [Color(0xFF81C784), Color(0xFF4CAF50)],
            icon: Icons.star,
            labels: vipLabels,
          ),
          const SizedBox(height: 20),
          
          // 激励广告卡片
          ModernPurchaseCard(
            title: '观看广告获取临时特权',
            description: '观看短广告临时解锁部分高级功能',
            price: purchaseState.hasTempPurchase
                ? '到期时间: ${purchaseState.tempPurchaseExpiryDate!.toLocal().toString().substring(0, 19)}'
                : '免费',
            buttonText: '观看广告',
            onTap: () {
              purchaseProvider.showRewardedAd(context);
            },
            gradientColors: const [Color(0xFFAED581), Color(0xFF8BC34A)],
            icon: Icons.movie,
            labels: tempVipLabels,
          ),
        ];
        
        // 构建底部按钮
        final bottomButtons = [
          Center(
            child: ElevatedButton.icon(
              onPressed: () {
                purchaseProvider.restorePurchases();
              },
              icon: const Icon(Icons.restore),
              label: const Text('恢复购买'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF5A623),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 5,
              ),
            ),
          ),
        ];
        
        return Scaffold(
          appBar: AppBar(
            title: const Text('会员中心'),
            backgroundColor: const Color(0xFFF5A623),
            elevation: 0,
            bottom: purchaseState.isPurchasesEnabled
                ? PreferredSize(
                    preferredSize: const Size.fromHeight(48.0),
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(8.0),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFFF5A623), Color(0xFFFF8C00)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: const Text(
                        '您的会员订阅有效',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                : null,
          ),
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Color(0xFFFFF3E0)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // 功能介绍卡片
                  featureCard,
                  const SizedBox(height: 24.0),
                  
                  // 购买卡片
                  ...purchaseCards,
                  const SizedBox(height: 24.0),
                  
                  // 底部按钮
                  ...bottomButtons,
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // 表格行
  TableRow _buildTableRow(String feature, String normal, String vip, String tempVip,
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
}