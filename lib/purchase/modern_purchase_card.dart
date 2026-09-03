import 'package:flutter/material.dart';


/// 现代化设计的购买页面
class ModernPurchasePage extends StatelessWidget {
  /// 页面标题
  final String title;

  /// 功能卡片
  final Widget featureCard;

  /// 购买卡片列表
  final List<Widget> purchaseCards;

  /// 底部按钮
  final List<Widget> bottomButtons;

  /// 页面背景渐变色
  final List<Color> backgroundGradient;

  /// 构造函数
  const ModernPurchasePage({
    super.key,
    required this.title,
    required this.featureCard,
    required this.purchaseCards,
    required this.bottomButtons,
    this.backgroundGradient = const [Colors.white, Color(0xFFFFF3E0)],
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF5),
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w900,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        foregroundColor: Colors.black87,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: Colors.black87),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
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
  /// 卡片标题
  final String title;

  /// 卡片描述
  final String description;

  /// 价格
  final String price;

  /// 按钮文本
  final String buttonText;

  /// 点击事件
  final VoidCallback onTap;

  /// 渐变色
  final List<Color> gradientColors;

  /// 图标
  final IconData icon;

  /// 是否为小卡片
  final bool isSmall;

  /// 标签列表
  final List<String>? labels;

  /// 构造函数
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
                  color: Colors.white.withAlpha(230),
                ),
              ),
              if (labels != null && labels!.isNotEmpty) ...[
                const SizedBox(height: 8.0),
                _buildLabels(),
              ],
              const SizedBox(height: 12.0),
              LayoutBuilder(builder: (context, constraints) {
                // 计算价格和按钮的最小宽度
                final priceWidget = Text(price,
                    style: TextStyle(
                      fontSize: isSmall ? 16.0 : 20.0,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 255, 255, 255),
                    ));
                final buttonWidget = ElevatedButton(
                  onPressed: onTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: gradientColors[0],
                    padding: EdgeInsets.symmetric(
                      horizontal: isSmall ? 12.0 : 16.0,
                      vertical: isSmall ? 6.0 : 8.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(buttonText),
                );

                final pricePainter = TextPainter(
                  text: TextSpan(text: price, style: priceWidget.style),
                  textDirection: TextDirection.ltr,
                )..layout();

                final buttonSize = (buttonWidget.style?.padding
                        ?.resolve({WidgetState.selected}) as EdgeInsets? ??
                    EdgeInsets.zero)
                    .horizontal;

                final minWidth =
                    pricePainter.width + buttonSize + 100; // 100 是一个估算的按钮和其他间距的宽度

                if (constraints.maxWidth < minWidth) {
                  // 空间不足，垂直排列
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      priceWidget,
                      const SizedBox(height: 8.0),
                      Align(
                        alignment: Alignment.centerRight,
                        child: buttonWidget,
                      ),
                    ],
                  );
                } else {
                  // 空间充足，水平排列
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Flexible(child: priceWidget), buttonWidget],
                  );
                }
              }),
            ],
          ),
        ),
 
    );
  }

  /// 构建标签列表
  Widget _buildLabels() {
    return Wrap(
      spacing: 6.0,
      runSpacing: 6.0,
      children: List.generate(
        labels!.length,
        (index) => _buildLabelChip(labels![index]),
      ),
    );
  }

  /// 构建单个标签
  Widget _buildLabelChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha:0.2),
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: Colors.white.withValues(alpha:0.5),
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
    );
  }
}

/// 现代化设计的功能表格卡片
class ModernFeatureTableCard extends StatelessWidget {
  /// 卡片标题
  final String title;

  /// 表格行
  final List<TableRow> tableRows;

  /// 渐变色
  final List<Color> gradientColors;

  /// 图标
  final IconData icon;

  /// 构造函数
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
                      fontSize: 22.0,
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
