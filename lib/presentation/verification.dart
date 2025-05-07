import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/adwidgets/native_ads.dart';
import 'package:yourcallyourrule/ads/google_ad.dart';
import 'package:yourcallyourrule/core/entities/caller_id_data.dart';

import '../generated/l10n.dart';

import 'package:dlibphonenumber/dlibphonenumber.dart' as dlibphone;

class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key});

  @override
  VerificationPageState createState() => VerificationPageState();
}

class VerificationPageState extends State<VerificationPage> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _countryCodeController =
      TextEditingController(text: "US"); // Default to US
  bool _isLoading = false;
  Map<String, bool> _verificationResults = {};
  CallerIdData? _callerIdData;
  Map<String, dynamic>? _pluginData;

  // Instance of TimeBasedInterceptor (similar to MyHomePage)
  final TimeBasedInterceptor timeBasedInterceptor = TimeBasedInterceptor();

  @override
  void initState() {
    super.initState();
    _loadTimeBasedInterceptorConfig(); // Load config on initialization
  }

  Future<void> _loadTimeBasedInterceptorConfig() async {
    await timeBasedInterceptor.loadConfig();
    setState(() {}); // Update state to reflect changes
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _countryCodeController.dispose();
    super.dispose();
  }

  Future<void> _verifyPhoneNumber() async {
    setState(() {
      _isLoading = true;
      _verificationResults = {};
      _callerIdData = null;
      _pluginData = null;
    });

    final phoneNumber = _phoneNumberController.text;
    final countryCode =
        _countryCodeController.text.toUpperCase(); // Ensure uppercase
    final appState = Provider.of<AppState>(context, listen: false);
    final callFilter = appState.callFilter;
    final callerIdService = appState.callerIdService;
    final pluginService = callerIdService.pluginService;

    // Perform verifications using shouldAcceptCall (all rules)
    _verificationResults =
        await _checkAllRules(phoneNumber, callFilter, timeBasedInterceptor);

    // Get Caller ID data using provided country code
    // Get the current language code
    final languageCode = currentLocale?.languageCode ?? 'en';

    final dlibLocale = dlibphone.Locale(
      language: languageCode,
      country: countryCode,
    );
    _callerIdData = await callerIdService.getCallerId(phoneNumber, dlibLocale);

    // Get Plugin data
    _pluginData = await pluginService.callPlugins(
      phoneNumber,
      _callerIdData?.phoneNumber ?? '',
      _callerIdData?.phoneNumber ?? '',
    );

    setState(() {
      _isLoading = false;
    });
  }

