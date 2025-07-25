import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/subscription/contact_subscription.dart';
import 'package:yourcallyourrule/core/value_objects/url.dart';
import 'package:yourcallyourrule/features/contacts/di/contact_subscription_service_provider.dart';
import 'package:yourcallyourrule/features/contacts/services/contact_subscription_service.dart';
import 'package:yourcallyourrule/features/common/widgets/generic_list_with_ads_page.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/ads/ad_control_service.dart';

/// 联系人订阅页面 - 集成广告功能
/// 使用GenericListWithAdsPage组件减少重复代码并集成广告
class ContactSubscriptionPageWithAds extends ConsumerStatefulWidget {
  const ContactSubscriptionPageWithAds({super.key});

  @override
  ConsumerState<ContactSubscriptionPageWithAds> createState() => _ContactSubscriptionPageWithAdsState();
}

class _ContactSubscriptionPageWithAdsState extends ConsumerState<ContactSubscriptionPageWithAds> {
  List<ContactSubscription> _subscriptions = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSubscriptions();
  }

  Future<void> _loadSubscriptions() async {
    setState(() {
      _isLoading = true;
    });

    final subscriptionService = ref.read(contactSubscriptionServiceProvider);
    try {
      final subscriptions = await subscriptionService.getAll();
      setState(() {
        _subscriptions = subscriptions;
        _isLoading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.loadSubscriptionsFailed(e.toString()))),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _toggleSubscriptionStatus(ContactSubscription subscription) async {
    final subscriptionService = ref.read(contactSubscriptionServiceProvider);
    try {
      if (subscription.isEnabled) {
        await subscriptionService.disableSubscription(subscription);
      } else {
        await subscriptionService.enableSubscription(subscription);
      }
      await _loadSubscriptions();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.changeSubscriptionStatusFailed(e.toString()))),
      );
    }
  }

  Future<void> _updateSubscription(ContactSubscription subscription) async {
    setState(() {
      _isLoading = true;
    });

    final subscriptionService = ref.read(contactSubscriptionServiceProvider);
    try {
      final updatedRules = await subscriptionService.updateRulesFromSubscription(subscription);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.updateSuccess('Contact', updatedRules.length))),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.updateSubscriptionFailed(e.toString()))),
      );
    } finally {
      await _loadSubscriptions();
    }
  }

  Future<void> _deleteSubscription(ContactSubscription subscription) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.deleteSubscription),
        content: Text(AppLocalizations.of(context)!.deleteSubscriptionConfirm(subscription.name)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(AppLocalizations.of(context)!.deleteButton),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final subscriptionService = ref.read(contactSubscriptionServiceProvider);
      try {
        await subscriptionService.deleteSubscription(subscription.id);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.subscriptionDeleted)),
        );
        await _loadSubscriptions();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.deleteSubscriptionFailed(e.toString()))),
        );
      }
    }
  }

  void _showAddSubscriptionDialog() {
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
                hintText: AppLocalizations.of(context)!.enterSubscriptionName,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: urlController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.subscriptionUrl,
                hintText: AppLocalizations.of(context)!.enterSubscriptionUrl,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          TextButton(
            onPressed: () async {
              final name = nameController.text.trim();
              final url = urlController.text.trim();
              
              if (name.isEmpty || url.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(AppLocalizations.of(context)!.enterValidNameAndUrl)),
                );
                return;
              }

              final subscriptionService = ref.read(contactSubscriptionServiceProvider);
              try {
                await subscriptionService.addSubscription(name, url);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(AppLocalizations.of(context)!.subscriptionAddSuccess(name))),
                );
                Navigator.of(context).pop();
                await _loadSubscriptions();
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(AppLocalizations.of(context)!.addSubscriptionFailed(e.toString()))),
                );
              }
            },
            child: Text(AppLocalizations.of(context)!.add),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GenericListWithAdsPage<ContactSubscription>(
      title: AppLocalizations.of(context)!.serviceTypeContact,
      items: _subscriptions,
      itemBuilder: (context, subscription) => _buildSubscriptionCard(subscription),
      adBuilder: () => const Card(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('广告位', textAlign: TextAlign.center),
        ),
      ),
      adInterval: 3,
      emptyText: AppLocalizations.of(context)!.noSubscriptions,
      emptyIcon: Icons.contacts_outlined,
      emptyActionButton: ElevatedButton.icon(
        icon: const Icon(Icons.add),
        label: Text(AppLocalizations.of(context)!.addSubscription),
        onPressed: _showAddSubscriptionDialog,
      ),
      themeColor: Theme.of(context).primaryColor,
      isLoading: _isLoading,
      onRefresh: _loadSubscriptions,
      onAdd: _showAddSubscriptionDialog,
      headerContent: _buildInfoCard(),
    );
  }

  Widget _buildInfoCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const Icon(Icons.info_outline, color: Colors.blue, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.aboutContactSubscription,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    AppLocalizations.of(context)!.contactSubscriptionDescription,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubscriptionCard(ContactSubscription subscription) {
    final lastUpdated = subscription.lastUpdated;
    final formattedDate = '${lastUpdated.year}-${lastUpdated.month.toString().padLeft(2, '0')}-${lastUpdated.day.toString().padLeft(2, '0')} ${lastUpdated.hour.toString().padLeft(2, '0')}:${lastUpdated.minute.toString().padLeft(2, '0')}';

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        subscription.name,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subscription.url.toString(),
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.synchronized,
                              style: const TextStyle(fontSize: 12, color: Colors.green),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${AppLocalizations.of(context)!.lastUpdated}: $formattedDate',
                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: subscription.isEnabled,
                  onChanged: (value) => _toggleSubscriptionStatus(subscription),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.sync),
                    label: Text(AppLocalizations.of(context)!.syncNow),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () => _updateSubscription(subscription),
                  ),
                ),
                const SizedBox(width: 8),
                OutlinedButton.icon(
                  icon: const Icon(Icons.delete),
                  label: Text(AppLocalizations.of(context)!.deleteButton),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () => _deleteSubscription(subscription),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}