import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/core/entities/sms/sms_subscription.dart';
import 'package:yourcallyourrule/features/sms/providers/sms_subscription_service_provider.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/core/value_objects/url.dart';
import 'package:yourcallyourrule/features/common/widgets/generic_list_with_ads_page.dart';
import 'package:yourcallyourrule/features/sms/services/sms_subscription_service.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/ads/ad_control_service.dart';
import 'package:yourcallyourrule/features/home_elite/theme/elite_dopamine_theme.dart';

/// 短信订阅页面 - 集成广告功能
/// 使用GenericListWithAdsPage组件减少重复代码并集成广告
class SmsSubscriptionPageWithAds extends ConsumerStatefulWidget {
  const SmsSubscriptionPageWithAds({super.key});

  @override
  ConsumerState<SmsSubscriptionPageWithAds> createState() => _SmsSubscriptionPageWithAdsState();
}

class _SmsSubscriptionPageWithAdsState extends ConsumerState<SmsSubscriptionPageWithAds> {
  bool _isLoading = true;
  final TextEditingController _nameController = TextEditingController();
  List<SmsSubscription> _subscriptions = [];
  final TextEditingController _urlController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _urlController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadSubscriptions();
  }

  Future<void> _loadSubscriptions() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final service = ref.read(smsSubscriptionServiceProvider);
      final subscriptions = await service.getAll();
      setState(() {
        _subscriptions = subscriptions;
        _isLoading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${AppLocalizations.of(context)!.loadSubscriptionsFailed}: $e')),
      );
      setState(() {
        _isLoading = false;
      });
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${AppLocalizations.of(context)!.changeSubscriptionStatusFailed}: $e')),
      );
    }
  }

  Future<void> _updateSubscription(SmsSubscription subscription) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final service = ref.read(smsSubscriptionServiceProvider);
      await service.updateRulesFromSubscription(subscription);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.subscriptionUpdateSuccess)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${AppLocalizations.of(context)!.updateSubscriptionFailed}: $e')),
      );
    } finally {
      await _loadSubscriptions();
    }
  }

  Future<void> _deleteSubscription(SmsSubscription subscription) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.deleteSubscription),
        content: Text(AppLocalizations.of(context)!.confirmDeleteSubscriptions(subscription.name)),
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
      try {
        final service = ref.read(smsSubscriptionServiceProvider);
        await service.deleteSubscription(subscription.id);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.subscriptionDeleted)),
        );
        await _loadSubscriptions();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${AppLocalizations.of(context)!.deleteSubscriptionFailed}: $e')),
        );
      }
    }
  }

  void _showAddDialog() {
    showMenu<String>(
      context: context,
      position: const RelativeRect.fromLTRB(100, 100, 0, 0),
      items: [
        PopupMenuItem<String>(
          value: 'add_block',
          child: Text(AppLocalizations.of(context)!.addBlockSubscription),
        ),
        PopupMenuItem<String>(
          value: 'add_allow',
          child: Text(AppLocalizations.of(context)!.addAllowSubscription),
        ),
      ],
    ).then((value) {
      if (value == 'add_block') {
        _showAddSubscriptionDialog(action: RuleAction.block);
      } else if (value == 'add_allow') {
        _showAddSubscriptionDialog(action: RuleAction.allow);
      }
    });
  }

  void _showAddSubscriptionDialog({RuleAction action = RuleAction.block}) {
    _nameController.clear();
    _urlController.clear();

    String dialogTitle;
    if (action == RuleAction.allow) {
      dialogTitle = AppLocalizations.of(context)!.addAllowSubscription;
    } else {
      dialogTitle = AppLocalizations.of(context)!.addBlockSubscription;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(dialogTitle),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.subscriptionName,
                hintText: AppLocalizations.of(context)!.enterSubscriptionName,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _urlController,
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
              final name = _nameController.text.trim();
              final url = _urlController.text.trim();
              
              if (name.isEmpty || url.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(AppLocalizations.of(context)!.enterValidNameAndUrl)),
                );
                return;
              }

              try {
                final service = ref.read(smsSubscriptionServiceProvider);
                final subscription = SmsSubscription(
                  id: const Uuid().v4(),
                  name: name,
                  url: Url(url),
                  isEnabled: true,
                  action: action,
                  lastUpdated: DateTime.now(),
                );
                
                await service.save(subscription);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(AppLocalizations.of(context)!.smsSubscriptionAddedSuccessfully)),
                );
                Navigator.of(context).pop();
                await _loadSubscriptions();
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${AppLocalizations.of(context)!.addSubscriptionFailed}: $e')),
                );
              }
            },
            child: Text(AppLocalizations.of(context)!.add),
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
                  AppLocalizations.of(context)!.aboutSmsSubscriptionRules,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF2D9CDB),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  AppLocalizations.of(context)!.smsSubscriptionRulesDescription,
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

  Widget _buildSubscriptionCard(SmsSubscription subscription) {
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
                    Row(
                      children: [
                        Text(
                          subscription.name,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.black87),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: subscription.action == RuleAction.allow
                                ? const Color(0xFF34C759).withValues(alpha: 0.12)
                                : Colors.redAccent.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            subscription.action == RuleAction.allow 
                              ? AppLocalizations.of(context)!.allowRule 
                              : AppLocalizations.of(context)!.blockRule,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: subscription.action == RuleAction.allow 
                                ? const Color(0xFF34C759) 
                                : Colors.redAccent,
                            ),
                          ),
                        ),
                      ],
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
                            color: const Color(0xFFFF9500).withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.pendingSync,
                            style: const TextStyle(fontSize: 11, color: Color(0xFFFF9500), fontWeight: FontWeight.w700),
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


  @override
  Widget build(BuildContext context) {
    return GenericListWithAdsPage<SmsSubscription>(
      title: AppLocalizations.of(context)!.smsRuleSubscription,
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
      emptyIcon: Icons.sms_outlined,
      themeColor: Theme.of(context).primaryColor,
      isLoading: _isLoading,
      onRefresh: _loadSubscriptions,
      onAdd: _showAddDialog,
      headerContent: _buildInfoCard(),
    );
  }
}