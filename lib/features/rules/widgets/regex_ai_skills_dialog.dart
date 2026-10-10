import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// AI 规则生成指南 (Skills Prompt) 弹窗组件
/// 提供通用的 AI Prompt & JSON Schema 模板，方便用户复制并发送给 AI 大模型生成正则规则后直接导入
class RegexAiSkillsDialog extends StatelessWidget {
  const RegexAiSkillsDialog({super.key});

  /// 标准且通用的 AI Prompt 文本（使用标准英文 Prompt，避免 AI 解析国际化 key 时报错）
  static const String aiSkillsPrompt = '''
You are an expert regex rule assistant for "YourCallYourRule" Android app.
Please generate a valid JSON array of regex rules according to my request.

### Output JSON Format Specification:
[
  {
    "id": "optional-uuid-string",
    "name": "Rule Name Description",
    "pattern": "^(400|800)\\\\d{7}\$",
    "action": "block",
    "isEnabled": 1,
    "priority": 5,
    "ruleType": "regex"
  }
]

### Field Constraints:
- "name": Brief rule description.
- "pattern": Standard regular expression string. Remember to escape backslashes correctly for JSON string (e.g. \\d).
- "action": Must be one of "block" (intercept), "allow" (whitelist), "silence" (mute).
- "isEnabled": 1 for enabled, 0 for disabled.
- "priority": 5 for block rules, 10 for allow rules, 1 for silence rules.
- "ruleType": Must be "regex".

### My Request:
[Please replace this text with your specific rule requirements, e.g., "Generate rules to block numbers starting with 400 and 800"]
''';

  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => const RegexAiSkillsDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AlertDialog(
      title: Row(
        children: [
          Icon(Icons.psychology_rounded, color: colorScheme.primary),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'AI Rule Assistant (Skills)',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Copy the prompt below and send it to any AI (ChatGPT, DeepSeek, Claude) to generate regex rules, then use "Import JSON" to load them into the app:',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: colorScheme.outline.withValues(alpha: 0.3),
                ),
              ),
              child: SelectableText(
                aiSkillsPrompt,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontFamily: 'monospace',
                  color: colorScheme.onSurface,
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(AppLocalizations.of(context)!.closeButton),
        ),
        FilledButton.icon(
          onPressed: () {
            Clipboard.setData(const ClipboardData(text: aiSkillsPrompt));
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('AI Prompt copied to clipboard!'),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 2),
              ),
            );
          },
          icon: const Icon(Icons.copy_rounded, size: 18),
          label: const Text('Copy Prompt'),
        ),
      ],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    );
  }
}
