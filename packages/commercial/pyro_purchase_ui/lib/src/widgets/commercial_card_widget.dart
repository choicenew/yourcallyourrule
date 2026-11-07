import 'package:material_ui/material_ui.dart';
import 'package:pyro_purchase_protocol/pyro_purchase_protocol.dart';

/// 声明式配置驱动的现代商业商品卡片 (零 Hub 依赖，纯 Dumb Component)
class CommercialCardWidget extends StatelessWidget {
  final CommercialItemUIConfig itemConfig;
  final ProductItem? product;
  final bool isSelected;
  final VoidCallback? onTap;

  const CommercialCardWidget({
    super.key,
    required this.itemConfig,
    this.product,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: isSelected
                ? itemConfig.gradientColors
                : [Colors.grey.shade100, Colors.grey.shade200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(
            color: isSelected ? itemConfig.primaryColor : Colors.grey.shade300,
            width: isSelected ? 2.5 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: itemConfig.primaryColor.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(itemConfig.icon, size: 28, color: isSelected ? Colors.white : itemConfig.primaryColor),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        itemConfig.title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.white : Colors.black87,
                        ),
                      ),
                      if (itemConfig.subtitle != null)
                        Text(
                          itemConfig.subtitle!,
                          style: TextStyle(
                            fontSize: 13,
                            color: isSelected ? Colors.white70 : Colors.grey.shade600,
                          ),
                        ),
                    ],
                  ),
                ),
                if (itemConfig.badge != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      itemConfig.badge!,
                      style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                  ),
              ],
            ),
            if (product != null) ...[
              const SizedBox(height: 12),
              Text(
                product!.price,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: isSelected ? Colors.white : itemConfig.primaryColor,
                ),
              ),
            ],
            if (itemConfig.featurePoints.isNotEmpty) ...[
              const Divider(height: 20),
              ...itemConfig.featurePoints.map((f) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      children: [
                        Icon(f.icon, size: 16, color: isSelected ? Colors.white : Colors.green),
                        const SizedBox(width: 8),
                        Text(
                          f.title,
                          style: TextStyle(
                            fontSize: 13,
                            color: isSelected ? Colors.white : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ],
        ),
      ),
    );
  }
}
