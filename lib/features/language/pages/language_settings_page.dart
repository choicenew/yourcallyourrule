import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/language/provider/language_provider.dart';
import 'package:yourcallyourrule/features/language/language_data.dart';
import 'package:yourcallyourrule/features/language/widgets/language_selection_widget.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

// 使用 ConsumerStatefulWidget 替代 StatefulWidget
class LanguageSettingsPage extends ConsumerStatefulWidget {
  const LanguageSettingsPage({super.key});

  @override
  ConsumerState<LanguageSettingsPage> createState() => _LanguageSettingsPageState();
}

// 使用 ConsumerState 替代 State
class _LanguageSettingsPageState extends ConsumerState<LanguageSettingsPage> {
  final List<Map<String, dynamic>> _supportedLocales = languages;

  @override
  Widget build(BuildContext context) {
    // 使用 ref.watch 获取 localeProvider 的状态
    final localeState = ref.watch(localeProvider);
    final currentLocale = localeState.locale;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.languageSettings),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () => Navigator.of(context).pop(),
            tooltip: AppLocalizations.of(context)!.save,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // 使用 Riverpod 版本的 LanguageSelectionWidget
          LanguageSelectionWidget(
            supportedLocales: _supportedLocales,
            currentLocale: currentLocale,
            localeNotifier: ref.read(localeProvider.notifier),
          ),
        ],
      ),
    );
  }
}