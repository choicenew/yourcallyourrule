import '../core/dispatch/provider_registry.dart';
import 'alibaba_provider.dart';
import 'apertium_provider.dart';
import 'baidu_provider.dart';
import 'bing_provider.dart';
import 'deeplx_provider.dart';
import 'google_provider.dart';
import 'itranslate_provider.dart';
import 'lara_translate_provider.dart';
import 'lingva_provider.dart';
import 'lingvanex_provider.dart';
import 'modern_mt_provider.dart';
import 'mymemory_provider.dart';
import 'papago_provider.dart';
import 'sogou_provider.dart';
import 'translate_cat_provider.dart';
import 'translate_com_provider.dart';
import 'volcengine_provider.dart';
import 'wordvice_provider.dart';
import 'xunfei_provider.dart';
import 'yandex_provider.dart';
import 'youdao_provider.dart';

bool _builtinRegistered = false;

/// 自动注册全量内置翻译 Provider
void registerBuiltinProviders() {
  if (_builtinRegistered) return;
  _builtinRegistered = true;

  // 1. 优先注册实测 100% SUCCESS (1222ms) 的 LaraTranslate
  TranslationProviderRegistry.register('LaraTranslate', () => LaraTranslateProvider(), csvKey: 'google');

  // 2. 注册核心稳定大厂矩阵
  TranslationProviderRegistry.register('Google', () => GoogleProvider(), csvKey: 'google');
  TranslationProviderRegistry.register('Bing', () => BingProvider(), csvKey: 'bing');
  TranslationProviderRegistry.register('DeepLX', () => DeepLXProvider(), csvKey: 'deepl');
  TranslationProviderRegistry.register('MyMemory', () => MyMemoryProvider(), csvKey: 'google');
  TranslationProviderRegistry.register('Yandex', () => YandexProvider(), csvKey: 'yandex');
  TranslationProviderRegistry.register('Youdao', () => YoudaoProvider(), csvKey: 'google');
  TranslationProviderRegistry.register('Sogou', () => SogouProvider(), csvKey: 'sogou');
  TranslationProviderRegistry.register('Alibaba', () => AlibabaProvider(), csvKey: 'alibaba');
  TranslationProviderRegistry.register('TranslateCom', () => TranslateComProvider(), csvKey: 'translateCom');
  TranslationProviderRegistry.register('Lingvanex', () => LingvanexProvider(), csvKey: 'lingvanex');
  TranslationProviderRegistry.register('Papago', () => PapagoProvider(), csvKey: 'papago');
  TranslationProviderRegistry.register('ModernMt', () => ModernMtProvider(), csvKey: 'modernMt');
  TranslationProviderRegistry.register('Itranslate', () => ItranslateProvider(), csvKey: 'itranslate');
  TranslationProviderRegistry.register('Apertium', () => ApertiumProvider(), csvKey: 'apertium');
  TranslationProviderRegistry.register('TranslateCat', () => TranslateCatProvider(), csvKey: 'google');
  TranslationProviderRegistry.register('Wordvice', () => WordviceProvider(), csvKey: 'google');
  TranslationProviderRegistry.register('Lingva', () => LingvaProvider(), csvKey: 'google');
  TranslationProviderRegistry.register('Baidu', () => BaiduProvider(), csvKey: 'google');
  TranslationProviderRegistry.register('Volcengine', () => VolcengineProvider(), csvKey: 'google');
  TranslationProviderRegistry.register('Xunfei', () => XunfeiProvider(), csvKey: 'google');
}
