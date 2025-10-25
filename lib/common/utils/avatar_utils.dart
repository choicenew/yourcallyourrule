import 'package:flutter/material.dart';

/// 头像工具类
/// 用于处理头像图片的显示逻辑，支持网络图片、本地资源和默认头像
class AvatarUtils {
  /// 获取头像的ImageProvider
  ///
  /// 此方法遵循以下优先级逻辑来确定要显示的头像：
  /// 1. 如果 [avatar] 字符串存在且以 'http' 开头，则将其视为网络图片。
  /// 2. 如果 [avatar] 字符串存在但不是网络链接，则将其视为本地资源路径。
  /// 3. 如果 [avatar] 为空，但 [labelText] 存在，则会尝试加载一个基于该文本的本地资源
  ///    (例如，'assets/avatars/John.png')。
  /// 4. 如果以上条件均不满足，则返回一个最终的默认头像 ('assets/avatars/Unknown.png')。
  ///
  /// [avatar] 头像路径或URL
  /// [labelText] 当头像不存在时，用于生成默认头像的标签文本
  static ImageProvider? getAvatarImage(String? avatar, String? labelText) {
    if (avatar != null && avatar.isNotEmpty) {
      // 如果avatar是URL链接，则使用NetworkImage
      if (avatar.startsWith('http')) {
        return NetworkImage(avatar);
      } else {
        // 如果avatar是本地资源路径，则使用AssetImage
        return AssetImage(avatar);
      }
    } else if (labelText != null && labelText.isNotEmpty) {
      // 如果没有头像但有标签，则使用标签构建本地资源路径
         debugPrint('assets/avatars/$labelText.png');
      return AssetImage('assets/avatars/$labelText.png');
   
    } else {
      // 如果既没有头像也没有标签，则使用默认头像
      return const AssetImage('assets/avatars/Unknown.png');
    }
  }

  /// 获取头像的首字母（用于默认头像显示）
  /// 获取头像的首字母（用于在没有图片时显示）
  ///
  /// 如果 [label] 为 null 或为空字符串, 则返回 '?'。
  /// 否则，返回 [label] 的第一个字符，并将其转换为大写。
  ///
  /// [label] 用于提取首字母的源文本。
  /// [label] 标签文本
  static String getAvatarInitial(String? label) {
    if (label != null && label.isNotEmpty) {
      return label[0].toUpperCase();
    }
    return '?';
  }

  /// 根据名称获取一个稳定的颜色 (从第一个版本完整合并而来)
  ///
  /// 此方法使用输入名称的哈希值从一个预定义的颜色列表中进行选择。
  /// 这可以确保对于同一个名称，总是返回相同的颜色，非常适合用作头像的背景色，
  /// 从而在视觉上区分不同的用户。
  ///
  /// [name] 用于生成颜色的源字符串（通常是用户名）。

// 方案二：基于HSL颜色模型动态生成
static Color getColorFromName(String name) {
  if (name.isEmpty) {
    return const Color(0xFFF5A623); 
  }

  final int hash = name.hashCode;
  // 将哈希值映射到 0-360 度的色相值
  final double hue = (hash.abs() % 360).toDouble();
  // 固定饱和度和亮度，确保颜色鲜艳且可读
  const double saturation = 0.8;
  const double lightness = 0.5;

  // 从HSL创建颜色，并转换回RGB
  return HSLColor.fromAHSL(1.0, hue, saturation, lightness).toColor();
}






}
