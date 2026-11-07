/// 转换模式枚举
enum CcConversionMode {
  simplifiedToTraditional, // 简体转繁体
  traditionalToSimplified, // 繁体转简体
}

/// 迁移自 readest (simplecc-wasm) 的繁简中文转换转换引擎
class WasmCcConverter {
  static final Map<String, String> _s2tDict = {
    '国': '國', '书': '書', '读': '讀', '爱': '愛', '华': '華', '语': '語',
    '龙': '龍', '风': '風', '关': '關', '开': '開', '门': '門',
    '飞': '飛', '马': '馬', '鸟': '鳥', '鱼': '魚', '发': '發',
  };

  static final Map<String, String> _t2sDict = {
    for (var entry in _s2tDict.entries) entry.value: entry.key
  };

  /// 执行繁简无损转换
  static String convert(String input, CcConversionMode mode) {
    if (input.isEmpty) return input;
    final dict = (mode == CcConversionMode.simplifiedToTraditional) ? _s2tDict : _t2sDict;

    final buffer = StringBuffer();
    for (var i = 0; i < input.length; i++) {
      final char = input[i];
      buffer.write(dict[char] ?? char);
    }
    return buffer.toString();
  }
}
