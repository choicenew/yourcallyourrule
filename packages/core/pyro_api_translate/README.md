# Translation Engine

A powerful, multi-provider translation package for Dart/Flutter.
一个强大的、支持多源翻译的 Dart/Flutter 插件。

## Features / 特性

- **Multi-Provider Support / 多源支持**: 
  - Integrated with 13+ translation providers (Google, Bing, DeepLX, Yandex, etc.).
  - 集成了13+个翻译源（谷歌、必应、DeepLX、Yandex等）。
- **Auto-Fallback / 自动降级**: 
  - Automatically switches to the next available provider if one fails.
  - 如果一个源失败，自动切换到下一个可用源。
- **Manual Selection / 手动选择**: 
  - Allows specifying a particular provider for translation.
  - 允许指定特定的翻译源进行翻译。
- **Connectivity Check / 连通性检查**: 
  - Intelligently skips Google translate if Google is unreachable (e.g., in CN).
  - 如果无法连接到 Google（如在中国大陆），智能跳过 Google 翻译。

## Supported Providers / 支持的源

| Provider | Type | Note |
| --- | --- | --- |
| **Google** | API | Priority 1. Smart skip if blocked. |
| **Bing** | Scraper | Stable. |
| **DeepLX** | API (DeepL) | High quality. Requires Free API or DeepLX instance. |
| **MyMemory**| API | Translation memory. |
| **Yandex** | API | Russian provider. |
| **Sogou** | Scraper | 搜狗翻译. |
| **Alibaba**| Scraper | 阿里巴巴翻译. |
| **Translate.com** | API | Uses Microsoft backend usually. |
| **Lingvanex**| Scraper | |
| **Papago** | HMAC Scraper | Naver Papago. High quality for Asian languages. |
| **ModernMt** | Signed API | |
| **Itranslate**| Scraper | |
| **Apertium** | API | Open source rule-based translation. |

## Usage / 使用方法

### Basic Usage / 基本用法

The `translate` method will automatically try providers in order until one succeeds.
`translate` 方法会自动按顺序尝试所有源，直到成功。

```dart
import 'package:translation_engine/translation_engine.dart';

final service = TranslationService();

// Auto-detect source language
// 自动检测源语言
final result = await service.translate('Hello World', targetLanguage: 'zh-CN');
print(result); // 你好世界
```

### Manual Selection / 手动选择源

You can get a list of available providers and force the use of a specific one.
你可以获取可用源列表，并强制使用其中一个。

```dart
// Get list of provider names
// 获取源名称列表
final providers = service.availableProviders; 
print(providers); // ['Google', 'Bing', 'DeepLX', ...]

// Force use 'DeepLX'
// 强制使用 'DeepLX'
try {
  final result = await service.translate(
    'Hello World', 
    targetLanguage: 'de', 
    useProvider: 'DeepLX'
  );
  print(result); 
} catch (e) {
  print('DeepLX failed: $e');
}
```

### Configuration / 配置

(TODO: Add configuration details here if `TranslationConfig` is expanded).
(待办: 如果 `TranslationConfig` 扩展，在此添加配置详情).

## Installation / 安装

Add `translation_engine` to your `pubspec.yaml`.
在 `pubspec.yaml` 中添加 `translation_engine`。

```yaml
dependencies:
  translation_engine:
    path: packages/translation_engine
```

## Language Mapping Automation / 语言映射自动化

This package uses an automated system to maintain the mapping between standard language codes (e.g., `zh-CN`) and provider-specific codes (e.g., `zh-Hans` for Bing).

本包使用自动化系统来维护标准语言代码（如 `zh-CN`）与特定源代码（如 Bing 的 `zh-Hans`）之间的映射。

- **Source of Truth / 数据源**: 
  - Direct integration with [UlionTse/translators](https://github.com/UlionTse/translators.git).
  - 直接对接并拉取 `UlionTse/translators` 导出的全量翻译源语言映射字典。

- **Automation / 自动化**:
  - A GitHub Actions workflow (`.github/workflows/sync_translators_languages.yml`) runs automatically on the **1st of every month** or via manual trigger.
  - It fetches language mappings directly from `UlionTse/translators`, merges them with `packages/pyro_api_translate/tool/sync_from_translators.py`, and updates `assets/supported_languages.json`.
  - GitHub Actions 工作流（`.github/workflows/sync_translators_languages.yml`）会在每月 1 号自动运行，通过 `sync_from_translators.py` 从 `UlionTse/translators` 自动提取合并最新语言字典并更新 `assets/supported_languages.json`。

- **Data Format / 数据格式**:
  - The generated JSON contains a list of mappings.
  - **Note**: The `Value` field (e.g., "中文") provides standard language display names, mapping provider-specific language codes under each engine key.

