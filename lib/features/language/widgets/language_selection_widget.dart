import 'package:flutter/material.dart';
import 'package:yourcallyourrule/features/language/provider/language_provider.dart';
import 'package:world_flags/world_flags.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class LanguageSelectionWidget extends StatelessWidget {
  final List<Map<String, dynamic>> supportedLocales;
  final Locale currentLocale;
  final LocaleProvider localeProvider;
  final bool showCurrentLanguage;
  final bool showSelectionList;

  const LanguageSelectionWidget({
    super.key,
    required this.supportedLocales,
    required this.currentLocale,
    required this.localeProvider,
    this.showCurrentLanguage = true,
    this.showSelectionList = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (showCurrentLanguage) ...[_buildCurrentLanguageCard(context), const SizedBox(height: 16)],
        if (showSelectionList) _buildLanguageSelectionCard(context),
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

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.currentLanguage,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withValues(alpha:0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      _buildFlagImage(currentLanguage['flag']),
                      const SizedBox(width: 12),
                      Text(
                        currentLanguage['name'],
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const Icon(Icons.check, color: Colors.orange),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageSelectionCard(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.selectLanguage,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...supportedLocales.map((language) {
              final isSelected =
                  language['code'].languageCode == currentLocale.languageCode &&
                  language['code'].countryCode == currentLocale.countryCode;
              return _buildLanguageOption(
                context,
                language['name'],
                language['flag'],
                isSelected,
                () {
                  if (!isSelected) {
                    localeProvider.updateLocale(language['code']);
                  }
                },
              );
            }),
          ],
        ),
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
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade200),
          ),
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
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            if (isSelected) const Icon(Icons.check, color: Colors.orange),
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