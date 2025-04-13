
import 'package:flutter/material.dart'; // 导入BuildContext
import 'translation_texts.dart';


// 扩展方法
extension StringExtension on String {
  String translate(BuildContext context) {
    return translateString(this, context);
  }
}