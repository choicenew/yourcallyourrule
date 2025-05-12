import 'package:flutter/material.dart';

// ... RegexPatternHint Widget ...

class RegexPatternExplanationButton extends StatelessWidget {
  const RegexPatternExplanationButton({super.key});

  void _showRegexPatternExplanationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Regex Pattern Explanation",
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
              child: const Text("Close"),
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
                'Regex Pattern Explanation',
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
          "Regular expressions for phone number matching:",
          "Use standard regex syntax to define patterns. Examples:",
        ),
        const SizedBox(height: 10),
        _buildHintItem(
          context,
          "Block international calls:",
          "Use '^\\+' to match numbers starting with international prefix",
        ),
        _buildHintItem(
          context,
          "Block specific area codes:",
          "Pattern '^0[0-9]{2,3}' matches numbers starting with 0 + 2-3 digits",
        ),
        _buildHintItem(
          context,
          "Match specific digit patterns:",
          "Pattern '[0-9]{3}-[0-9]{4}-[0-9]{4}' matches XXX-XXXX-XXXX format",
        ),
        _buildHintItem(
          context,
          "Match numbers with special characters:",
          "Pattern '^170 [0-9]{3} 656 [0-9]{2}\$' matches specific number format",
        ),
        _buildHintItem(
          context,
          "Wildcard matching:",
          "Use '.' to match any character (e.g. '123.456' matches 123-456)",
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
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color:
                              Theme.of(context).colorScheme.onSurfaceVariant),
                    ),
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
