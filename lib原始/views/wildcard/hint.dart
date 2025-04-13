import 'package:flutter/material.dart';

import '../../generated/l10n.dart';

// ... RegexPatternHint Widget ...

class RegexPatternExplanationButton extends StatelessWidget {
  const RegexPatternExplanationButton({super.key});

  void _showRegexPatternExplanationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            S.of(context).regexPatternExplanation,
          ),
          content: const SingleChildScrollView(
            child: RegexPatternHint(),
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
          onPressed: () => _showRegexPatternExplanationDialog(context),
          style: TextButton.styleFrom(
              //   padding: const EdgeInsets.only(left:0), // 去除默认 padding
              //   minimumSize: Size.zero, // 去除默认 minimumSize
              //  tapTargetSize: MaterialTapTargetSize.shrinkWrap, // 缩小点击区域
              ),
          child: Row(
            //mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment
                .spaceBetween, // 使用 MainAxisAlignment.spaceBetween
            children: [
              Text(
                S.of(context).regexPatternExplanation,
              ),
              const Icon(Icons.help_outline), // 将 Icon 放置在 Row 的末尾
            ],
          )),
    );
  }
}

class RegexPatternHint extends StatelessWidget {
  const RegexPatternHint({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHintItem(
          context,
          S
              .of(context)
              .regexPatternsAreRegularExpressionsUsedToMatchPhoneNumbers,
          S
              .of(context)
              .youCanUseStandardRegularExpressionSyntaxToDefinePatterns,
        ),
        const SizedBox(height: 10),
        _buildHintItem(
          context,
          S.of(context).blockInternationalCalls,
          S.of(context).useThePatternToMatchAllPhoneNumbersStartingWith,
        ),
        _buildHintItem(
          context,
          S.of(context).blockCallsFromSpecificAreaCodes,
          S.of(context).useThePattern0d23ToMatchPhoneNumbersStartingWith,
        ),
        _buildHintItem(
          context,
          S.of(context).matchPhoneNumbersContainingSpecificDigits,
          S.of(context).useThePatternD3d4d4ToMatchPhoneNumbersInThe,
        ),
        _buildHintItem(
          context,
          S.of(context).matchPhoneNumbersWithSpecificCharactersInTheMiddle,
          S.of(context).useThePatternD3d4d4ToMatchPhoneNumbersWithHyphens,
        ),
        _buildHintItem(
          context,
          S.of(context).matchAnyCharacter,
          S.of(context).useTheCharacterToMatchAnySingleCharacterforExampleThe,
        ),
      ],
    );
  }

  Widget _buildHintItem(
      BuildContext context, String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 5),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
