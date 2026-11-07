import 'dynamic_text_translator.dart';

/// 动态句式与结构范式转译器 (Pattern Localizer)
/// 负责将带有数字、状态量、百分比、页码等结构的动态中文句式转译为符合目标语言语法的句子
abstract final class PatternLocalizer {
  /// 通用数据源/分类标签转译
  static String localizeCategoryTag(
    String tag,
    DynamicTextTranslator translator,
  ) {
    if (tag.isEmpty) return tag;
    return translator.translateTerm(tag);
  }

  /// 状态与进度结构句式转译 (如 "第 12 章", "第12章", "共 50 页", "连载中", "已完结")
  static String localizeStatusPhrase(
    String rawText,
    DynamicTextTranslator translator,
  ) {
    if (rawText.isEmpty || translator.isNativeChinese) return rawText;

    var result = rawText;

    // A. 处理 "第 X 章 / 第 X 话 / 第 X 页" 动态句式
    result = result.replaceAllMapped(
      RegExp(r'第\s*(\d+)\s*([章话页集卷])'),
      (m) {
        final numStr = m.group(1)!;
        final unitStr = m.group(2)!;
        final translatedUnit = translator.translateTerm(unitStr);
        if (translator.localeCode.startsWith('zh_')) {
          return '第 $numStr $translatedUnit';
        }
        return '$translatedUnit $numStr';
      },
    );

    // B. 处理 "共 X 页 / 共 X 话"
    result = result.replaceAllMapped(
      RegExp(r'共\s*(\d+)\s*([章话页集卷])'),
      (m) {
        final numStr = m.group(1)!;
        final unitStr = m.group(2)!;
        final translatedUnit = translator.translateTerm(unitStr);
        if (translator.localeCode.startsWith('zh_')) {
          return '共 $numStr $translatedUnit';
        }
        return 'Total $numStr $translatedUnit';
      },
    );

    // C. 传入长词优先词典做二次替换
    return translator.translateDynamicText(result);
  }
}
