import 'package:flutter/material.dart';

/// 可复用的带标签服务卡片组件
/// 这个组件可以被各种需要标签功能的服务复用
/// 例如：来电识别、短信过滤、规则设置等
class LabeledServiceCard extends StatelessWidget {
  /// 卡片标题
  final String title;
  
  /// 卡片描述
  final String description;
  
  /// 标签列表
  final List<String> labels;
  
  /// 标签颜色
  final List<Color>? labelColors;
  
  /// 图标
  final IconData icon;
  
  /// 点击事件
  final VoidCallback onTap;
  
  /// 渐变色
  final List<Color> gradientColors;
  
  /// 是否启用
  final bool isEnabled;
  
  /// 右侧小部件
  final Widget? trailing;
  
  /// 构造函数
  const LabeledServiceCard({
    super.key,
    required this.title,
    required this.description,
    required this.labels,
    this.labelColors,
    required this.icon,
    required this.onTap,
    required this.gradientColors,
    this.isEnabled = true,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: isEnabled ? gradientColors : [Colors.grey.shade300, Colors.grey.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
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
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    if (trailing != null) trailing!,
                  ],
                ),
                const SizedBox(height: 8.0),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                const SizedBox(height: 12.0),
                _buildLabels(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 构建标签列表
  Widget _buildLabels() {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: List.generate(
        labels.length,
        (index) => _buildLabelChip(
          labels[index],
          labelColors != null && index < labelColors!.length
              ? labelColors![index]
              : Colors.white.withOpacity(0.8),
        ),
      ),
    );
  }

  /// 构建单个标签
  Widget _buildLabelChip(String label, Color color) {
    return Chip(
      label: Text(
        label,
        style: TextStyle(
          fontSize: 12.0,
          color: color.computeLuminance() > 0.5 ? Colors.black : Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: color.withOpacity(0.2),
      side: BorderSide(color: color.withOpacity(0.5), width: 1),
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}

/// 现代化设计的服务设置页面
class ModernServiceSettingsPage extends StatelessWidget {
  /// 页面标题
  final String title;
  
  /// 服务卡片列表
  final List<LabeledServiceCard> serviceCards;
  
  /// 页面背景渐变色
  final List<Color> backgroundGradient;
  
  /// 构造函数
  const ModernServiceSettingsPage({
    super.key,
    required this.title,
    required this.serviceCards,
    this.backgroundGradient = const [Colors.white, Color(0xFFF5F5F5)],
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
              const SizedBox(height: 8.0),
              ...serviceCards,
            ],
          ),
        ),
      ),
    );
  }
}

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
    Key? key,
    required this.title,
    required this.description,
    required this.price,
    required this.buttonText,
    required this.onTap,
    required this.gradientColors,
    required this.icon,
    this.isSmall = false,
    this.labels,
  }) : super(key: key);

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
    Key? key,
    required this.title,
    required this.tableRows,
    required this.gradientColors,
    required this.icon,
  }) : super(key: key);

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