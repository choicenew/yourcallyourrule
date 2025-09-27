import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/language/provider/language_provider.dart';
// 1. 【确保】导入的是新的、经过迁移的 provider

import 'package:yourcallyourrule/features/language/language_data.dart';
import 'package:yourcallyourrule/features/language/widgets/language_selection_widget.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

// 使用 ConsumerStatefulWidget 保持不变
class LanguageSettingsPage extends ConsumerStatefulWidget {
  const LanguageSettingsPage({super.key});

  @override
  ConsumerState<LanguageSettingsPage> createState() => _LanguageSettingsPageState();
}

// 使用 ConsumerState 保持不变
class _LanguageSettingsPageState extends ConsumerState<LanguageSettingsPage> {
  final List<Map<String, dynamic>> _supportedLocales = languages;

  @override
  Widget build(BuildContext context) {
    // 2. 【修改】ref.watch(localeProvider) 现在返回的是一个 AsyncValue<Locale>
    // 我们用一个新变量名 asyncLocale 来表示它的异步特性
    final asyncLocale = ref.watch(localeProvider);

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
      // 3. 【核心修改】使用 asyncLocale.when 来根据 provider 的状态构建不同的UI
      // 这是处理异步 Provider 的标准和最佳实践
      body: asyncLocale.when(
        
        // (A) 当数据成功加载时，'data' 回调会被调用
        // 它会提供一个解包后的 'currentLocale' (Locale 类型) 对象
        data: (currentLocale) {
          // 在这里返回你原来的UI布局
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              LanguageSelectionWidget(
                supportedLocales: _supportedLocales,
                // 直接使用从 'data' 回调中获取的 currentLocale
                currentLocale: currentLocale,
                // 获取 notifier 的方式保持不变
                localeNotifier: ref.read(localeProvider.notifier),
              ),
            ],
          );
        },

        // (B) 当 Provider 正在加载初始数据时 (例如，从SharedPreferences读取)
        // 'loading' 回调会被调用
        loading: () {
          // 在加载期间，显示一个居中的加载指示器
          return const Center(
            child: CircularProgressIndicator(),
          );
        },

        // (C) 如果在加载过程中发生任何错误
        // 'error' 回调会被调用
        error: (error, stackTrace) {
          // 显示一个错误信息，这对于调试和用户反馈非常有用
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Failed to load language settings:\n$error',
                textAlign: TextAlign.center,
              ),
            ),
          );
        },
      ),
    );
  }
}