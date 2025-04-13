//import 'dart:io';
import 'dart:core';

import 'package:flutter/material.dart';

import '../../widgets/adwidgets/native_ads.dart';


// 提取的公共 Widget 代码
Widget buildResponsiveGridList<T>(List<T> entries, Widget Function(T entry, double width) buildEntryItem, bool isAdEnabled) {
  return OrientationBuilder(
    builder: (context, orientation) {
      final mediaQuery = MediaQuery.of(context);

      // 根据屏幕方向和宽度设置每行卡片数
      final int entriesPerRow = orientation == Orientation.portrait
          ? (mediaQuery.size.width > 900 ? 2 : 1)
          : (mediaQuery.size.width > 1000 ? 4 : 2);

      // 根据屏幕宽度设置水平 padding
      final double functionEntryHorizontalPadding =
          mediaQuery.size.width > 900 ? 24.0 : 9.0;

      // 计算卡片宽度
      final double entryWidth = (mediaQuery.size.width -
              2 * functionEntryHorizontalPadding -
              (entriesPerRow - 1) * 10) /
          entriesPerRow;

      return ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: functionEntryHorizontalPadding,
            ),
            child: Wrap(
              spacing: 5,
              runSpacing: 5,
              alignment: WrapAlignment.spaceBetween,
              children: List.generate(entries.length + (isAdEnabled ? entries.length ~/ 3 : 0), (index) {
                if ((index + 1) % 4 == 0 && isAdEnabled) {
                  return nativeAdWidgetSmall(adWidth: entryWidth, adHeight: 90);
                } else {
                  final adjustedIndex = index - (index ~/ 4);
                  return SizedBox(
                    width: entryWidth,
                    child: buildEntryItem(entries[adjustedIndex], entryWidth),
                  );
                }
              }),
            ),
          ),
        ],
      );
    },
  );
}

/*
Widget _build(BuildContext context) {
  final adState = Provider.of<AdState>(context);
  return buildResponsiveGridList(_entries, _buildEntryItem, adState.isAdEnabled);
}
*/