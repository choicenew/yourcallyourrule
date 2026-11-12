import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_ads_hub/pyro_ads_hub.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/features/common/widgets/generic_list_with_ads_page.dart';
import 'package:yourcallyourrule/features/sms/domain/sms_subscription.dart';
import 'package:yourcallyourrule/features/sms/services/sms_subscription_service.dart';

class SmsSubscriptionPageWithAds extends ConsumerStatefulWidget {
  const SmsSubscriptionPageWithAds({super.key});

  @override
  ConsumerState<SmsSubscriptionPageWithAds> createState() => _SmsSubscriptionPageWithAdsState();
}

class _SmsSubscriptionPageWithAdsState extends ConsumerState<SmsSubscriptionPageWithAds> {
  List<SmsSubscription> _subscriptions = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSubscriptions();
  }

  Future<void> _loadSubscriptions() async {
    setState(() => _isLoading = true);
    try {
      final service = ref.read(smsSubscriptionServiceProvider);
      final list = await service.getAll();
      if (mounted) {
        setState(() {
          _subscriptions = list;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${AppLocalizations.of(context)!.loadSubscriptionsFailed}: $e')),
        );
      }
    }
  }

  Future<void> _toggleSubscriptionStatus(SmsSubscription subscription, bool isEnabled) async {
    try {
      final service = ref.read(smsSubscriptionServiceProvider);
      if (isEnabled) {
        await service.enableSubscription(subscription);
      } else {
        await service.disableSubscription(subscription);
      }
      _loadSubscriptions();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${AppLocalizations.of(context)!.updateSubscriptionFailed}: $e')),
        );
      }
    }
  }

  Future<void> _deleteSubscription(String id) async {
    try {
      final service = ref.read(smsSubscriptionServiceProvider);
      await service.deleteSubscription(id);
      _loadSubscriptions();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${AppLocalizations.of(context)!.deleteSubscriptionFailed}: $e')),
        );
      }
    }
  }

  void _showAddDialog() {
    final nameController = TextEditingController();
    final urlController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.addSubscription),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.subscriptionName,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: urlController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.subscriptionUrl,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.cancelButton),
          ),
          ElevatedButton(
            onPressed: () async {
              final name = nameController.text.trim();
              final url = urlController.text.trim();
              if (name.isNotEmpty && url.isNotEmpty) {
                final service = ref.read(smsSubscriptionServiceProvider);
                await service.addSubscription(name, url);
                if (mounted) {
                  Navigator.pop(context);
                  _loadSubscriptions();
                }
              }
            },
            child: Text(AppLocalizations.of(context)!.save),
          ),
        ],
      ),
    );
  }

  Widget _buildSubscriptionCard(SmsSubscription subscription) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        title: Text(subscription.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subscription.url, maxLines: 1, overflow: TextOverflow.ellipsis),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Switch(
              value: subscription.isEnabled,
              onChanged: (val) => _toggleSubscriptionStatus(subscription, val),
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              onPressed: () => _deleteSubscription(subscription.id),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GenericListWithAdsPage<SmsSubscription>(
      title: AppLocalizations.of(context)!.smsSubscriptionTitle,
      items: _subscriptions,
      itemBuilder: (context, subscription) => _buildSubscriptionCard(subscription),
      adBuilder: () => const AdsInlineBanner(),
      adInterval: 3,
      emptyText: AppLocalizations.of(context)!.noSubscriptions,
      emptyIcon: Icons.sms_outlined,
      themeColor: Theme.of(context).primaryColor,
      isLoading: _isLoading,
      onRefresh: _loadSubscriptions,
      onAdd: _showAddDialog,
    );
  }
}
