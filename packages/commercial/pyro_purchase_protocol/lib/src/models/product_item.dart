import 'package:flutter/foundation.dart';

/// 订阅/购买产品 SKUID Token 集合 (强类型 0 字符串魔数)
abstract final class VipProductIdToken {
  static const String monthly = 'magma_vip_monthly';
  static const String lifetime = 'magma_vip_lifetime';
}

/// 商业产品展示数据模型
class ProductItem {
  final String id;
  final String title;
  final String description;
  final String price;
  final String? rawPrice;
  final bool isSubscription;
  final bool isBestValue;

  const ProductItem({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    this.rawPrice,
    this.isSubscription = false,
    this.isBestValue = false,
  });
}

/// 全局商业特权与状态数据模型 (不可变 Data Class)
@immutable
class CommercialState {
  final bool isPurchased;
  final bool isAdFree;
  final DateTime? tempExpiryDate;

  const CommercialState({
    this.isPurchased = false,
    this.isAdFree = false,
    this.tempExpiryDate,
  });

  /// 兼容旧命名 isVip
  bool get isVip => isPurchased;

  /// 是否当前享有有效商业特权（真实购买、免广告标记或临时特权未过期）
  bool get hasActivePrivilege {
    if (isPurchased || isAdFree) return true;
    if (tempExpiryDate != null && tempExpiryDate!.isAfter(DateTime.now())) {
      return true;
    }
    return false;
  }

  CommercialState copyWith({
    bool? isPurchased,
    bool? isAdFree,
    DateTime? tempExpiryDate,
  }) {
    return CommercialState(
      isPurchased: isPurchased ?? this.isPurchased,
      isAdFree: isAdFree ?? this.isAdFree,
      tempExpiryDate: tempExpiryDate ?? this.tempExpiryDate,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CommercialState &&
        other.isPurchased == isPurchased &&
        other.isAdFree == isAdFree &&
        other.tempExpiryDate == tempExpiryDate;
  }

  @override
  int get hashCode => Object.hash(isPurchased, isAdFree, tempExpiryDate);
}

/// 兼容旧版调用的类型别名
@Deprecated('使用 CommercialState 替代')
typedef EntitlementState = CommercialState;
