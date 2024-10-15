import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:yourcallyourrule/screens/custom_swiper/extension_text.dart';

class CardItem extends StatelessWidget {
  final String? title;
  final dynamic content; // Can be String or Widget
  final String? imageUrl;
  final String? url;
  final TextStyle? titleTextStyle; // 标题样式
  final TextStyle? contentTextStyle; // 内容样式
  final Function(BuildContext)? onTap; // 新增 onTap 回调函数
  final Color? backgroundColor; // 添加背景色属性
  final double? borderRadius; // 添加圆角半径属性

  const CardItem({
    super.key,
    this.title,
    this.content,
    this.imageUrl,
    this.url,
    this.titleTextStyle, // 使用标题样式
    this.contentTextStyle, // 使用内容样式
    this.onTap, // 在构造函数中添加 onTap 参数
    this.backgroundColor =
        Colors.white, // 设置 backgroundColor 的默认值为 Colors.white
    this.borderRadius = 20.0, // 设置 borderRadius 的默认值为 0.0
  });

  factory CardItem.fromJson(Map<String, dynamic> json) {
    return CardItem(
      title: json['title'],
      content: json['content'],
      imageUrl: json['imageUrl'],
      url: json['url'],
      // 这里可以添加其他样式属性的解析，例如：
      titleTextStyle:
          const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      contentTextStyle: const TextStyle(fontSize: 14),
      onTap: json['onTap'],
      backgroundColor: json['backgroundColor'] != null
          ? Color(int.parse(json['backgroundColor'], radix: 16)) // 解析颜色字符串
          : Colors.white, // 默认白色背景
      borderRadius: json['borderRadius'] != null
          ? double.parse(json['borderRadius']) // 使用 double.parse() 方法转换
          : 20.0, // 默认20有圆角
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      // 将背景色和圆角应用到 Card 组件上
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius!),
      ),
      child: InkWell(
        onTap: () {
          _handleCardTap(context);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (imageUrl != null)

              /*
              Image.network(
                imageUrl!,
                fit: BoxFit.cover,
              ),
*/
              imageUrl!.startsWith('http')
                  ? Image.network(
                      imageUrl!,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      imageUrl!,
                      fit: BoxFit.cover,
                    ),
            if (title != null || content != null)
              ListTile(
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0),
                title: title != null
                    ? Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          //title!,
                          title!
                              .translate(context), // 使用 translate 扩展方法翻译 title
                          style: titleTextStyle,
                        ),
                      )
                    : null,
                subtitle: content != null
                    ? Align(
                        alignment: Alignment.center,
                        child: content is Widget // 检查内容是否为 Widget 类型
                            ? content as Widget // 如果是 Widget 类型则直接返回
                            : Text(
                                // content.toString(),
                                content.toString().translate(
                                    context), // 使用 translate 扩展方法翻译 content
                                style: contentTextStyle, // 使用内容样式
                              ))
                    : null,
              ),
          ],
        ),
      ),
    );
  }

  void _handleCardTap(BuildContext context) {
    if (onTap != null) {
      onTap!(context);
    } else if (url != null) {
      launchUrlString(url!);
    } else {
      // print('No onTap or URL defined for this card');
    }
  }
}
