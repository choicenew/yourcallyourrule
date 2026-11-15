import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_phone_subscription_protocol/pyro_phone_subscription_protocol.dart';
import 'package:pyro_phone_subscription_hub/pyro_phone_subscription_hub.dart';
import 'package:pyro_phone_subscription_ui/pyro_phone_subscription_ui.dart' as sub_pkg_ui;
import 'package:pyro_ads_hub/pyro_ads_hub.dart';
import 'package:yourcallyourrule/features/common/widgets/generic_list_page.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/features/phone_subscription/services/phone_subscription_service.dart';

final phoneSubscriptionsListProvider = FutureProvider.autoDispose<List<PhoneSubscriptionPayload>>((ref) async {
  final service = ref.watch(phoneSubscriptionServiceProvider);
  return await service.getAll();
});

/// 规范命名: 电话规则订阅主页面 (PhoneSubscriptionPage)
class PhoneSubscriptionPage extends ConsumerWidget {
  const PhoneSubscriptionPage({super.key});

  void _showAddSubscriptionDialog(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
    final urlController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context).phoneSubscription),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Subscription Name',
                hintText: 'Enter subscription name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: urlController,
              decoration: const InputDecoration(
                labelText: 'Subscription URL',
                hintText: 'https://example.com/rules.json',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context).cancelButton),
          ),
          ElevatedButton(
            onPressed: () async {
              final name = nameController.text.trim();
              final url = urlController.text.trim();
              if (name.isNotEmpty && url.isNotEmpty) {
                final service = ref.read(phoneSubscriptionServiceProvider);
                final sub = await service.addSubscription(name, url);
                await service.updateRulesFromSubscription(sub);
                ref.invalidate(phoneSubscriptionsListProvider);
                if (context.mounted) Navigator.pop(context);
              }
            },
            child: Text(AppLocalizations.of(context).add),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, AppLocalizations l10n) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.rss_feed_rounded,
            color: Theme.of(context).colorScheme.primary,
            size: 24,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.phoneSubscription,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '支持订阅与云端自动同步全球防骚扰黑白名单库与规则系统',
                  style: TextStyle(
                    fontSize: 11.5,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final subsAsync = ref.watch(phoneSubscriptionsListProvider);

    return subsAsync.when(
      data: (subscriptions) => GenericListPage<PhoneSubscriptionPayload>(
        title: l10n.phoneSubscription,
        items: subscriptions,
        isLoading: false,
        headerContent: _buildInfoCard(context, l10n),
        onAdd: () => _showAddSubscriptionDialog(context, ref),
        onRefresh: () async {
          ref.invalidate(phoneSubscriptionsListProvider);
        },
        emptyText: l10n.noSubscriptions,
        emptyIcon: Icons.rss_feed_rounded,
        adInterval: 3,
        adBuilder: () => const AdsInlineBanner(),
        itemBuilder: (context, sub) => sub_pkg_ui.PyroPhoneSubscriptionCardWidget(
          payload: sub,
          onTap: () => PhoneRulesSubscriptionControlCenter.instance.dispatchPayload(sub),
        ),
        getItemId: (sub) => sub.payloadId,
      ),
      loading: () => Scaffold(
        appBar: AppBar(title: Text(l10n.phoneSubscription)),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (err, st) => Scaffold(
        appBar: AppBar(title: Text(l10n.phoneSubscription)),
        body: Center(child: Text('Error: $err')),
      ),
    );
  }
}
