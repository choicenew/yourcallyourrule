import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:pyro_ads_hub/pyro_ads_hub.dart';
import 'package:yourcallyourrule/features/sms/domain/sms_subscription.dart';
import 'package:yourcallyourrule/features/sms/services/sms_subscription_service.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/features/common/widgets/generic_list_with_ads_page.dart';

/// 短信规则订阅页面 - 完整 WithAds 实现
class SmsSubscriptionPageWithAds extends ConsumerStatefulWidget {
  const SmsSubscriptionPageWithAds({super.key});

  @override
  ConsumerState<SmsSubscriptionPageWithAds> createState() => _SmsSubscriptionPageWithAdsState();
}

class _SmsSubscriptionPageWithAdsState extends ConsumerState<SmsSubscriptionPageWithAds> {
  bool _isLoading = true;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();
  List<SmsSubscription> _subscriptions = [];

  @override
  void initState() {
    super.initState();
    _loadSubscriptions();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _urlController.dispose();
    super.dispose();
  }

  Future<void> _loadSubscriptions() async {
    if (!mounted) return;
    setState(() {
      _isLoading = true;
    });

    try {
      final service = ref.read(smsSubscriptionServiceProvider);
      final subscriptions = await service.getAll();
      if (mounted) {
        setState(() {
          _subscriptions = subscriptions;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${AppLocalizations.of(context).loadSubscriptionsFailed}: $e')),
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
      await _loadSubscriptions();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${AppLocalizations.of(context).changeSubscriptionStatusFailed}: $e')),
        );
      }
    }
  }

  Future<void> _updateSubscription(SmsSubscription subscription) async {
    if (!mounted) return;
    setState(() {
      _isLoading = true;
    });

    try {
      final service = ref.read(smsSubscriptionServiceProvider);
      await service.updateRulesFromSubscription(subscription);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context).subscriptionUpdateSuccess)),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context).updateSubscriptionFailed(e.toString()))),
        );
      }
    } finally {
      await _loadSubscriptions();
    }
  }

  Future<void> _deleteSubscription(SmsSubscription subscription) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context).deleteSubscription),
        content: Text(AppLocalizations.of(context).confirmDeleteSubscriptions(subscription.name)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(AppLocalizations.of(context).cancelButton),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(AppLocalizations.of(context).deleteButton),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        final service = ref.read(smsSubscriptionServiceProvider);
        await service.deleteSubscription(subscription.id);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppLocalizations.of(context).subscriptionDeleted)),
          );
          await _loadSubscriptions();
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${AppLocalizations.of(context).deleteSubscriptionFailed}: $e')),
          );
        }
      }
    }
  }

  void _showAddDialog() {
    _nameController.clear();
    _urlController.clear();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(AppLocalizations.of(dialogContext).addSmsSubscription),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(dialogContext).subscriptionName,
                hintText: AppLocalizations.of(dialogContext).enterSubscriptionName,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _urlController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(dialogContext).subscriptionUrl,
                hintText: AppLocalizations.of(dialogContext).enterSubscriptionUrl,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(AppLocalizations.of(dialogContext).cancelButton),
          ),
          TextButton(
            onPressed: () async {
              final name = _nameController.text.trim();
              final url = _urlController.text.trim();
              
              if (name.isEmpty || url.isEmpty) {
                ScaffoldMessenger.of(dialogContext).showSnackBar(
                  SnackBar(content: Text(AppLocalizations.of(dialogContext).enterValidNameAndUrl)),
                );
                return;
              }

              try {
                final service = ref.read(smsSubscriptionServiceProvider);
                final subscription = SmsSubscription(
                  id: const Uuid().v4(),
                  name: name,
                  url: url,
                  isEnabled: true,
                  lastUpdated: DateTime.now(),
                );
                
                await service.save(subscription);
                if (dialogContext.mounted) {
                  ScaffoldMessenger.of(dialogContext).showSnackBar(
                    SnackBar(content: Text(AppLocalizations.of(dialogContext).smsSubscriptionAddedSuccessfully)),
                  );
                  Navigator.of(dialogContext).pop();
                }
                await _loadSubscriptions();
              } catch (e) {
                if (dialogContext.mounted) {
                  ScaffoldMessenger.of(dialogContext).showSnackBar(
                    SnackBar(content: Text('${AppLocalizations.of(dialogContext).addSubscriptionFailed}: $e')),
                  );
                }
              }
            },
            child: Text(AppLocalizations.of(dialogContext).add),
          ),
        ],
      ),
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
                  AppLocalizations.of(context).aboutSmsSubscriptionRules,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF2D9CDB),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  AppLocalizations.of(context).smsSubscriptionRulesDescription,
                  style: TextStyle(
                    fontSize: 12.5,
                    color: Theme.of(context).colorScheme.onSurface,
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

  Widget _buildSubscriptionCard(SmsSubscription subscription) {
    final lastUpdated = subscription.lastUpdated ?? DateTime.now();
    final formattedDate = '${lastUpdated.year}-${lastUpdated.month.toString().padLeft(2, '0')}-${lastUpdated.day.toString().padLeft(2, '0')} ${lastUpdated.hour.toString().padLeft(2, '0')}:${lastUpdated.minute.toString().padLeft(2, '0')}';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).colorScheme.outlineVariant,
          width: 1.1,
        ),
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
                    Row(
                      children: [
                        Text(
                          subscription.name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFF34C759).withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            AppLocalizations.of(context).allowRule,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF34C759),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subscription.url,
                      style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF9500).withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            AppLocalizations.of(context).pendingSync,
                            style: const TextStyle(fontSize: 11, color: Color(0xFFFF9500), fontWeight: FontWeight.w700),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${AppLocalizations.of(context).lastUpdated}: $formattedDate',
                          style: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.7)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Switch(
                value: subscription.isEnabled,
                onChanged: (value) => _toggleSubscriptionStatus(subscription, value),
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
                  label: Text(AppLocalizations.of(context).syncNow, style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800)),
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
                label: Text(AppLocalizations.of(context).deleteButton, style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800)),
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

  @override
  Widget build(BuildContext context) {
    return GenericListWithAdsPage<SmsSubscription>(
      title: AppLocalizations.of(context).smsSubscription,
      items: _subscriptions,
      itemBuilder: (context, subscription) => _buildSubscriptionCard(subscription),
      adBuilder: () => const AdsInlineBanner(),
      adInterval: 3,
      emptyText: AppLocalizations.of(context).noSubscriptions,
      emptyIcon: Icons.sms_outlined,
      themeColor: Theme.of(context).primaryColor,
      isLoading: _isLoading,
      onRefresh: _loadSubscriptions,
      onAdd: _showAddDialog,
      headerContent: _buildInfoCard(),
    );
  }
}

/// 保持向下兼容的真实继承类（零 typedef）
class SmsSubscriptionPage extends SmsSubscriptionPageWithAds {
  const SmsSubscriptionPage({super.key});
}
