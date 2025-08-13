import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/purchase/purchase_state.dart';

class VipPromotionCard extends ConsumerWidget {
  const VipPromotionCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isVip = ref.watch(purchaseStateProvider.select((state) => state.isPurchasesEnabled));

    if (isVip) {
      return const SizedBox.shrink(); // Don't show if user is VIP
    }

    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          gradient: LinearGradient(
            colors: [Colors.purple.shade500, Colors.deepPurple.shade700],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.upgradeToVip,
                    style: const TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black26,
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.workspace_premium,
                    color: Colors.amber,
                    size: 40.0,
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Text(
                AppLocalizations.of(context)!.monthlyMembershipDescription, // Using existing localization
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
              const SizedBox(height: 20.0),
              _buildFeatureRow(context, Icons.block, AppLocalizations.of(context)!.noAds),
              const SizedBox(height: 12.0),
              _buildFeatureRow(context, Icons.cloud_sync, AppLocalizations.of(context)!.cloudBackup),
              const SizedBox(height: 20.0),
              Center(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.deepPurple.shade700,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    elevation: 5,
                  ),
                  onPressed: () {
                    context.goNamed('purchase');
                  },
                  icon: const Icon(Icons.arrow_forward),
                  label: Text(
                    AppLocalizations.of(context)!.purchase, // Using existing localization
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureRow(BuildContext context, IconData icon, String feature) {
    return Row(
      children: [
        Icon(icon, color: Colors.white, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            feature,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ],
    );
  }
}