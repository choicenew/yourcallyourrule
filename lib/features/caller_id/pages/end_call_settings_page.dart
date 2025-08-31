import 'package:flutter/material.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/adwidgets/inline_adaptive_ad.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class EndCallSettingsPage extends StatefulWidget {
  const EndCallSettingsPage({super.key});

  @override
  EndCallSettingsPageState createState() => EndCallSettingsPageState();
}

class EndCallSettingsPageState extends State<EndCallSettingsPage> {
  String? _selectedInterceptAction = 'endCall';
  final ConfigRepository _configRepository = SharedPreferencesConfigRepository();

  @override
  void initState() {
    super.initState();
    _loadInterceptAction();
  }

  static const String _interceptActionKey = 'config_intercept_action';

  Future<void> _loadInterceptAction() async {
    final config = await _configRepository.getConfig(_interceptActionKey);
    _selectedInterceptAction = config?['value'] as String? ?? 'endCall';
    setState(() {});
  }

  Future<void> _saveInterceptAction(String? newValue) async {
    await _configRepository.saveConfig(_interceptActionKey, {'value': newValue!});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.interceptionActionSettingsTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Text(
                    AppLocalizations.of(context)!.incomingCallInterceptAction,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(AppLocalizations.of(context)!.chooseDefaultInterceptAction),
                  const SizedBox(height: 8),
                  DropdownButton<String>(
                    value: _selectedInterceptAction,
                    isExpanded: true,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedInterceptAction = newValue!;
                      });
                      _saveInterceptAction(newValue);
                    },
                    items: <DropdownMenuItem<String>>[
                      DropdownMenuItem<String>(
                        value: 'endCall',
                        child: Text(AppLocalizations.of(context)!.endCallImmediately),
                      ),
                      DropdownMenuItem<String>(
                        value: 'answerThenHangup',
                        child: Text(AppLocalizations.of(context)!.answerThenHangup),
                      ),
                      DropdownMenuItem<String>(
                        value: 'silenceNoAnswer',
                        child: Text(AppLocalizations.of(context)!.silenceAndNoAnswer),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            InlineAdaptiveBannerAdWidget(adInfo: AdManager.bannerAd, width: 400),
          ],
        ),
      ),
    );
  }
}