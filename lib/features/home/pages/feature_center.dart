import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class FeatureCenter extends StatelessWidget {
  const FeatureCenter({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.featureCenter,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                _buildFeatureItem(
                  context: context,
                  title: AppLocalizations.of(context)!.labelManagement,
                  icon: Icons.label,
                  onTap: () => context.push('/label-management'),
                ),
                _buildFeatureItem(
                  context: context,
                  title: AppLocalizations.of(context)!.pluginManagement,
                  icon: Icons.extension,
                  onTap: () => context.push('/plugin-management'),
                ),
                _buildFeatureItem(
                  context: context,
                  title: AppLocalizations.of(context)!.allowBlock,
                  icon: Icons.block,
                  onTap: () => context.push('/allowed-blocked-settings'),
                ),
                _buildFeatureItem(
                  context: context,
                  title: AppLocalizations.of(context)!.blackWhiteList,
                  icon: Icons.list,
                  onTap: () => context.push('/rule-management-settings'),
                ),
                _buildFeatureItem(
                  context: context,
                  title: AppLocalizations.of(context)!.regexRules,
                  icon: Icons.code,
                  onTap: () => context.push('/regex-rule'),
                ),
                _buildFeatureItem(
                  context: context,
                  title: AppLocalizations.of(context)!.phoneSubscription,
                  icon: Icons.phone_callback,
                  onTap: () => context.push('/phone-subscription'),
                ),
/*
                _buildFeatureItem(
                  context: context,
                  title: AppLocalizations.of(context)!.smsSubscription,
                  icon: Icons.sms,
                  onTap: () => context.push('/sms-subscription'),
                ),
                _buildFeatureItem(
                  context: context,
                  title: AppLocalizations.of(context)!.smsManagement,
                  icon: Icons.message,
                  onTap: () => context.push('/sms-management'),
                ),
                */
                _buildFeatureItem(
                  context: context,
                  title: AppLocalizations.of(context)!.callHistory,
                  icon: Icons.call,
                  onTap: () => context.push('/call-history'),
                ),
                _buildFeatureItem(
                  context: context,
                  title: AppLocalizations.of(context)!.contacts,
                  icon: Icons.contacts,
                  onTap: () => context.push('/contacts-management'),
                ),
                _buildFeatureItem(
                  context: context,
                  title: AppLocalizations.of(context)!.statistics,
                  icon: Icons.bar_chart,
                  onTap: () => context.push('/call-statistics'),
                ),
/*
                _buildFeatureItem(
                  context: context,
                  title: AppLocalizations.of(context)!.settings,
                  icon: Icons.settings,
                  onTap: () => context.push('/settings'),
                ),
                */
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem({
    required BuildContext context,
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: Color((Random().nextDouble() * 0xFFFFFF).toInt()).withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: Theme.of(context).primaryColor),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}