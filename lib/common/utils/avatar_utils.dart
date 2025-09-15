import 'package:flutter/material.dart';

/// 头像工具类
/// 用于处理头像图片的显示逻辑，支持网络图片、本地资源和默认头像
class AvatarUtils {
  /// 获取头像的ImageProvider
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
      return AssetImage('assets/avatars/$labelText.png');
    } else {
      // 如果既没有头像也没有标签，则使用默认头像
      return const AssetImage('assets/avatars/Unknown.png');
    }
  }

  /// 获取头像的首字母（用于默认头像显示）
  ///
  /// [label] 标签文本
  static String getAvatarInitial(String? label) {
    if (label != null && label.isNotEmpty) {
      return label[0].toUpperCase();
    }
    return '?';
  }
}
