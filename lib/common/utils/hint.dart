import 'package:flutter/material.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

// ... RegexPatternHint Widget ...

class RegexPatternExplanationButton extends StatelessWidget {
  const RegexPatternExplanationButton({super.key});

  void _showRegexPatternExplanationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            AppLocalizations.of(context)!.regexPatternExplanation,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.w600),
          ),
          backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
          content: const SingleChildScrollView(
            child: RegexPatternHint(),
          ),
          actions: [
            FilledButton.tonal(
              onPressed: () => Navigator.pop(context),
              style: FilledButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).colorScheme.surfaceContainerHighest,
                  foregroundColor: Theme.of(context).colorScheme.onSurface,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12)),
              child: Text(AppLocalizations.of(context)!.close),
            ),
          ],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
          style: FilledButton.styleFrom(
              backgroundColor:
                  Theme.of(context).colorScheme.surfaceContainerHighest,
              foregroundColor: Theme.of(context).colorScheme.onSurface,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.regexPatternExplanationButton,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600),
              ),
              Icon(
                Icons.help_rounded,
                size: 20,
                color: Theme.of(context).colorScheme.primary,
              )
            ],
          ),
        ));
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
          AppLocalizations.of(context)!.regexPatternsForPhoneNumberMatching,
          description: Text(
            AppLocalizations.of(context)!.useStandardRegexSyntaxToDefinePatternsExamples,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
        ),
        const SizedBox(height: 10),
        _buildHintItem(
          context,
          AppLocalizations.of(context)!.blockInternationalCallsTitle,
          description: Text(
            "'^(?!\\+|00)' ${AppLocalizations.of(context)!.blockInternationalCalls}",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
        ),
        _buildHintItem(
          context,
          AppLocalizations.of(context)!.blockPremiumRateNumbersTitle,
          description: Text(
            "'^(?!118|1[2-9]0)' ${AppLocalizations.of(context)!.blockPremiumRateNumbers}",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
        ),
        _buildHintItem(
          context,
          AppLocalizations.of(context)!.blockMobileNumbersTitle,
          description: Text(
            "'^(?!1[3-9])' ${AppLocalizations.of(context)!.blockMobileNumbers}",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
        ),










        _buildHintItem(
          context,
          AppLocalizations.of(context)!.blockSpecificAreaCodesTitle,
          description: Text(
            "'^0[0-9]{2,3}' ${AppLocalizations.of(context)!.blockSpecificAreaCodes}",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
        ),
        _buildHintItem(
          context,
          AppLocalizations.of(context)!.matchSpecificDigitPatternsTitle,
          description: Text(
            "'[0-9]{3}-[0-9]{4}-[0-9]{4}' ${AppLocalizations.of(context)!.matchSpecificDigitPatterns}",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
        ),
        _buildHintItem(
          context,
          AppLocalizations.of(context)!.matchNumbersWithSpecialCharactersTitle,
          description: Text(
            "'^170 [0-9]{3} 656 [0-9]{2}\$' ${AppLocalizations.of(context)!.matchNumbersWithSpecialCharacters}",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
        ),
        _buildHintItem(
          context,
          AppLocalizations.of(context)!.wildcardMatchingTitle,
          description: Text(
            AppLocalizations.of(context)!.wildcardMatchingDescription,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
        ),
      ],
    );
  }

  Widget _buildHintItem(BuildContext context, String title, {Widget? description}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.info_rounded,
                size: 18,
                color: Theme.of(context)
                    .dividerColor
                    .withAlpha((0.1 * 255).round()),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 4),
                    /*
                     Text(
                      description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color:
                              Theme.of(context).colorScheme.onSurfaceVariant),
                    ),
                    */
                    if (description != null) description,
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 8),
          Divider(
            height: 1,
            thickness: 0.5,
            color:
                Theme.of(context).dividerColor.withAlpha((0.1 * 255).round()),
          )
        ],
      ),
    );
  }
}