// Check against all rules in shouldAcceptCall and shouldIntercept
  Future<Map<String, bool>> _checkAllRules(String phoneNumber,
      CallFilter callFilter, TimeBasedInterceptor timeBasedInterceptor) async {
    // Determine if the number would be allowed by default (if no other rules block it)
    bool allowOtherNumbers =
        await callFilter.shouldAcceptCall(phoneNumber); // Call shouldAcceptCall

    return {
      'Reject All Numbers': !callFilter.config.rejectAllNumbers,
      'Allow All Allowed Numbers': callFilter.config.allowAllAllowedNumbers &&
          await callFilter.allowedService.contains(phoneNumber),
      'Allow Blocked Numbers':
          !(await callFilter.blockedService.contains(phoneNumber) &&
              !callFilter.config.allowBlockedNumbers),
      'Allow Whitelist Regex':
          callFilter.config.allowRegexWhitelistedPatterns &&
              await _matchesRegex(phoneNumber,
                  await callFilter.regexService.getWhitelistedPatterns()),
      'Allow Whitelist': callFilter.config.allowAllWhitelistedNumbers &&
          await callFilter.whitelistService.contains(phoneNumber),
      'Allow Blacklist Regex':
          !(callFilter.config.allowRegexBlacklistedPatterns &&
              await _matchesRegex(phoneNumber,
                  await callFilter.regexService.getBlacklistedPatterns())),
      'Allow Blacklist':
          !(await callFilter.blacklistService.contains(phoneNumber) &&
              !callFilter.config.allowAllBlacklistedNumbers),
      'Should Intercept':
          timeBasedInterceptor.config.shouldIntercept, // Inverted for display
      'Allow Other Numbers': allowOtherNumbers, // Add the new rule here
    };
  }

  Future<bool> _matchesRegex(
      String phoneNumber, List<RegexPattern> patterns) async {
    for (var rexPattern in patterns) {
      if (rexPattern.enabled &&
          RegExp(rexPattern.pattern).hasMatch(phoneNumber)) {
        return true;
      }
    }
    return false;
  }

  // Method to test the overlay
  Future<void> _testShowCallerIdOverlay() async {
    if (_callerIdData == null) {
      // Show an error message or handle the case where _callerIdData is null
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).callerIdDataIsNotAvailable)),
      );
      return;
    }

    final appState = Provider.of<AppState>(context, listen: false);
    await appState.callerIdMonitorService
        .showCallerIdOverlay(_callerIdData!, null, null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).verifyPhoneNumber),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 新增的标题 "TO test rules"
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0), // 添加底部间距
              child: Text(
                S.of(context).toTestRules,
                style: const TextStyle(
                  fontSize: 24.0, // 可以根据需要调整字号
                  fontWeight: FontWeight.bold, // 可以根据需要调整字重
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            // 广告 - Centered with Align
            const Align(
              alignment: Alignment.center,
              child: GoogleAdWidget(adInfo: AdManager.adaptiveBannerAd),
            ),

            const SizedBox(height: 16.0),
            TextField(
              controller: _phoneNumberController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: S.of(context).phonenumber,
                hintText: 'Enter phone number to verify',
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _countryCodeController,
              decoration: InputDecoration(
                labelText: S.of(context).countryCode,
                hintText: S.of(context).enterCountryCode,
              ),
            ),
            const SizedBox(height: 20),
            // 广告 - Centered with Align
            const Align(
              alignment: Alignment.center,
              child: GoogleAdWidget(adInfo: AdManager.adaptiveBannerAd),
            ),

            const SizedBox(height: 8.0),
            Center(
              child: ElevatedButton(
                onPressed: _isLoading ? null : _verifyPhoneNumber,
                child: _isLoading
                    ? const CircularProgressIndicator.adaptive()
                    : Text(S.of(context).verify),
              ),
            ),
            const SizedBox(height: 20),
            if (_verificationResults.isNotEmpty) ...[
              Text(S.of(context).verificationResultsRules,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              ..._verificationResults.entries.map((entry) {
                // Get localized title based on the rule key
                String localizedTitle;
                switch (entry.key) {
                  case 'Reject All Numbers':
                    localizedTitle = S.of(context).rejectAllNumbers;
                    break;
                  case 'Allow All Allowed Numbers':
                    localizedTitle = S.of(context).allowAllAllowedNumbers;
                    break;
                  case 'Allow Blocked Numbers':
                    localizedTitle = S.of(context).allowBlockedNumbers;
                    break;
                  case 'Allow Whitelist Regex':
                    localizedTitle =
                        S.of(context).allowRegexWhitelistedPatterns;
                    break;
                  case 'Allow Whitelist':
                    localizedTitle = S.of(context).allowAllWhitelistedNumbers;
                    break;
                  case 'Allow Blacklist Regex':
                    localizedTitle =
                        S.of(context).allowRegexBlacklistedPatterns;
                    break;
                  case 'Allow Blacklist':
                    localizedTitle = S.of(context).allowAllBlacklistedNumbers;
                    break;
                  case 'Should Intercept':
                    localizedTitle =
                        '${S.of(context).repeatedBlockedCallsIn} ${timeBasedInterceptor.config.duration.inMinutes} ${S.of(context).mins}';
                    break;
                  case 'Allow Other Numbers':
                    localizedTitle =
                        S.of(context).allowOtherNumbers; // Add localization
                    break;
                  default:
                    localizedTitle =
                        entry.key; // Fallback to the key if not found
                }

                return ListTile(
                  title: Text(localizedTitle), // Use localized title here
                  trailing: Icon(entry.value ? Icons.check : Icons.close,
                      color: entry.value ? Colors.green : Colors.red),
                );
              }),
            ],

            // 广告 - Centered with Align
            const Align(
              alignment: Alignment.center,
              child: GoogleAdWidget(adInfo: AdManager.adaptiveBannerAd),
            ),

            if (_callerIdData != null) ...[
              const SizedBox(height: 20),
              Text(S.of(context).callerIdData,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              ListTile(
                title: Text(S.of(context).name),
                trailing: Text(_callerIdData!.name),
              ),
              ListTile(
                title: Text(S.of(context).phonenumber),
                trailing: Text(_callerIdData!.phoneNumber),
              ),
              ListTile(
                title: Text(S.of(context).countryName),
                trailing: Text(_callerIdData!.countryName),
              ),
              if (_callerIdData!.region != null)
                ListTile(
                  title: Text(S.of(context).region),
                  trailing: Text(_callerIdData!.region!),
                ),
              if (_callerIdData!.carrier != null)
                ListTile(
                  title: Text(S.of(context).carrier),
                  trailing: Text(_callerIdData!.carrier!),
                ),
              if (_callerIdData!.numberType != null)
                ListTile(
                  title: Text(S.of(context).numberType),
                  trailing: Text(_callerIdData!.numberType!.toString()),
                ),
              ListTile(
                title: Text(S.of(context).label),
                trailing:
                    Text(_callerIdData!.labels.map((l) => l.label).join(', ')),
              ),
              if (_callerIdData!.avatar != null)
                ListTile(
                  leading:
                      CircleAvatar(backgroundImage: _callerIdData!.avatarImage),
                  title: Text(S.of(context).avatar),
                ),
              if (_callerIdData!.count != null)
                ListTile(
                  title: Text(S.of(context).count),
                  trailing: Text(_callerIdData!.count!.toString()),
                ),
            ],
            if (_pluginData != null) ...[
              const SizedBox(height: 20),
              Text(S.of(context).pluginData,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              ..._pluginData!.entries.map((entry) => ListTile(
                    title: Text(entry.key),
                    trailing: Text(entry.value.toString()),
                  )),
            ],
            const SizedBox(height: 20),
            // Button to test showCallerIdOverlay
            Center(
              child: ElevatedButton(
                onPressed:
                    _callerIdData != null ? _testShowCallerIdOverlay : null,
                child: Text(S.of(context).testCallerIdOverlay),
              ),
            ),
            //广告代码 - Centered with Align
            Align(
              alignment: Alignment.center,
              child: nativeAdWidgetMedium(adWidth: 320, adHeight: 390),
            ),
          ],
        ),
      ),
    );
  }
}
