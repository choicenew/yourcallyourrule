// 文件路径: lib/purchase/providers/purchase_card_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
// 导入包含新 provider 的文件
import 'package:yourcallyourrule/purchase/purchase_provider.dart'; 
import 'package:yourcallyourrule/purchase/widgets/purchase_cards.dart';

final purchaseCardFactoryProvider = Provider<PurchaseCardFactory>((ref) {
  // 之前: final purchaseProvider = ref.watch(purchaseProviderProvider.notifier);
  // 现在: 使用新的、自动生成的 provider
  final purchaseNotifier = ref.watch(purchaseProvider.notifier);
  
  // 将 `purchaseNotifier` (现在是 Purchase 类型) 传给工厂
  return PurchaseCardFactory(purchaseNotifier); 
});