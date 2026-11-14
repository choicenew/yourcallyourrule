import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class VipExchangePage extends ConsumerWidget {
  const VipExchangePage({super.key});

  static const List<Map<String, dynamic>> _tiers = [
    {'marks': 1, 'days': 3, 'noAds': false, 'title': '3 Days VIP (With Ads & Sync)'},
    {'marks': 2, 'days': 3, 'noAds': true, 'title': '3 Days Ad-Free Full VIP'},
    {'marks': 5, 'days': 7, 'noAds': true, 'title': '7 Days Ad-Free Full VIP'},
    {'marks': 10, 'days': 15, 'noAds': true, 'title': '15 Days Ad-Free Full VIP'},
    {'marks': 20, 'days': 30, 'noAds': true, 'title': '30 Days Ad-Free Full VIP'},
  ];

  void _executeExchange(BuildContext context, Map<String, dynamic> tier) {
    final days = tier['days'] as int;
    final expiry = DateTime.now().add(Duration(days: days));
    final expiryStr = '${expiry.year}-${expiry.month.toString().padLeft(2, '0')}-${expiry.day.toString().padLeft(2, '0')}';
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Successfully exchanged ${tier['title']}! Expiry: $expiryStr')),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Community Mark VIP Exchange')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _tiers.length,
        itemBuilder: (context, index) {
          final tier = _tiers[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12.0),
            child: ListTile(
              leading: const Icon(Icons.stars, color: Colors.amber),
              title: Text(tier['title'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Required Marks: ${tier['marks']}'),
              trailing: ElevatedButton(
                onPressed: () => _executeExchange(context, tier),
                child: Text(l10n.action),
              ),
            ),
          );
        },
      ),
    );
  }
}
