import 'package:flutter/material.dart';
class CardStyle {
  static BorderRadius borderRadius = BorderRadius.circular(20);
  static const EdgeInsets margin = EdgeInsets.zero;
  static const EdgeInsets insidePadding = EdgeInsets.only(top: 2, left:2, right: 2, bottom: 2); // 修正了拼写错误
  static const EdgeInsets iconPadding = EdgeInsets.only(top: 25, left: 15); // 修正了拼写错误
  static const EdgeInsets menuPadding = EdgeInsets.only(top: 5, right: 5); // 修正了拼写错误
  static const EdgeInsets textPadding = EdgeInsets.only(top: 20, left: 60, bottom: 20); // 修正了拼写错误
  static const BoxShadow shadow = BoxShadow(
    color: Color(0x0A000000),
    spreadRadius: 0.0, // 阴影扩散半径
    offset: Offset(0, 2),
    blurRadius: 16,
  );
}
class IconStyle {
  static const Color iconColor = Color.fromRGBO(147, 203, 128, 1); // 图标颜色
  static const double iconSize = 35.0; // 图标尺寸
}
class MenuIconStyle {
  static const Color menuIconColor = Colors.white; // 图标颜色
  static const double menuIconSize = 30.0; // 图标尺寸

}
class TextSizeStyle {
  static const double fontSize = 18.0; // 文本尺寸
}
