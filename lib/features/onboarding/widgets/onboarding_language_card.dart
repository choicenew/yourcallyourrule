import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/language/language_data.dart';
import 'package:yourcallyourrule/features/language/provider/language_provider.dart';
import 'package:yourcallyourrule/features/language/widgets/language_selection_widget.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 引导页 2：语言选择卡片组件
class OnboardingLanguageCard extends ConsumerWidget {
  const OnboardingLanguageCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final asyncLocale = ref.watch(localeProvider);
    final List<Map<String, dynamic>> supportedLocales = languages;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.language_rounded, color: theme.colorScheme.primary, size: 24),
              const SizedBox(width: 8),
              Text(
                l10n.selectYourLanguage,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            l10n.onboardingLanguageDescription,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: theme.colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: theme.colorScheme.outlineVariant),
              ),
              padding: const EdgeInsets.all(12),
              child: asyncLocale.when(
                data: (currentLocale) => LanguageSelectionWidget(
                  supportedLocales: supportedLocales,
                  currentLocale: currentLocale,
                  localeNotifier: ref.read(localeProvider.notifier),
                  showCurrentLanguage: false,
                  showAds: false,
                ),
                loading: () => Center(
                  child: CircularProgressIndicator(color: theme.colorScheme.primary),
                ),
                error: (error, stack) => Center(
                  child: Text('Error: $error', style: TextStyle(color: theme.colorScheme.error)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
