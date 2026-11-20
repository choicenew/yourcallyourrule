import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'commercial_notifier.dart';

part 'purchase_engine.g.dart';

/// 纯底层内购与支付引擎 Provider
@Riverpod(keepAlive: true)
class PurchaseEngine extends _$PurchaseEngine {
  @override
  void build() {
    _initialize();
  }

  CommercialNotifier get commercialNotifier => ref.read(commercialNotifierProvider.notifier);

  Future<void> _initialize() async {
    final bool available = await InAppPurchase.instance.isAvailable();
    if (!available) return;

    InAppPurchase.instance.purchaseStream.listen(_listenToPurchaseUpdated);
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    for (var purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.purchased ||
          purchaseDetails.status == PurchaseStatus.restored) {
        commercialNotifier.updatePurchasedStatus(true);
        InAppPurchase.instance.completePurchase(purchaseDetails);
      }

      if (purchaseDetails.pendingCompletePurchase) {
        InAppPurchase.instance.completePurchase(purchaseDetails);
      }
    }
  }

  Future<void> purchaseConsumable(String productId) async {
    final response = await InAppPurchase.instance.queryProductDetails({productId});
    if (response.notFoundIDs.isNotEmpty) {
      throw Exception('Product not found: ${response.notFoundIDs}');
    }
    final productDetails = response.productDetails.first;
    final purchaseParam = PurchaseParam(productDetails: productDetails);
    await InAppPurchase.instance.buyConsumable(purchaseParam: purchaseParam, autoConsume: false);
  }

  Future<void> purchaseNonConsumable(String productId) async {
    final response = await InAppPurchase.instance.queryProductDetails({productId});
    if (response.notFoundIDs.isNotEmpty) {
      throw Exception('Product not found: ${response.notFoundIDs}');
    }
    final productDetails = response.productDetails.first;
    final purchaseParam = PurchaseParam(productDetails: productDetails);
    await InAppPurchase.instance.buyNonConsumable(purchaseParam: purchaseParam);
  }

  Future<void> restorePurchases() async {
    await InAppPurchase.instance.restorePurchases();
  }
}
