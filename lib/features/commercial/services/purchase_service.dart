import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_purchase_core/pyro_purchase_core.dart';

part 'purchase_service.g.dart';

@Riverpod(keepAlive: true)
PurchaseService purchaseService(Ref ref) {
  return PurchaseService.instance;
}

/// 主 App VIP 内购 Riverpod 服务 (PurchaseService)
class PurchaseService {
  static final PurchaseService instance = PurchaseService._();

  PurchaseService._();

  /// 恢复购买
  Future<bool> restorePurchases() async {
    debugPrint('[PurchaseService] 主 App 调起恢复购买流程...');
    return true;
  }
}
