import 'package:flutter/material.dart';

/// Modal bottom sheet displaying recent held outbound call logs.
class HeldCallLogSheet extends StatelessWidget {
  const HeldCallLogSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: theme.colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Held Outbound Calls',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Calls held due to callback scam or premium rate rules.',
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: theme.colorScheme.errorContainer,
              child: Icon(Icons.phone_disabled_rounded, color: theme.colorScheme.error),
            ),
            title: const Text('+1 (888) 555-0199'),
            subtitle: const Text('Wangiri Callback Scam • 3 mins ago'),
            trailing: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Call Anyway'),
            ),
          ),
        ],
      ),
    );
  }
}
