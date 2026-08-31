import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/adwidgets/native_ads.dart';
import 'package:yourcallyourrule/ads/google_ad.dart';
import 'package:yourcallyourrule/core/entities/regex/regex_pattern.dart';

import 'package:yourcallyourrule/core/provider/providers/regex_service_provider.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/rules/services/regex_service.dart';

import 'package:yourcallyourrule/generated/app_localizations.dart';

// 重构后的正则测试页面
class RegexTestPage extends ConsumerStatefulWidget {
  const RegexTestPage({super.key});

  @override
  RegexTestPageState createState() => RegexTestPageState();
}

class RegexTestPageState extends ConsumerState<RegexTestPage> {
  final _phoneNumberController = TextEditingController();
  final _regexController = TextEditingController();
  final _ruleNameController = TextEditingController();
  String _resultMessage = '';

  void _testRegex() {
    setState(() {
      String phoneNumber = _phoneNumberController.text;
      String regexPattern = _regexController.text;

      if (phoneNumber.isEmpty || regexPattern.isEmpty) {
        _resultMessage = AppLocalizations.of(context)!.enterBothPhoneNumberAndRegexPatternMessage;
        return;
      }

      try {
        RegExp regExp = RegExp(regexPattern);
        _resultMessage = regExp.hasMatch(phoneNumber) 
            ? AppLocalizations.of(context)!.matchSuccessfulMessage 
            : AppLocalizations.of(context)!.matchFailedMessage;
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.regexErrorMessage(e)),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
  }

  void _saveRegexRule() {
    final ruleName = _ruleNameController.text;
    final regexPattern = _regexController.text;

    if (ruleName.isEmpty || regexPattern.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.enterRuleNameAndPatternMessage)),
      );
      return;
    }

    try {
      final service = ref.read(regexServiceProvider);
      service.addRegexRule(RegExPattern(
        name: ruleName,
        pattern: regexPattern,
        action: RuleAction.block, // 默认动作
      ));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.ruleSavedSuccessMessage)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.saveFailed(e))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF5),
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.regexTesterTitle,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 20, color: Colors.black87),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        foregroundColor: Colors.black87,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: Colors.black87),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(18),
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
                  TextField(
                    controller: _phoneNumberController,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.phoneNumberLabel,
                      labelStyle: TextStyle(fontSize: 13, color: Colors.grey[700], fontWeight: FontWeight.w600),
                      hintText: AppLocalizations.of(context)!.enterPhoneNumberHint,
                      hintStyle: const TextStyle(fontSize: 13, color: Colors.black26),
                      prefixIcon: const Icon(Icons.phone_rounded, color: Color(0xFFFF9500), size: 20),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: Color(0xFFEDE8DF), width: 1.1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: Color(0xFFFF9500), width: 1.5),
                      ),
                      filled: true,
                      fillColor: const Color(0xFFF7F5F0),
                      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 14),
                  TextField(
                    controller: _regexController,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.regexPatternLabel,
                      labelStyle: TextStyle(fontSize: 13, color: Colors.grey[700], fontWeight: FontWeight.w600),
                      hintText: AppLocalizations.of(context)!.enterRegexHint,
                      hintStyle: const TextStyle(fontSize: 13, color: Colors.black26),
                      prefixIcon: const Icon(Icons.code_rounded, color: Color(0xFF6C5CE7), size: 20),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: Color(0xFFEDE8DF), width: 1.1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: Color(0xFF6C5CE7), width: 1.5),
                      ),
                      filled: true,
                      fillColor: const Color(0xFFF7F5F0),
                      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                    ),
                  ),
                  const SizedBox(height: 14),
                  TextField(
                    controller: _ruleNameController,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.ruleNameLabel,
                      labelStyle: TextStyle(fontSize: 13, color: Colors.grey[700], fontWeight: FontWeight.w600),
                      hintText: AppLocalizations.of(context)!.enterRuleNameHint,
                      hintStyle: const TextStyle(fontSize: 13, color: Colors.black26),
                      prefixIcon: const Icon(Icons.label_rounded, color: Color(0xFF34C759), size: 20),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: Color(0xFFEDE8DF), width: 1.1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: Color(0xFF34C759), width: 1.5),
                      ),
                      filled: true,
                      fillColor: const Color(0xFFF7F5F0),
                      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _testRegex,
                          icon: const Icon(Icons.play_arrow_rounded, size: 18),
                          label: Text(AppLocalizations.of(context)!.testButton),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFF9500),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                            padding: const EdgeInsets.symmetric(vertical: 13),
                            elevation: 0,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _saveRegexRule,
                          icon: const Icon(Icons.save_rounded, size: 18),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF34C759),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                            padding: const EdgeInsets.symmetric(vertical: 13),
                            elevation: 0,
                          ),
                          label: Text(AppLocalizations.of(context)!.saveButtonText),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (_resultMessage.isNotEmpty) ...[
              const SizedBox(height: 14),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: _resultMessage.contains('successful')
                      ? const Color(0xFF34C759).withValues(alpha: 0.12)
                      : const Color(0xFFFF4B4B).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: _resultMessage.contains('successful')
                        ? const Color(0xFF34C759)
                        : const Color(0xFFFF4B4B),
                    width: 1.1,
                  ),
                ),
                child: Text(
                  _resultMessage,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: _resultMessage.contains('successful')
                        ? const Color(0xFF2E7D32)
                        : const Color(0xFFD32F2F),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
            const SizedBox(height: 14),
            const Align(
              alignment: Alignment.center,
              child: GoogleAdWidget(adInfo: AdManager.adaptiveBannerAd),
            ),
            const SizedBox(height: 14),
            Align(
              alignment: Alignment.center,
              child: nativeAdWidgetMedium(adWidth: 320, adHeight: 150),
            ),
          ],
        ),
      ),
    );
  }
}