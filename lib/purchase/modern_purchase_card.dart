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
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color(0xFFF5A623),
        elevation: 0,
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
              const SizedBox(height: 24.0),
              ...purchaseCards,
              const SizedBox(height: 24.0),
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
          padding: EdgeInsets.all(isSmall ? 12.0 : 16.0),
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
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
              if (labels != null && labels!.isNotEmpty) ...[
                const SizedBox(height: 8.0),
                _buildLabels(),
              ],
              const SizedBox(height: 12.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    price,
                    style: TextStyle(
                      fontSize: isSmall ? 16.0 : 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  ElevatedButton(
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
                  ),
                ],
              ),
            ],
          ),
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
    return Chip(
      label: Text(
        label,
        style: const TextStyle(
          fontSize: 10.0,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: Colors.white.withOpacity(0.2),
      side: BorderSide(color: Colors.white.withOpacity(0.5), width: 1),
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
