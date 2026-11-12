import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_phone_subscription_protocol/pyro_phone_subscription_protocol.dart';
import 'package:yourcallyourrule/features/contacts/services/contact_subscription_service.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class ContactSubscriptionPage extends ConsumerStatefulWidget {
  const ContactSubscriptionPage({super.key});

  @override
  ConsumerState<ContactSubscriptionPage> createState() => _ContactSubscriptionPageState();
}

class _ContactSubscriptionPageState extends ConsumerState<ContactSubscriptionPage> {
  List<PhoneSubscriptionPayload> _subscriptions = [];
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
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Load subscriptions failed: $e')),
        );
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _toggleSubscriptionStatus(PhoneSubscriptionPayload subscription) async {
    final subscriptionService = ref.read(contactSubscriptionServiceProvider);
    final isEnabled = subscription.rawJsonMap['isEnabled'] as bool? ?? true;
    try {
      if (isEnabled) {
        await subscriptionService.disableSubscription(subscription);
      } else {
        await subscriptionService.enableSubscription(subscription);
      }
      await _loadSubscriptions();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Update subscription failed: $e')),
        );
      }
    }
  }

  Future<void> _deleteSubscription(PhoneSubscriptionPayload subscription) async {
    final name = subscription.rawJsonMap['name'] as String? ?? 'Subscription';
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Subscription'),
        content: Text('Confirm delete subscription: $name?'),
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
      final subscriptionService = ref.read(contactSubscriptionServiceProvider);
      try {
        await subscriptionService.deleteSubscription(subscription.payloadId);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Subscription deleted')),
          );
        }
        await _loadSubscriptions();
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Delete subscription failed: $e')),
          );
        }
      }
    }
  }

  void _showAddSubscriptionDialog() {
    final nameController = TextEditingController();
    final urlController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Subscription'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Subscription Name',
                hintText: 'Enter subscription name',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: urlController,
              decoration: const InputDecoration(
                labelText: 'Subscription URL',
                hintText: 'Enter subscription URL',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(AppLocalizations.of(context).cancelButton),
          ),
          TextButton(
            onPressed: () async {
              final name = nameController.text.trim();
              final url = urlController.text.trim();

              if (name.isEmpty || url.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please fill all fields')),
                );
                return;
              }

              try {
                final subscriptionService = ref.read(contactSubscriptionServiceProvider);
                await subscriptionService.addSubscription(name, url);
                if (context.mounted) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Subscription added successfully')),
                  );
                }
                await _loadSubscriptions();
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Add subscription failed: $e')),
                  );
                }
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Subscriptions'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddSubscriptionDialog,
            tooltip: 'Add Subscription',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _subscriptions.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.rss_feed, size: 64, color: Colors.grey),
                      const SizedBox(height: 16),
                      const Text('No subscriptions found', style: TextStyle(fontSize: 18, color: Colors.grey)),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.add),
                        label: const Text('Add Subscription'),
                        onPressed: _showAddSubscriptionDialog,
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: _subscriptions.length,
                  itemBuilder: (context, index) {
                    final subscription = _subscriptions[index];
                    final name = subscription.rawJsonMap['name'] as String? ?? 'Subscription';
                    final url = subscription.rawJsonMap['url'] as String? ?? '';
                    final isEnabled = subscription.rawJsonMap['isEnabled'] as bool? ?? true;

                    return Card(
                      margin: const EdgeInsets.only(bottom: 12.0),
                      child: ListTile(
                        title: Text(name),
                        subtitle: Text(url),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Switch(
                              value: isEnabled,
                              onChanged: (_) => _toggleSubscriptionStatus(subscription),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deleteSubscription(subscription),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
