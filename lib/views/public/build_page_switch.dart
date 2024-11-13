import 'package:flutter/material.dart';
import 'dart:core';

import '../../new_set_icons.dart';
import '../../utils/ad_manager.dart';
import '../../utils/create_card.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/google_ad.dart';
import '../../widgets/navigation_bar.dart';
import '../custom_3button_style.dart';





// 其他页面类似，只需要传入相应的参数即可
// 创建一个公共函数来构建页面
Widget buildPageWithCollapsibleContent(
  BuildContext context,
  String pageTitle, // 页面标题
  //String cardTitle, // 卡片标题暂时没有用处了
  Widget navigationPage, // 点击卡片导航到的页面 用这里进行function card 匹配
  Widget contentPage, // 当前页面主要内容
  {
    Widget? exportPage, // 导出页面
    String exportLabel = 'Export', // 导出按钮文字
    IconData exportIcon = NewSet.upload, // 导出按钮图标
    Widget? addPage, // 添加页面
    String addLabel = 'Add', // 添加按钮文字
    IconData addIcon = NewSet.add, // 添加按钮图标
    Widget? importPage, // 导入页面
    String importLabel = 'Import', // 导入按钮文字
    IconData importIcon = NewSet.download, // 导入按钮图标
  }
) {
  bool isCollapsed = true; // 初始为折叠状态

  return StatefulBuilder( // 使用StatefulBuilder来更新UI
    builder: (context, setState) {
      return Scaffold(
        appBar: CustomAppBar(title: pageTitle),
        body: Column(
          children: [
            // Toggle button for collapsing/expanding content
            IconButton(
              icon: Icon(isCollapsed ? Icons.expand_more : Icons.expand_less),
              onPressed: () {
                setState(() { // 使用setState更新UI
                  isCollapsed = !isCollapsed;
                });
              },
            ),

            // Collapsible content
            Visibility(
              visible: !isCollapsed,
              child: Column(
                children: [
                  // 导航到 SubscriptionListView 的 GestureDetector
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => navigationPage),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Center(
                        child: OrientationBuilder(
                          builder: (context, orientation) {
                            final mediaQuery = MediaQuery.of(context);
                            const double cardRatio = 9 / 1.3;

                            final cardWidth = mediaQuery.size.width < 600
                                ? mediaQuery.size.width * 0.9
                                : mediaQuery.size.width < 900
                                    ? mediaQuery.size.width * 0.7
                                    : mediaQuery.size.width * 0.5;
                            final cardHeight = cardWidth / cardRatio;

                            return Container(
                              constraints: BoxConstraints(
                                maxWidth: cardWidth,
                                maxHeight: cardHeight,
                              ),
                              child: AspectRatio(
                                aspectRatio: 9 / 1.3,
                                child: createCard(navigationPage),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  //const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: SizedBox(
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            if (exportPage != null) // 只有当 exportPage 不为空时才显示导出按钮
                              ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => exportPage),
                                  );
                                },
                                icon: Icon(exportIcon),
                                label: Text(exportLabel),
                                style: Custom3ButtonStyle.style,
                              ),
                            if (addPage != null) // 只有当 addPage 不为空时才显示添加按钮
                              ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => addPage),
                                  );
                                },
                                icon: Icon(addIcon),
                                label: Text(addLabel), // 使用自定义的 addLabel 
                                style: Custom3ButtonStyle.style,
                              ),
                            if (importPage != null) // 只有当 importPage 不为空时才显示导入按钮
                              ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => importPage),
                                  );
                                },
                                icon: Icon(importIcon),
                                label: Text(importLabel),
                                style: Custom3ButtonStyle.style,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  //广告
                  const GoogleAdWidget(adInfo: AdManager.bannerAd),
                  //广告
                ],
              ),
            ),
            Expanded(
              child: contentPage,
            ),
          ],
        ),
        bottomNavigationBar: const CustomBottomNavigationBar(),
      );
    },
  );
}