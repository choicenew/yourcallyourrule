import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:world_flags/world_flags.dart';
import 'package:yourcallyourrule/features/language/language_data.dart';
import 'package:yourcallyourrule/features/language/provider/language_provider.dart';
import 'package:yourcallyourrule/features/language/widgets/language_selection_widget.dart';
import 'package:yourcallyourrule/features/country_database/provider/country_selection_provider.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 引导页 2：语言与离线国家规则库选择卡片组件
class OnboardingLanguageCard extends ConsumerWidget {
  const OnboardingLanguageCard({super.key});

  static const List<String> _popularCountries = ['CN', 'US', 'GB', 'JP', 'DE', 'AU'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final asyncLocale = ref.watch(localeProvider);
    final selectedCountriesAsync = ref.watch(selectedCountriesProvider);
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
          const SizedBox(height: 16),
          Expanded(
            flex: 3,
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
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: theme.colorScheme.outlineVariant),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.public_rounded, color: theme.colorScheme.primary, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          l10n.selectCountry,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        visualDensity: VisualDensity.compact,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                      ),
                      onPressed: () => _showAllCountriesDialog(context, ref),
                      child: Text(l10n.custom, style: const TextStyle(fontSize: 13)),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                selectedCountriesAsync.when(
                  data: (selectedCodes) {
                    final notifier = ref.read(selectedCountriesProvider.notifier);
                    return Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: _popularCountries.map((code) {
                        final isSelected = selectedCodes.contains(code);
                        final worldCountry = WorldCountry.maybeFromAnyCode(code) ?? const WorldCountry.usa();
                        return FilterChip(
                          avatar: CountryFlag.simplified(
                            worldCountry,
                            height: 16,
                            aspectRatio: FlagConstants.defaultAspectRatio,
                          ),
                          label: Text(code, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                          selected: isSelected,
                          onSelected: (val) {
                            if (val) {
                              notifier.addCountry(code);
                            } else {
                              notifier.removeCountry(code);
                            }
                          },
                        );
                      }).toList(),
                    );
                  },
                  loading: () => const Center(
                    child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)),
                  ),
                  error: (error, stack) => const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showAllCountriesDialog(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final all = WorldCountry.list;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.4,
          maxChildSize: 0.85,
          expand: false,
          builder: (sheetCtx, scrollCtrl) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    l10n.selectCountry,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Consumer(
                    builder: (consumerCtx, cRef, _) {
                      final codes = cRef.watch(selectedCountriesProvider).value ?? [];
                      final notifier = cRef.read(selectedCountriesProvider.notifier);
                      return ListView.builder(
                        controller: scrollCtrl,
                        itemCount: all.length,
                        itemBuilder: (itemCtx, index) {
                          final c = all[index];
                          final isSelected = codes.contains(c.codeShort);
                          return ListTile(
                            leading: CountryFlag.simplified(
                              c,
                              height: 20,
                              aspectRatio: FlagConstants.defaultAspectRatio,
                            ),
                            title: Text(c.name.common),
                            subtitle: Text(c.codeShort),
                            trailing: isSelected
                                ? const Icon(Icons.check_circle_rounded, color: Colors.green)
                                : null,
                            onTap: () {
                              if (isSelected) {
                                notifier.removeCountry(c.codeShort);
                              } else {
                                notifier.addCountry(c.codeShort);
                              }
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
