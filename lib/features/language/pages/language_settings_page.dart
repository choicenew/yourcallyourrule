import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourcallyourrule/features/language/provider/language_provider.dart';
import 'package:yourcallyourrule/features/language/language_data.dart';
import 'package:yourcallyourrule/features/language/widgets/language_selection_widget.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class LanguageSettingsPage extends StatefulWidget {
  const LanguageSettingsPage({super.key});

  @override
  State<LanguageSettingsPage> createState() => _LanguageSettingsPageState();
}

class _LanguageSettingsPageState extends State<LanguageSettingsPage> {
  final List<Map<String, dynamic>> _supportedLocales = languages;

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final currentLocale = localeProvider.locale;

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
          LanguageSelectionWidget(
            supportedLocales: _supportedLocales,
            currentLocale: currentLocale,
            localeProvider: localeProvider,
          ),
        ],
      ),
    );
  }


}