import 'package:flutter/material.dart';

import '../screens/function_cards/function_card.dart';
import '../screens/function_cards/function_cards_data.dart';

// 修改后的 createCard 函数
Widget createCard(Widget navigationPage) {
  List<FunctionCard> allCards = getFunctionCards();

  FunctionCard matchedCard = allCards.firstWhere(
    //(card) => card.page == navigationPage,  // 尝试匹配 navigationPage
    (card) =>
        card.page.runtimeType == navigationPage.runtimeType, // 比较 runtimeType
    orElse: () =>
        throw Exception('Card not found for navigationPage: $navigationPage'),
  );

/*
// 通用函数：根据页面名称创建卡片
Widget createCard(String pageName) {
  // 获取所有功能卡片数据
  List<FunctionCard> allCards = getFunctionCards();

  // 查找匹配的卡片
  FunctionCard matchedCard = allCards.firstWhere(
    (card) => card.page.toString() == pageName,
    orElse: () => throw Exception('Card not found for page: $pageName'),
  );
*/
/** // 查找匹配的卡片
  FunctionCard matchedCard = allCards.firstWhere(
    (card) => card.page.toString.toLowerCase() == pageName.toLowerCase(),
    orElse: () => throw Exception('Card not found for page: $pageName'),
  );
 */

  return Builder(
    builder: (BuildContext context) {
      return OrientationBuilder(
        builder: (context, orientation) {
          // 计算maxWidth
          final mediaQuery = MediaQuery.of(context);
          const double cardRatio = 9 / 1.3;

          final cardWidth = mediaQuery.size.width < 600
              ? mediaQuery.size.width * 0.4
              : mediaQuery.size.width < 900
                  ? mediaQuery.size.width * 0.2
                  : mediaQuery.size.width * 0.1;
          final cardHeight = cardWidth / cardRatio;
          return Container(
            constraints: BoxConstraints(
              maxWidth: cardWidth, // 使用 maxWidth 而不是 width
              maxHeight: cardHeight, // 使用 maxHeight 而不是 height
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [matchedCard.startColor, matchedCard.endColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Padding(
              // 直接在 Container 中添加 Padding
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center, // 垂直居中
                crossAxisAlignment: CrossAxisAlignment.center, // 水平居中
                children: [
                  Container(
                    width: 30.0,
                    height: 30.0,
                    decoration: BoxDecoration(
                      color: matchedCard.iconBackgroundColor,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Icon(
                      matchedCard.icon,
                      color: const Color.fromRGBO(147, 203, 128, 1),
                      size: 28.0,
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Text(
                    matchedCard.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25.0,
                      color: matchedCard.titleColor,
                    ),
                    softWrap: true,
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
