import 'dart:convert';
import 'dart:io';

/// Java / Android 资源保留关键字集合 (Reserved Keywords)
/// 任何属于 Java 关键字或内部保留命名的属性，均不能作为 Android 资源名称 (R.string.<name>)
const Set<String> _reservedJavaKeywords = {
  'abstract', 'assert', 'boolean', 'break', 'byte', 'case', 'catch', 'char',
  'class', 'const', 'continue', 'default', 'do', 'double', 'else', 'enum',
  'extends', 'final', 'finally', 'float', 'for', 'goto', 'if', 'implements',
  'import', 'instanceof', 'int', 'interface', 'long', 'native', 'new', 'package',
  'private', 'protected', 'public', 'return', 'short', 'static', 'strictfp',
  'super', 'switch', 'synchronized', 'this', 'throw', 'throws', 'transient',
  'try', 'void', 'volatile', 'while', 'true', 'false', 'null'
};

/// 统一跨平台国际化同步引擎
/// 负责从单一事实来源 (Single Source of Truth: lib/l10n/app_*.arb)
/// 自动生成并同步到 Android 原生 res/values-*/strings.xml
/// 100% 数据驱动，ARB 中所有 key 自动转换为 snake_case 提供给 Android 原生使用。
void main() {
  stdout.writeln('=== Starting Unified L10n Cross-Platform Sync ===');

  final projectDir = Directory.current;
  final l10nDir = Directory('${projectDir.path}/lib/l10n');
  if (!l10nDir.existsSync()) {
    stderr.writeln('[Error] l10n directory not found: ${l10nDir.path}');
    return;
  }

  final arbFiles = l10nDir
      .listSync()
      .whereType<File>()
      .where((f) => f.path.endsWith('.arb'))
      .toList();

  final Map<String, Map<String, String>> localizations = {};
  final Set<String> allKeys = {};

  for (final file in arbFiles) {
    try {
      final jsonContent = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      final locale = jsonContent['@@locale']?.toString() ??
          file.uri.pathSegments.last.replaceAll('app_', '').replaceAll('.arb', '');

      final Map<String, String> strings = {};
      for (final entry in jsonContent.entries) {
        if (entry.key.startsWith('@')) continue;
        strings[entry.key] = entry.value.toString();
        allKeys.add(entry.key);
      }
      localizations[locale] = strings;
      stdout.writeln('[L10n] Parsed ARB for [$locale]: ${strings.length} keys');
    } catch (e) {
      stderr.writeln('[Error] Failed to parse ARB file ${file.path}: $e');
    }
  }

  _syncAndroidStrings(projectDir, localizations, allKeys);

  stdout.writeln('=== Unified L10n Sync Completed Successfully ===');
}

void _syncAndroidStrings(
  Directory projectDir,
  Map<String, Map<String, String>> localizations,
  Set<String> allKeys,
) {
  final androidResDir = Directory('${projectDir.path}/android/app/src/main/res');
  if (!androidResDir.existsSync()) {
    stdout.writeln('[Android] res directory not found: ${androidResDir.path}, skipping Android sync.');
    return;
  }

  final fallbackStrings = localizations['en'] ?? localizations.values.first;
  final sortedKeys = allKeys.toList()..sort();

  final Map<String, String> targetFolders = {
    'values': 'en',
  };

  for (final arbLocale in localizations.keys) {
    final folderName = _getAndroidFolderName(arbLocale);
    targetFolders[folderName] = arbLocale;
  }

  for (final entry in targetFolders.entries) {
    final folderName = entry.key;
    final arbLocale = entry.value;
    final strings = localizations[arbLocale] ?? fallbackStrings;

    final targetDir = Directory('${androidResDir.path}/$folderName');
    if (!targetDir.existsSync()) {
      targetDir.createSync(recursive: true);
    }

    final targetFile = File('${targetDir.path}/strings.xml');

    final buffer = StringBuffer();
    final Set<String> writtenXmlKeys = {};

    void writeXmlItem(String xmlKey, String value) {
      if (writtenXmlKeys.contains(xmlKey)) return;
      writtenXmlKeys.add(xmlKey);
      buffer.writeln('    <string name="$xmlKey" formatted="false">${_escapeXml(value)}</string>');
    }

    buffer.writeln('<?xml version="1.0" encoding="utf-8"?>');
    buffer.writeln('<!-- Generated automatically by tools/sync_l10n.dart from Single Source of Truth (.arb) - DO NOT EDIT MANUALLY -->');
    buffer.writeln('<resources>');

    // 系统基础关键常量
    writeXmlItem('default_notification_channel_id', 'default_channel');
    writeXmlItem('appAuthRedirectScheme', 'yourcallyourrule');

    // 100% 数据驱动：由 ARB 资产文件全量导出 Android strings.xml
    for (final key in sortedKeys) {
      var xmlKey = _camelToSnake(key);

      // 避免 Java 保留字导致 AAPT 编译报错（例如 import -> r_import / import_action）
      if (_reservedJavaKeywords.contains(xmlKey)) {
        xmlKey = '${xmlKey}_action';
      }

      final val = strings[key] ?? fallbackStrings[key] ?? '';
      writeXmlItem(xmlKey, val);

      // 自动补齐 Android 系统必需的 app_name
      if ((xmlKey == 'app_title' || xmlKey == 'app_name') && !writtenXmlKeys.contains('app_name')) {
        writeXmlItem('app_name', val);
      }
    }

    buffer.writeln('</resources>');

    targetFile.writeAsStringSync(buffer.toString());
    stdout.writeln('[Android] Synced ${targetFile.path}');
  }
}

String _getAndroidFolderName(String locale) {
  final normalized = locale.replaceAll('_', '-');
  if (normalized.contains('-')) {
    final parts = normalized.split('-');
    return 'values-${parts[0].toLowerCase()}-r${parts[1].toUpperCase()}';
  }
  return 'values-${normalized.toLowerCase()}';
}

String _escapeXml(String input) {
  var clean = input;
  // 1. 消除 XML 1.0 非法控制字符 (如 \u0000 - \u0008, \u000B, \u000C, \u000E - \u001F)
  clean = clean.replaceAll(RegExp(r'[\x00-\x08\x0B\x0C\x0E-\x1F]'), '');

  // 2. 消除任何可能存在的多重反斜杠
  while (clean.contains(r"\'") || clean.contains(r'\"') || clean.contains(r'\\')) {
    clean = clean.replaceAll(r"\'", "'").replaceAll(r'\"', '"').replaceAll(r'\\', r'\');
  }

  // 3. 遵照 AAPT 规范转义
  return clean
      .replaceAll('&', '&amp;')
      .replaceAll('<', '&lt;')
      .replaceAll('>', '&gt;')
      .replaceAll('"', '&quot;')
      .replaceAll("'", "\\'");
}

String _camelToSnake(String input) {
  final snake = input.replaceAllMapped(
    RegExp(r'([A-Z])'),
    (match) => '_${match.group(1)!.toLowerCase()}',
  );
  return snake.replaceFirst(RegExp(r'^_+'), '');
}
