import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourcallyourrule/features/language/provider/language_provider.dart';

class LanguageSettingsPage extends StatefulWidget {
  const LanguageSettingsPage({Key? key}) : super(key: key);

  @override
  State<LanguageSettingsPage> createState() => _LanguageSettingsPageState();
}

class _LanguageSettingsPageState extends State<LanguageSettingsPage> {
  // 支持的语言列表
  final List<Map<String, dynamic>> _supportedLocales = [
    {
      'name': '简体中文',
      'locale': const Locale('zh', 'CN'),
      'flag': 'cn',
    },
    {
      'name': 'English',
      'locale': const Locale('en', 'US'),
      'flag': 'us',
    },
    {
      'name': '繁體中文',
      'locale': const Locale('zh', 'TW'),
      'flag': 'tw',
    },
    {
      'name': '日本語',
      'locale': const Locale('ja', 'JP'),
      'flag': 'jp',
    },
    {
      'name': '한국어',
      'locale': const Locale('ko', 'KR'),
      'flag': 'kr',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final currentLocale = localeProvider.locale;

    return Scaffold(
      appBar: AppBar(
        title: const Text('语言设置'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () => Navigator.of(context).pop(),
            tooltip: '保存',
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildCurrentLanguageCard(currentLocale),
          const SizedBox(height: 16),
          _buildLanguageSelectionCard(currentLocale, localeProvider),
        ],
      ),
    );
  }

  Widget _buildCurrentLanguageCard(Locale currentLocale) {
    // 查找当前语言
    final currentLanguage = _supportedLocales.firstWhere(
      (locale) => locale['locale'].languageCode == currentLocale.languageCode && 
                  locale['locale'].countryCode == currentLocale.countryCode,
      orElse: () => _supportedLocales[0],
    );

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '当前语言',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
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

  Widget _buildLanguageSelectionCard(Locale currentLocale, LocaleProvider provider) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '选择语言',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ..._supportedLocales.map((language) {
              final isSelected = language['locale'].languageCode == currentLocale.languageCode &&
                               language['locale'].countryCode == currentLocale.countryCode;
              return _buildLanguageOption(
                language['name'],
                language['flag'],
                isSelected,
                () {
                  if (!isSelected) {
                    provider.updateLocale(language['locale']);
                  }
                },
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(String name, String flagCode, bool isSelected, VoidCallback onTap) {
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

  Widget _buildFlagImage(String countryCode) {
    // 这里使用一个简单的占位符，实际应用中可以使用真实的国旗图片
    return Container(
      width: 32,
      height: 24,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Text(
          countryCode.toUpperCase(),
          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}