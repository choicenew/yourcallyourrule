import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:pyro_purchase_protocol/pyro_purchase_protocol.dart';
import 'package:pyro_purchase_ui/pyro_purchase_ui.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 商业 VIP 订阅页面 —— 全量通过 Google Play Service / StoreKit 动态查询真实货币价格
class PurchasePage extends ConsumerStatefulWidget {
  const PurchasePage({super.key});

  @override
  ConsumerState<PurchasePage> createState() => _PurchasePageState();
}

class _PurchasePageState extends ConsumerState<PurchasePage> {
  bool _isLoading = true;
  List<ProductDetails> _productDetails = [];

  static const Set<String> _kProductIds = {
    'vip_monthly_subscription',
    'vip_annual_subscription',
  };

  @override
  void initState() {
    super.initState();
    _fetchRealProductDetails();
  }

  /// 向 Google Play Service / StoreKit 动态异步查询真实的地区货币价格
  Future<void> _fetchRealProductDetails() async {
    try {
      final available = await InAppPurchase.instance.isAvailable();
      if (!available) {
        if (mounted) setState(() => _isLoading = false);
        return;
      }

      final response = await InAppPurchase.instance.queryProductDetails(_kProductIds);
      if (mounted) {
        setState(() {
          _productDetails = response.productDetails;
          _isLoading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    // 将 Google Play 真实价格转换映射为微包的 ProductItem
    final products = _productDetails.map((pd) {
      return ProductItem(
        id: pd.id,
        title: pd.title,
        description: pd.description,
        price: pd.price, // 包含真实的国家地区货币符号 (如 $4.99 或 ¥30)
      );
    }).toList();

    const uiConfig = CommercialUIConfig(
      sheetTitle: 'VIP Premium Access',
      sheetSubtitle: 'Unlock all intelligent spam filtering & cloud sync features',
      itemConfigs: [
        CommercialItemConfig(
          productId: 'vip_monthly_subscription',
          title: 'Monthly VIP',
          subtitle: 'Auto-renews monthly',
          isDefaultSelected: true,
        ),
        CommercialItemConfig(
          productId: 'vip_annual_subscription',
          title: 'Annual VIP (Best Value)',
          subtitle: 'Auto-renews yearly',
        ),
      ],
    );

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          l10n.aboutTitle,
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20, color: theme.colorScheme.onSurface),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : CommercialPrivilegeSheet(
              uiConfig: uiConfig,
              products: products,
              onBuyProduct: (productId) async {
                final product = _productDetails.firstWhere((p) => p.id == productId, orElse: () => _productDetails.first);
                final param = PurchaseParam(productDetails: product);
                await InAppPurchase.instance.buyNonConsumable(purchaseParam: param);
              },
              onRestorePurchases: () async {
                await InAppPurchase.instance.restorePurchases();
              },
            ),
    );
  }
}
