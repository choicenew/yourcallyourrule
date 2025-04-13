
import 'package:flutter/material.dart';

import '../../generated/l10n.dart'; // 导入BuildContext

// 翻译函数
String translateString(String text, BuildContext context) {
  switch (text) {
    case "localCard1":
      return S.of(context).localCard1;
    case "localCard1Content":
      return S.of(context).localCard1Content;
    case "blockedCallsStatistics":
      return S.of(context).blockedCallsStatistics;
    case "callerIdStyle":
      return S.of(context).callerIdStyle;
    case "callerIdStyleContent":
      return S.of(context).callerIdStyleContent;
          case "translation":
      return S.of(context).translation;
    case "TheTranslationContent":          
      return S.of(context).theTranslationIsNotYetComplete;
    // ... 其他需要翻译的字符串
    default:
      return text; // 如果找不到翻译文本，则返回原始字符串
  }
}