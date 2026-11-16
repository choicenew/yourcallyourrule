import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_phone_subscription_protocol/pyro_phone_subscription_protocol.dart';
import 'package:pyro_ads_hub/pyro_ads_hub.dart';
import 'package:yourcallyourrule/features/common/widgets/generic_list_page.dart';
import 'package:yourcallyourrule/features/phone_subscription/services/phone_subscription_service.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

final phoneSubscriptionsListProvider = FutureProvider.autoDispose<List<PhoneSubscriptionPayload>>((ref) async {
  final service = ref.watch(phoneSubscriptionServiceProvider);
  return await service.getAll();
});

/// 100% 国际化、对齐 elite-ui 完整架构的电话规则订阅页面 (PhoneSubscriptionPage)
class PhoneSubscriptionPage extends ConsumerStatefulWidget {
  const PhoneSubscriptionPage({super.key});

  @override
  ConsumerState<PhoneSubscriptionPage> createState() => _PhoneSubscriptionPageState();
}

class _PhoneSubscriptionPageState extends ConsumerState<PhoneSubscriptionPage> {
  String _searchKeyword = '';
  final Set<String> _updatingPayloadIds = {};

  void _onSearchChanged(String keyword) {
    setState(() {
      _searchKeyword = keyword;
    });
  }

