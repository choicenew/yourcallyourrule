import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/adwidgets/native_ads.dart';
import 'package:yourcallyourrule/ads/google_ad.dart';
import 'package:yourcallyourrule/core/entities/regex/regex_pattern.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/rules/services/regex_service.dart';

// 重构后的正则测试页面
class RegexTestPage extends StatefulWidget {
  const RegexTestPage({super.key});

  @override
  RegexTestPageState createState() => RegexTestPageState();
}

class RegexTestPageState extends State<RegexTestPage> {
  final _phoneNumberController = TextEditingController();
  final _regexController = TextEditingController();
  final _ruleNameController = TextEditingController();
  String _resultMessage = '';

  void _testRegex() {
    setState(() {
      String phoneNumber = _phoneNumberController.text;
      String regexPattern = _regexController.text;

      if (phoneNumber.isEmpty || regexPattern.isEmpty) {
        _resultMessage = 'Please enter both phone number and regex pattern';
        return;
      }

      try {
        RegExp regExp = RegExp(regexPattern);
        _resultMessage = regExp.hasMatch(phoneNumber) 
            ? 'Match successful!' 
            : 'Match failed!';
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Regex error: $e'),
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
        const SnackBar(content: Text('Please enter rule name and pattern')),
      );
      return;
    }

    try {
      final service = Provider.of<RegexService>(context, listen: false);
      service.addRegexRule(RegExPattern(
        name: ruleName,
        pattern: regexPattern,
        action: RuleAction.block, // 默认动作
      ));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Rule saved successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Save failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Regex Tester')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _phoneNumberController,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                hintText: 'Enter phone number to test',
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _regexController,
              decoration: const InputDecoration(
                labelText: 'Regex Pattern',
                hintText: 'Enter regular expression',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _ruleNameController,
              decoration: const InputDecoration(
                labelText: 'Rule Name',
                hintText: 'Enter name for this rule',
              ),
            ),
            const SizedBox(height: 16),
            const Align(
              alignment: Alignment.center,
              child: GoogleAdWidget(adInfo: AdManager.adaptiveBannerAd),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _testRegex,
                    child: const Text('TEST'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _saveRegexRule,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text('SAVE'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              _resultMessage,
              style: TextStyle(
                fontSize: 18,
                color: _resultMessage.contains('successful')
                    ? Colors.green
                    : Colors.red,
              ),
            ),
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