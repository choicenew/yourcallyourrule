import 'package:flutter/material.dart';

/// 头像工具类
/// 提供头像相关的工具方法
class AvatarUtils {
  /// 获取头像图片
  /// 如果有网络图片，则使用网络图片
  /// 如果有本地资源图片，则使用本地资源图片
  /// 否则使用默认头像
  static ImageProvider getAvatarImage(String? avatar, String name) {
    if (avatar != null && avatar.isNotEmpty) {
      if (avatar.startsWith('http')) {
        return NetworkImage(avatar);
      } else {
        return AssetImage(avatar);
      }
    } else {
      return AssetImage('assets/images/default_avatar.png');
    }
  }

  /// 获取头像初始字母
  /// 如果名称为空，则返回 '?'
  /// 否则返回名称的第一个字符
  static String getInitials(String name) {
    if (name.isEmpty) {
      return '?';
    }
    return name[0].toUpperCase();
  }

  /// 根据名称获取颜色
  /// 使用名称的哈希值生成一个颜色
  static Color getColorFromName(String name) {
    if (name.isEmpty) {
      return const Color(0xFFF5A623); // 默认颜色
    }
    
    // 使用名称的哈希值生成一个颜色
    final int hash = name.hashCode;
    final List<Color> colors = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.pink,
      Colors.indigo,
      Colors.amber,
      Colors.cyan,
    ];
    
    return colors[hash.abs() % colors.length];
  }
}