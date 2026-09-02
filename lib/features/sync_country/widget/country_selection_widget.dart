import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:world_countries/world_countries.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/google_ad.dart';
import 'package:yourcallyourrule/features/home_elite/theme/elite_dopamine_theme.dart';
import 'package:yourcallyourrule/features/sync_country/provider/country_selection_provider.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 数据库同步国家选择界面 (Elite Dopamine 现代视觉规范)
class CountrySelectionWidget extends ConsumerWidget {
  const CountrySelectionWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final selectedCountries = ref.watch(selectedCountriesProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      appBar: AppBar(
        title: Text(
          l10n.databaseSyncTitle,
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: selectedCountries.when(
        data: (codes) {
          final chosenCountries = WorldCountry.list
              .where((country) => codes.contains(country.codeShort))
              .toList();

          return Column(
            children: [
              // 顶部说明与已选国家卡片
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                padding: const EdgeInsets.all(16.0),
                decoration: EliteDopamineTheme.warmCardDecoration(
                  context: context,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: EliteDopamineTheme.sunsetTangerine.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.public_rounded,
                            color: EliteDopamineTheme.sunsetTangerine,
                            size: 18,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            l10n.countrySyncSettingsSubtitle,
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      l10n.countryDataDisclaimer,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        height: 1.3,
                      ),
                    ),
                    if (codes.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 6.0,
                        children: chosenCountries
                            .map(
                              (country) => Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: EliteDopamineTheme.sunsetTangerine,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      country.name.common,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    InkWell(
                                      onTap: () {
                                        ref
                                            .read(selectedCountriesProvider.notifier)
                                            .removeCountry(country.codeShort);
                                      },
                                      child: const Icon(
                                        Icons.close_rounded,
                                        size: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ],
                ),
              ),

              const GoogleAdWidget(adInfo: AdManager.bannerAd),

              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFFEDE8DF),
                      width: 1.1,
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: CountryPicker(
                    chosen: chosenCountries,
                    onSelect: (country) {
                      final isoCode = country.codeShort;
                      if (codes.contains(isoCode)) {
                        ref
                            .read(selectedCountriesProvider.notifier)
                            .removeCountry(isoCode);
                      } else {
                        ref
                            .read(selectedCountriesProvider.notifier)
                            .addCountry(isoCode);
                      }
                    },
                  ),
                ),
              ),

              const SizedBox(height: 8),
              const GoogleAdWidget(adInfo: AdManager.bannerAd),
              const SizedBox(height: 8),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}