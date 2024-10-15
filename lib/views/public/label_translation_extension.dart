import 'package:flutter/material.dart';

import 'label_map.dart';

//定义一个扩展函数

extension LabelTranslationExtension on String {
  String translate(BuildContext context) {
    // 使用导入的 getLabelMap 函数
    final labelMap = getLabelMap(context);
    return labelMap[this] ?? this;
  }
}