import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_purchase_ui/pyro_purchase_ui.dart';
import 'package:yourcallyourrule/features/commercial/services/purchase_service.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class PurchasePage extends ConsumerWidget {
  const PurchasePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.aboutTitle)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.star_rounded, size: 64, color: Colors.amber),
            const SizedBox(height: 16),
            Text(
              l10n.aboutSubtitle,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => ref.read(purchaseServiceProvider).restorePurchases(),
              child: Text(l10n.action),
            ),
          ],
        ),
      ),
    );
  }
}
