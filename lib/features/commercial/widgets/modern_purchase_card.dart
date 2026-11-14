import 'package:material_ui/material_ui.dart';

/// 现代化设计的购买页面框架
class ModernPurchasePage extends StatelessWidget {
  final String title;
  final Widget featureCard;
  final List<Widget> purchaseCards;
  final List<Widget> bottomButtons;
  final List<Color> backgroundGradient;

  const ModernPurchasePage({
    super.key,
    required this.title,
    required this.featureCard,
    required this.purchaseCards,
    required this.bottomButtons,
    this.backgroundGradient = const [Color(0xFFFFFBF5), Color(0xFFFFF3E0)],
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.w900,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        foregroundColor: theme.colorScheme.onSurface,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: theme.colorScheme.onSurface),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: isDark ? theme.scaffoldBackgroundColor : null,
          gradient: isDark
              ? null
              : LinearGradient(
                  colors: backgroundGradient,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              featureCard,
              const SizedBox(height: 20.0),
              ...purchaseCards,
              const SizedBox(height: 20.0),
              ...bottomButtons,
            ],
          ),
        ),
      ),
    );
  }
}

/// 现代化设计的购买卡片
class ModernPurchaseCard extends StatelessWidget {
  final String title;
  final String description;
  final String price;
  final String buttonText;
  final VoidCallback onTap;
  final List<Color> gradientColors;
  final IconData icon;
  final bool isSmall;
  final List<String>? labels;

  const ModernPurchaseCard({
    super.key,
    required this.title,
    required this.description,
    required this.price,
    required this.buttonText,
    required this.onTap,
    required this.gradientColors,
    required this.icon,
    this.isSmall = false,
    this.labels,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: gradientColors.first.withValues(alpha: 0.28),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(isSmall ? 14.0 : 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.white, size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: isSmall ? 16.0 : 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              description,
              style: TextStyle(
                fontSize: isSmall ? 12.0 : 14.0,
                color: Colors.white.withValues(alpha: 0.9),
              ),
            ),
            if (labels != null && labels!.isNotEmpty) ...[
              const SizedBox(height: 8.0),
              Wrap(
                spacing: 6.0,
                runSpacing: 6.0,
                children: labels!
                    .map(
                      (label) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.5),
                            width: 1.0,
                          ),
                        ),
                        child: Text(
                          label,
                          style: const TextStyle(
                            fontSize: 10.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    price,
                    style: TextStyle(
                      fontSize: isSmall ? 16.0 : 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: onTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: gradientColors.first,
                    padding: EdgeInsets.symmetric(
                      horizontal: isSmall ? 14.0 : 18.0,
                      vertical: isSmall ? 6.0 : 10.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    buttonText,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// 现代化特权对比表格卡片
class ModernFeatureTableCard extends StatelessWidget {
  final String title;
  final List<TableRow> tableRows;
  final List<Color> gradientColors;
  final IconData icon;

  const ModernFeatureTableCard({
    super.key,
    required this.title,
    required this.tableRows,
    required this.gradientColors,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, color: Colors.amber, size: 28),
                  const SizedBox(width: 12),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Table(
                border: TableBorder.all(
                  color: Colors.white30,
                  width: 1,
                  borderRadius: BorderRadius.circular(8),
                ),
                children: tableRows,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
