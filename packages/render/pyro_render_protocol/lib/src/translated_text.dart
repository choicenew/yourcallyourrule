import 'package:material_ui/material_ui.dart';

/// 静态代理与全局 TranslationDelegate 句柄注册接口（协议层解耦）
abstract class TranslationDelegateProvider {
  static Future<String> Function(String text, {String? targetLang, String sourceLang})? _translator;

  static void setTranslator(Future<String> Function(String text, {String? targetLang, String sourceLang}) translator) {
    _translator = translator;
  }

  static Future<String> translate(String text, {String? targetLang, String sourceLang = 'auto'}) async {
    if (_translator != null) {
      return await _translator!(text, targetLang: targetLang, sourceLang: sourceLang);
    }
    return text;
  }
}

/// 下沉至基础协议层的极轻量无感翻译组件 (TranslatedText)
/// 在 Widget 节点粒度做异步无感局部增量更新，不触发表格/全页重绘。
class TranslatedText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final TextOverflow? overflow;
  final int? maxLines;
  final String? targetLang;
  final String sourceLang;
  final bool enabled;

  const TranslatedText(
    this.text, {
    super.key,
    this.style,
    this.overflow,
    this.maxLines,
    this.targetLang,
    this.sourceLang = 'auto',
    this.enabled = true,
  });

  @override
  State<TranslatedText> createState() => _TranslatedTextState();
}

class _TranslatedTextState extends State<TranslatedText> {
  String? _translatedText;

  @override
  void initState() {
    super.initState();
    if (widget.enabled) {
      _triggerTranslation();
    }
  }

  @override
  void didUpdateWidget(covariant TranslatedText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text || oldWidget.targetLang != widget.targetLang) {
      _translatedText = null;
      if (widget.enabled) {
        _triggerTranslation();
      }
    }
  }

  Future<void> _triggerTranslation() async {
    final rawText = widget.text.trim();
    if (rawText.isEmpty) return;

    // 性能优化：英文原文本且目标语种为 en 时无需发起翻译
    final target = widget.targetLang ?? 'zh';
    if (target.startsWith('en') && RegExp(r'^[a-zA-Z0-9\s\p{P}]+$', unicode: true).hasMatch(rawText)) {
      return;
    }

    try {
      final res = await TranslationDelegateProvider.translate(
        rawText,
        targetLang: target,
        sourceLang: widget.sourceLang,
      );
      if (mounted && res.isNotEmpty && res != rawText) {
        setState(() {
          _translatedText = res;
        });
      }
    } catch (_) {
      // 容灾失败降级：保持原文本，无感静默
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _translatedText ?? widget.text,
      style: widget.style,
      overflow: widget.overflow,
      maxLines: widget.maxLines,
    );
  }
}
