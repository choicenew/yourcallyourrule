import 'package:material_ui/material_ui.dart';
import 'package:pyro_purchase_protocol/pyro_purchase_protocol.dart';
import 'widgets/commercial_card_widget.dart';

/// 配置驱动的响应式商业特权对比弹窗 (零 Hub / 零 Riverpod 依赖，纯 Dumb Presentational Widget)
class CommercialPrivilegeSheet extends StatefulWidget {
  final CommercialUIConfig uiConfig;
  final List<ProductItem> products;
  final EntitlementState entitlementState;

  final ValueChanged<String>? onBuyProduct;
  final VoidCallback? onWatchAd;
  final VoidCallback? onRestorePurchases;

  const CommercialPrivilegeSheet({
    super.key,
    required this.uiConfig,
    this.products = const [],
    this.entitlementState = const EntitlementState(),
    this.onBuyProduct,
    this.onWatchAd,
    this.onRestorePurchases,
  });

  /// 静态快捷唤起弹窗
  static Future<void> show(
    BuildContext context, {
    required CommercialUIConfig uiConfig,
    List<ProductItem> products = const [],
    EntitlementState entitlementState = const EntitlementState(),
    ValueChanged<String>? onBuyProduct,
    VoidCallback? onWatchAd,
    VoidCallback? onRestorePurchases,
  }) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CommercialPrivilegeSheet(
        uiConfig: uiConfig,
        products: products,
        entitlementState: entitlementState,
        onBuyProduct: onBuyProduct,
        onWatchAd: onWatchAd,
        onRestorePurchases: onRestorePurchases,
      ),
    );
  }

  @override
  State<CommercialPrivilegeSheet> createState() => _CommercialPrivilegeSheetState();
}

class _CommercialPrivilegeSheetState extends State<CommercialPrivilegeSheet> {
  String? _selectedProductId;

  @override
  void initState() {
    super.initState();
    if (widget.uiConfig.itemConfigs.isNotEmpty) {
      _selectedProductId = widget.uiConfig.itemConfigs.firstWhere(
        (c) => c.isDefaultSelected,
        orElse: () => widget.uiConfig.itemConfigs.first,
      ).productId;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2)),
            ),
            const SizedBox(height: 16),
            Text(
              widget.uiConfig.sheetTitle,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            if (widget.uiConfig.sheetSubtitle != null) ...[
              const SizedBox(height: 6),
              Text(
                widget.uiConfig.sheetSubtitle!,
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(height: 16),
            ...widget.uiConfig.itemConfigs.map((itemConfig) {
              final product = widget.products.firstWhere(
                (p) => p.id == itemConfig.productId,
                orElse: () => ProductItem(
                  id: itemConfig.productId,
                  title: itemConfig.title,
                  description: itemConfig.subtitle ?? '',
                  price: '¥--',
                ),
              );
              return CommercialCardWidget(
                itemConfig: itemConfig,
                product: product,
                isSelected: _selectedProductId == itemConfig.productId,
                onTap: () {
                  setState(() => _selectedProductId = itemConfig.productId);
                },
              );
            }),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber.shade700,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                ),
                onPressed: _selectedProductId == null
                    ? null
                    : () {
                        widget.onBuyProduct?.call(_selectedProductId!);
                      },
                child: Text(widget.uiConfig.buyButtonText, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
            if (widget.onWatchAd != null) ...[
              const SizedBox(height: 10),
              OutlinedButton.icon(
                icon: const Icon(Icons.movie),
                label: Text(widget.uiConfig.watchAdButtonText),
                onPressed: widget.onWatchAd,
              ),
            ],
            if (widget.onRestorePurchases != null) ...[
              TextButton(
                onPressed: widget.onRestorePurchases,
                child: Text(widget.uiConfig.restoreButtonText, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
