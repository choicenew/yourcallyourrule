import 'package:flutter/material.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/adwidgets/native_ads.dart';
import 'package:yourcallyourrule/ads/google_ad.dart';
import 'package:yourcallyourrule/features/language/provider/language_provider.dart';
import 'package:world_flags/world_flags.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class LanguageSelectionWidget extends StatelessWidget {
  final List<Map<String, dynamic>> supportedLocales;
  final Locale currentLocale;
  final LocaleNotifier localeNotifier; // Riverpod 的 Notifier
  final bool showCurrentLanguage;
  final bool showSelectionList;
  final bool showAds;

  const LanguageSelectionWidget({
    super.key,
    required this.supportedLocales,
    required this.currentLocale,
    required this.localeNotifier,
    this.showCurrentLanguage = true,
    this.showSelectionList = true,
    this.showAds = true, // 默认显示广告
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (showCurrentLanguage) ...[
          _buildCurrentLanguageCard(context),
          const SizedBox(height: 16)
        ],
        if (showAds) ...[
          GoogleAdWidget(adInfo: AdManager.adaptiveBannerAd), //插入广告
          const SizedBox(height: 16),
        ],
        if (showSelectionList) _buildLanguageSelectionCard(context),
        if (showAds) ...[
          const SizedBox(height: 16),
          nativeAdWidgetMedium(adWidth: 400, adHeight: 320) //插入广告
        ]
      ],
    );
  }

  Widget _buildCurrentLanguageCard(BuildContext context) {
    final currentLanguage = supportedLocales.firstWhere(
      (locale) =>
          locale['code'].languageCode == currentLocale.languageCode &&
          locale['code'].countryCode == currentLocale.countryCode,
      orElse: () => supportedLocales[0],
    );

    return Container(
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFEDE8DF),
          width: 1.1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF9500).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.translate_rounded, color: Color(0xFFFF9500), size: 20),
              ),
              const SizedBox(width: 10),
              Text(
                AppLocalizations.of(context)!.currentLanguage,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.black87),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F5F0),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFEDE8DF)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    _buildFlagImage(currentLanguage['flag'] ?? ''),
                    const SizedBox(width: 12),
                    Text(
                      currentLanguage['name'],
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
                const Icon(Icons.check_circle_rounded, color: Color(0xFFFF9500), size: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageSelectionCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFEDE8DF),
          width: 1.1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF6C5CE7).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.language_rounded, color: Color(0xFF6C5CE7), size: 20),
              ),
              const SizedBox(width: 10),
              Text(
                AppLocalizations.of(context)!.selectLanguage,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.black87),
              ),
            ],
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 280.0,
            child: ListView.builder(
              itemCount: supportedLocales.length,
              itemBuilder: (context, index) {
                final language = supportedLocales[index];
                final isSelected =
                    currentLocale.languageCode == language['code'].languageCode &&
                    (currentLocale.countryCode == null || language['code'].countryCode == null || currentLocale.countryCode == language['code'].countryCode);
                return _buildLanguageOption(
                  context,
                  language['name'],
                  language['flag'] ?? '',
                  isSelected,
                  () {
                    if (!isSelected) {
                      localeNotifier.updateLocale(language['code']);
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageOption(
    BuildContext context,
    String name,
    String flagCode,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        margin: const EdgeInsets.only(bottom: 4),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFF9500).withValues(alpha: 0.08) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                _buildFlagImage(flagCode),
                const SizedBox(width: 12),
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 14.5,
                    fontWeight: isSelected ? FontWeight.w900 : FontWeight.w600,
                    color: isSelected ? const Color(0xFFFF9500) : Colors.black87,
                  ),
                ),
              ],
            ),
            if (isSelected) const Icon(Icons.check_circle_rounded, color: Color(0xFFFF9500), size: 18),
          ],
        ),
      ),
    );
  }

  Widget _buildFlagImage(String? countryCode) {
    if (countryCode == null || countryCode.isEmpty) {
      return Container(
        width: 32,
        height: 24,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(4),
        ),
        child: const Center(child: Icon(Icons.public, size: 18)),
      );
    }
    return CountryFlag.simplified(
      WorldCountry.fromCode(countryCode),
      height: 24,
      aspectRatio: FlagConstants.defaultAspectRatio,
    );
  }
}