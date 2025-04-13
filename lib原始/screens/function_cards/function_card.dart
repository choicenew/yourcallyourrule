import 'package:flutter/material.dart';

import 'function_card_ui.dart';

class FunctionCard extends StatelessWidget {
  const FunctionCard({
    super.key,
    required this.page,
    required this.startColor,
    required this.endColor,
    required this.iconBackgroundColor,
    required this.icon,
    required this.title,
    required this.titleColor,
  });

  final Widget page;
  final Color startColor;
  final Color endColor;
  final Color iconBackgroundColor;
  final IconData icon;
  final String title;
  final Color titleColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: CardStyle.margin,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: CardStyle.borderRadius,
      ),
      child: AspectRatio(
        aspectRatio: 3.1 / 2, // 设置卡片的宽高比为 3.1:2
        child: Container(
          decoration: BoxDecoration(
            // 使用 LinearGradient 创建线性渐变色
            gradient: LinearGradient(
              colors: [
                startColor, // 起始颜色
                endColor, // 结束颜色
              ],
              begin: Alignment.topLeft, // 渐变开始位置
              end: Alignment.bottomRight, // 渐变结束位置
            ),
            borderRadius: BorderRadius.circular(16.0), // 卡片背景形状
            boxShadow: const [
              CardStyle.shadow,
            ],
          ),
          child: Padding(
            padding: CardStyle.insidePadding,
            child: Stack(
              children: [
                // 左上角的图标
                Positioned(
                  top: CardStyle.iconPadding.top,
                  left: CardStyle.iconPadding.left,
                  child: Container(
                    width: 40.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                      color: iconBackgroundColor,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Icon(
                      icon,
                      color: IconStyle.iconColor,
                      size: IconStyle.iconSize,
                    ),
                  ),
                ),
                // 右上角的菜单按钮
                Positioned(
                  top: CardStyle.menuPadding.top,
                  right: CardStyle.menuPadding.right,
                  child: Container(
                    child: const Icon(
                      Icons.more_vert,
                      color: MenuIconStyle.menuIconColor,
                      size: MenuIconStyle.menuIconSize,
                    ),
                  ),
                ),
                // 卡片底部文字, 使用Align可以让文字在底部
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: CardStyle.textPadding,
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: TextSizeStyle.fontSize,
                        color: titleColor,
                      ),
                       maxLines: null, // 允许文本自动换行
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
