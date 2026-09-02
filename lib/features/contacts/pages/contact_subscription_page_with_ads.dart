import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/subscription/contact_subscription.dart';
import 'package:yourcallyourrule/core/value_objects/url.dart';
import 'package:yourcallyourrule/features/contacts/provider/contact_subscription_service_provider.dart';
import 'package:yourcallyourrule/features/contacts/services/contact_subscription_service.dart';
import 'package:yourcallyourrule/features/common/widgets/generic_list_with_ads_page.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/ads/ad_control_service.dart';
import 'package:yourcallyourrule/ads/google_ad.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/features/home_elite/theme/elite_dopamine_theme.dart';

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
  String _searchKeyword = '';

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

      final filteredSubscriptions = subscriptions.where((sub) {
        if (_searchKeyword.isNotEmpty) {
          final searchLower = _searchKeyword.toLowerCase();
          final nameMatch = sub.name.toLowerCase().contains(searchLower);
          final urlMatch = sub.url.toString().toLowerCase().contains(searchLower);
          return nameMatch || urlMatch;
        }
        return true;
      }).toList();

      setState(() {
        _subscriptions = filteredSubscriptions;
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
            child: Text(AppLocalizations.of(context)!.cancelButton),
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

  void _onSearchChanged(String keyword) {
    setState(() {
      _searchKeyword = keyword;
    });
    _loadSubscriptions();
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
            child: Text(AppLocalizations.of(context)!.cancelButton),
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
      adBuilder: () => GoogleAdWidget(adInfo: AdManager.adaptiveBannerAd),
    
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
      // headerContent: _buildInfoCard(),
      onSearchChanged: _onSearchChanged,
      searchHintText: AppLocalizations.of(context)!.searchContactSubscriptionsHint,
      infoCard: _buildInfoCard(),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF2D9CDB).withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: const Color(0xFF2D9CDB).withValues(alpha: 0.15),
          width: 1.1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: const Color(0xFF2D9CDB).withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: const Icon(
              Icons.info_outline_rounded,
              color: Color(0xFF2D9CDB),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.aboutContactSubscription,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF2D9CDB),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  AppLocalizations.of(context)!.contactSubscriptionDescription,
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: Colors.black87,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubscriptionCard(ContactSubscription subscription) {
    final lastUpdated = subscription.lastUpdated;
    final formattedDate = '${lastUpdated.year}-${lastUpdated.month.toString().padLeft(2, '0')}-${lastUpdated.day.toString().padLeft(2, '0')} ${lastUpdated.hour.toString().padLeft(2, '0')}:${lastUpdated.minute.toString().padLeft(2, '0')}';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16.0),
      decoration: EliteDopamineTheme.warmCardDecoration(
        context: context,
        borderRadius: BorderRadius.circular(20),
      ),
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
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.black87),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subscription.url.toString(),
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFF34C759).withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.synchronized,
                            style: const TextStyle(fontSize: 11, color: Color(0xFF34C759), fontWeight: FontWeight.w700),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${AppLocalizations.of(context)!.lastUpdated}: $formattedDate',
                          style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Switch(
                value: subscription.isEnabled,
                onChanged: (value) => _toggleSubscriptionStatus(subscription),
                activeThumbColor: const Color(0xFF2D9CDB),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.sync_rounded, size: 16),
                  label: Text(AppLocalizations.of(context)!.syncNow, style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2D9CDB),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () => _updateSubscription(subscription),
                ),
              ),
              const SizedBox(width: 8),
              OutlinedButton.icon(
                icon: const Icon(Icons.delete_outline_rounded, size: 16),
                label: Text(AppLocalizations.of(context)!.deleteButton, style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800)),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.redAccent,
                  side: const BorderSide(color: Colors.redAccent, width: 1.1),
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => _deleteSubscription(subscription),
              ),
            ],
          ),
        ],
      ),
    );
  }
}