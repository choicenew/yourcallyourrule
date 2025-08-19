import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:world_countries/world_countries.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/google_ad.dart';
import 'package:yourcallyourrule/features/sync_country/provider/country_selection_provider.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// A widget that allows users to select countries for data synchronization.
class CountrySelectionWidget extends ConsumerWidget {
  const CountrySelectionWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCountries = ref.watch(selectedCountriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.databaseSyncTitle),
      ),
      body: selectedCountries.when(
        data: (codes) {
          final chosenCountries = WorldCountry.list
              .where((country) => codes.contains(country.idd.phoneCode()))
              .toList();

          return Column(
            children: [

              // --- START: 新增的小标题 ---
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                child: Text(
                  AppLocalizations.of(context)!.countrySyncSettingsSubtitle,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.grey[600], // 使用灰色调，使其看起来像副标题
                      ),
                  textAlign: TextAlign.center, // 居中显示
                ),
              ),
              // --- END: 新增的小标题 ---
              // --- START: 新增的免责声明 ---
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 12.0),
                child: Text(
                  AppLocalizations.of(context)!.countryDataDisclaimer,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith( // 使用更小的字体
                        color: Colors.grey, // 使用更浅的颜色
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              // --- END: 新增的免责声明 ---
              if (codes.isNotEmpty)
              
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: codes
                        .map((code) => Chip(
                              label: Text(
                                code,
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                                                    backgroundColor: Colors.pink[100], // 使用更深的琥珀色
                    deleteIconColor: Colors.white,
                              onDeleted: () {
                                ref
                                    .read(selectedCountriesProvider.notifier)
                                    .removeCountry(code);
                              },
                            ))
                        .toList(),
                  ),
                ),
                 GoogleAdWidget(adInfo: AdManager.bannerAd),
              const Divider(),
              Expanded(
                child: CountryPicker(
                  chosen: chosenCountries,
                  onSelect: (country) {
                    final phoneCode = country.idd.phoneCode();
                    if (codes.contains(phoneCode)) {
                      ref
                          .read(selectedCountriesProvider.notifier)
                          .removeCountry(phoneCode);
                    } else {
                      ref
                          .read(selectedCountriesProvider.notifier)
                          .addCountry(phoneCode);
                    }
                  },
                ),
              ),
               const SizedBox(height: 12),
                 GoogleAdWidget(adInfo: AdManager.bannerAd),
                  const SizedBox(height: 12),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}