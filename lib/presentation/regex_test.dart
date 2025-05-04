import 'package:flutter/material.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/adwidgets/native_ads.dart';
import 'package:yourcallyourrule/ads/google_ad.dart';

import '../../generated/l10n.dart';




// 假设这是你的 RegexTestPage
class RegexTestPage extends StatefulWidget {
  const RegexTestPage({super.key});

  @override
  RegexTestPageState createState() => RegexTestPageState();
}

class RegexTestPageState extends State<RegexTestPage> {
  final _phoneNumberController = TextEditingController();
  final _regexController = TextEditingController();
  String _resultMessage = '';

  void _testRegex() {
    setState(() {
      String phoneNumber = _phoneNumberController.text;
      String regexPattern = _regexController.text;

      if (phoneNumber.isEmpty || regexPattern.isEmpty) {
        _resultMessage = S.of(context).pleaseEnterAPhoneNumberAndRegexPattern;
        return;
      }

      try {
        RegExp regExp = RegExp(regexPattern);
        if (regExp.hasMatch(phoneNumber)) {
          _resultMessage = S.of(context).matchSuccessful;
        } else {
          _resultMessage = S.of(context).matchFailed;
        }
      } catch (e) {
        // Show the error message using a Snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Regex pattern error: $e'),
            backgroundColor:
                Colors.red, // Optional: Customize the background color
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).regexPhoneNumberTest),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _phoneNumberController,
              decoration: InputDecoration(
                labelText: S.of(context).phonenumber,
                hintText: S.of(context).pleaseEnterAPhoneNumber,
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _regexController,
              decoration: InputDecoration(
                labelText: S.of(context).regexPattern,
                hintText: S.of(context).pleaseEnterARegexPattern,
              ),
            ),
            const SizedBox(height: 16),
            // 广告 - Centered with Align
            const Align(
              alignment: Alignment.center,
              child: GoogleAdWidget(adInfo: AdManager.adaptiveBannerAd),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _testRegex,
              child: Text(S.of(context).test),
            ),
            const SizedBox(height: 16),
            Text(
              _resultMessage,
              style: TextStyle(
                fontSize: 18,
                color: _resultMessage.contains(S.of(context).successful)
                    ? Colors.green
                    : _resultMessage.contains(S.of(context).failed)
                        ? Colors.red
                        : Colors.black,
              ),
            ),
            //广告代码 - Centered with Align
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

// 这是你的 RegexPatternTestButton
class RegexPatternTestButton extends StatelessWidget {
  const RegexPatternTestButton({super.key});

  void _showRegexTestPageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // title: Text('Regex 电话号码测试'), // 可以选择是否添加标题
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8, // 设置弹窗宽度
            height: MediaQuery.of(context).size.height * 0.6, // 设置弹窗高度
            child: const RegexTestPage(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                S.of(context).close,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0),
      child: TextButton(
        onPressed: () => _showRegexTestPageDialog(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              S
                  .of(context)
                  .regexPatternTest, // 假设你有 S.of(context).regexPatternExplanation 用于国际化
            ),
            const Icon(Icons.help_outline),
          ],
        ),
      ),
    );
  }
}