  Future<void> _showAddOrEditSubscriptionDialog({PhoneSubscriptionPayload? subscription}) async {
    final l10n = AppLocalizations.of(context);
    final nameController = TextEditingController(text: subscription?.displayName ?? '');
    final urlController = TextEditingController(text: subscription?.downloadUrl ?? '');
    final isEditing = subscription != null;

    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(isEditing ? l10n.editSubscription : l10n.addSubscription),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: l10n.subscriptionName,
                  hintText: l10n.enterSubscriptionName,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: urlController,
                decoration: InputDecoration(
                  labelText: l10n.subscriptionUrl,
                  hintText: l10n.enterSubscriptionUrl,
                  border: const OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.cancelButton),
          ),
          FilledButton(
            onPressed: () async {
              final name = nameController.text.trim();
              final url = urlController.text.trim();
              if (name.isEmpty || url.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.enterValidNameAndUrl)),
                );
                return;
              }

              final service = ref.read(phoneSubscriptionServiceProvider);
              try {
                if (isEditing) {
                  final updatedMap = Map<String, dynamic>.from(subscription.rawJsonMap);
                  updatedMap['displayName'] = name;
                  updatedMap['downloadUrl'] = url;
                  final updatedSub = subscription.copyWith(rawJsonMap: updatedMap);
                  await service.updateRulesFromSubscription(updatedSub);
                } else {
                  final newSub = await service.addSubscription(name, url);
                  await service.updateRulesFromSubscription(newSub);
                }
                ref.invalidate(phoneSubscriptionsListProvider);
                if (mounted) Navigator.pop(ctx);
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${isEditing ? l10n.updateSubscriptionFailed : l10n.addSubscriptionFailed}: $e')),
                  );
                }
              }
            },
            child: Text(isEditing ? l10n.save : l10n.add),
          ),
        ],
      ),
    );
  }

  Future<void> _updateSubscription(PhoneSubscriptionPayload sub) async {
    final l10n = AppLocalizations.of(context);
    setState(() => _updatingPayloadIds.add(sub.payloadId));
    try {
      final service = ref.read(phoneSubscriptionServiceProvider);
      await service.updateRulesFromSubscription(sub);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.subscriptionUpdateSuccess),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${l10n.updateSubscriptionFailed}: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _updatingPayloadIds.remove(sub.payloadId));
        ref.invalidate(phoneSubscriptionsListProvider);
      }
    }
  }

  Future<void> _deleteSubscription(PhoneSubscriptionPayload sub) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.deleteSubscription),
        content: Text(l10n.confirmDeleteSubscriptions(sub.displayName ?? '')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.cancelButton),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text(l10n.deleteButton),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final service = ref.read(phoneSubscriptionServiceProvider);
      await service.deleteSubscription(sub.payloadId);
      ref.invalidate(phoneSubscriptionsListProvider);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.subscriptionDeleted)),
        );
      }
    }
  }

  Widget _buildInfoCard(BuildContext context, AppLocalizations l10n) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: primaryColor.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: primaryColor.withValues(alpha: 0.15),
          width: 1.1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: primaryColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Icon(
              Icons.info_outline_rounded,
              color: primaryColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.aboutPhoneSubscriptionRules,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.phoneSubscriptionRulesDescription,
                  style: TextStyle(
                    fontSize: 12.5,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
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

  Widget _buildSubscriptionCard(BuildContext context, PhoneSubscriptionPayload subscription, AppLocalizations l10n) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isUpdating = _updatingPayloadIds.contains(subscription.payloadId);
    final isEnabled = (subscription.rawJsonMap['isEnabled'] as bool?) ?? true;
    final timestamp = subscription.timestamp ?? 0;
    final lastUpdated = timestamp > 0 ? DateTime.fromMillisecondsSinceEpoch(timestamp) : DateTime.now();
    final formattedDate =
        '${lastUpdated.year}-${lastUpdated.month.toString().padLeft(2, '0')}-${lastUpdated.day.toString().padLeft(2, '0')} ${lastUpdated.hour.toString().padLeft(2, '0')}:${lastUpdated.minute.toString().padLeft(2, '0')}';

    String truncateUrl(String url, {int maxLength = 36}) {
      if (url.length <= maxLength) return url;
      return '${url.substring(0, maxLength)}...';
    }

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.rss_feed_rounded, color: colorScheme.primary, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        subscription.displayName?.trim().isNotEmpty == true
                            ? subscription.displayName!.trim()
                            : (subscription.rawJsonMap['name']?.toString().trim().isNotEmpty == true
                                ? subscription.rawJsonMap['name'].toString().trim()
                                : l10n.phoneSubscription),
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        truncateUrl(subscription.downloadUrl ?? ''),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Switch.adaptive(
                  value: isEnabled,
                  activeTrackColor: colorScheme.primary,
                  onChanged: (val) async {
                    final updatedMap = Map<String, dynamic>.from(subscription.rawJsonMap);
                    updatedMap['isEnabled'] = val;
                    final updatedSub = subscription.copyWith(rawJsonMap: updatedMap);
                    final service = ref.read(phoneSubscriptionServiceProvider);
                    await service.updateRulesFromSubscription(updatedSub);
                    ref.invalidate(phoneSubscriptionsListProvider);
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(height: 1),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.access_time_rounded, size: 14, color: colorScheme.onSurfaceVariant),
                const SizedBox(width: 4),
                Text(
                  formattedDate,
                  style: theme.textTheme.labelSmall?.copyWith(color: colorScheme.onSurfaceVariant),
                ),
                const Spacer(),
                if (isUpdating)
                  const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                else
                  IconButton(
                    icon: Icon(Icons.sync_rounded, size: 20, color: colorScheme.primary),
                    tooltip: l10n.syncNow,
                    onPressed: () => _updateSubscription(subscription),
                  ),
                PopupMenuButton<String>(
                  icon: Icon(Icons.more_vert_rounded, size: 20, color: colorScheme.onSurfaceVariant),
                  onSelected: (val) {
                    if (val == 'edit') {
                      _showAddOrEditSubscriptionDialog(subscription: subscription);
                    } else if (val == 'delete') {
                      _deleteSubscription(subscription);
                    }
                  },
                  itemBuilder: (ctx) => [
                    PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          const Icon(Icons.edit_outlined, size: 18),
                          const SizedBox(width: 8),
                          Text(l10n.editSubscription),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete_outline, size: 18, color: colorScheme.error),
                          const SizedBox(width: 8),
                          Text(l10n.deleteButton, style: TextStyle(color: colorScheme.error)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final subsAsync = ref.watch(phoneSubscriptionsListProvider);

    return subsAsync.when(
      data: (subscriptions) {
        final filteredSubs = _searchKeyword.isEmpty
            ? subscriptions
            : subscriptions.where((s) {
                final name = (s.displayName ?? '').toLowerCase();
                final url = (s.downloadUrl ?? '').toLowerCase();
                final keyword = _searchKeyword.toLowerCase();
                return name.contains(keyword) || url.contains(keyword);
              }).toList();

        return GenericListPage<PhoneSubscriptionPayload>(
          title: l10n.phoneRuleSubscription,
          items: filteredSubs,
          isLoading: false,
          headerContent: _buildInfoCard(context, l10n),
          onAdd: () => _showAddOrEditSubscriptionDialog(),
          onRefresh: () async {
            ref.invalidate(phoneSubscriptionsListProvider);
          },
          onSearchChanged: _onSearchChanged,
          searchHintText: l10n.searchSubscriptionsHint,
          emptyText: l10n.noSubscriptions,
          emptyIcon: Icons.subscriptions_outlined,
          adInterval: 3,
          adBuilder: () => const AdsInlineBanner(),
          itemBuilder: (context, sub) => _buildSubscriptionCard(context, sub, l10n),
          getItemId: (sub) => sub.payloadId,
        );
      },
      loading: () => Scaffold(
        appBar: AppBar(title: Text(l10n.phoneRuleSubscription)),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (err, st) => Scaffold(
        appBar: AppBar(title: Text(l10n.phoneRuleSubscription)),
        body: Center(child: Text('Error: $err')),
      ),
    );
  }
}
