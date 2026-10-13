import 'package:flutter/material.dart';

/// 防御策略数据模型
class DefenseStrategyItem {
  final int index;
  final String title;
  final String subtitle;
  final String detailedDesc;
  final IconData icon;
  final Color activeColor;
  final bool isEnabled;
  final ValueChanged<bool> onToggle;

  const DefenseStrategyItem({
    required this.index,
    required this.title,
    required this.subtitle,
    required this.detailedDesc,
    required this.icon,
    required this.activeColor,
    required this.isEnabled,
    required this.onToggle,
  });
}
