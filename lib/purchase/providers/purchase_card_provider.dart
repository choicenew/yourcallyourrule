import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/purchase/purchase_provider.dart';
import 'package:yourcallyourrule/purchase/widgets/purchase_cards.dart';

/// 购买卡片工厂提供者
/// 提供PurchaseCardFactory的实例，用于创建各种购买相关的卡片组件
final purchaseCardFactoryProvider = Provider<PurchaseCardFactory>((ref) {
  final purchaseProvider = ref.watch(purchaseProviderProvider.notifier);
  return PurchaseCardFactory(purchaseProvider);
});