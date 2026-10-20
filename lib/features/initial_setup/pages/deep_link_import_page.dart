import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/features/phone/services/phone_subscription_service.dart';
import 'package:yourcallyourrule/features/plugin/services/plugin_manager_service.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 负责处理从外部浏览器/网页 Deep Link (yourcallrule://import) 唤起的导入操作
class DeepLinkImportPage extends ConsumerStatefulWidget {
  final String? type; // 'plugin' 或 'subscription'
  final String? url;
  final String? name;

  const DeepLinkImportPage({
    super.key,
    this.type,
    this.url,
    this.name,
  });

  @override
  ConsumerState<DeepLinkImportPage> createState() => _DeepLinkImportPageState();
}

class _DeepLinkImportPageState extends ConsumerState<DeepLinkImportPage> {
  bool _isProcessing = false;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final typeName = widget.type == 'plugin' ? l10n.deepLinkTypePlugin : l10n.deepLinkTypeSubscription;
    final targetUrl = widget.url ?? '';
    final displayName = widget.name ?? (widget.type == 'plugin' ? l10n.deepLinkDefaultPluginName : l10n.deepLinkDefaultSubName);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.deepLinkImportTitle(typeName)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.download_for_offline_outlined, size: 64, color: Colors.blue),
            const SizedBox(height: 24),
            Text(
              l10n.deepLinkDetectedTitle,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.deepLinkNameLabel(displayName), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 8),
                    Text(l10n.deepLinkTypeLabel(typeName), style: const TextStyle(fontSize: 14)),
                    const SizedBox(height: 8),
                    Text(l10n.deepLinkUrlLabel(targetUrl), style: const TextStyle(fontSize: 12, color: Colors.grey), maxLines: 3, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
            ),
            if (_errorMessage != null) ...[
              const SizedBox(height: 16),
              Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
            ],
            const Spacer(),
            if (_isProcessing)
              const Center(child: CircularProgressIndicator())
            else
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => context.pop(),
                      child: Text(l10n.cancelButton),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: targetUrl.isEmpty ? null : () => _handleImport(l10n),
                      child: Text(l10n.deepLinkConfirmButton),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleImport(AppLocalizations l10n) async {
    final targetUrl = widget.url?.trim() ?? '';
    if (targetUrl.isEmpty) {
      setState(() {
        _errorMessage = l10n.deepLinkEmptyUrlError;
      });
      return;
    }

    setState(() {
      _isProcessing = true;
      _errorMessage = null;
    });

    try {
      if (widget.type == 'plugin') {
        final pluginService = ref.read(pluginManagerServiceProvider);
        final entry = await pluginService.addPluginFromUrl(targetUrl);
        if (entry == null) {
          throw Exception(l10n.deepLinkPluginDownloadFailed);
        }
      } else {
        final phoneService = ref.read(phoneSubscriptionServiceProvider);
        final name = widget.name?.trim().isNotEmpty == true ? widget.name! : l10n.deepLinkDefaultSubName;
        final sub = await phoneService.addSubscription(name, targetUrl);
        await phoneService.importAndSaveRulesFromSubscription(sub);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.deepLinkImportSuccess)),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = l10n.deepLinkImportFailed(e.toString());
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
      }
    }
  }
}
