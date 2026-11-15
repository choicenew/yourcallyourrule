import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_ads_hub/pyro_ads_hub.dart';
import 'package:pyro_phone_lookup_plugin_protocol/pyro_phone_lookup_plugin_protocol.dart';
import 'package:pyro_phone_lookup_plugin_ui/pyro_phone_lookup_plugin_ui.dart' as plugin_pkg_ui;
import 'package:yourcallyourrule/features/common/widgets/generic_list_page.dart';
import 'package:yourcallyourrule/features/phone_plugin/services/plugin_manager_service.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class PluginManagementPage extends ConsumerStatefulWidget {
  const PluginManagementPage({super.key});

  @override
  ConsumerState<PluginManagementPage> createState() => _PluginManagementPageState();
}

class _PluginManagementPageState extends ConsumerState<PluginManagementPage> {
  List<PluginSourceData> _plugins = [];
  bool _isLoading = true;
  String _searchKeyword = '';

  @override
  void initState() {
    super.initState();
    _loadPlugins();
  }

  Future<void> _loadPlugins() async {
    setState(() => _isLoading = true);
    try {
      final service = ref.read(pluginManagerServiceProvider);
      final list = await service.getAllPlugins();
      if (mounted) {
        setState(() {
          _plugins = list;
          _isLoading = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showAddPluginDialog(BuildContext context) {
    final urlController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context).pluginManagement),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: urlController,
              decoration: const InputDecoration(
                labelText: 'Plugin CDN / API URL',
                hintText: 'https://example.com/plugin.js',
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
              final url = urlController.text.trim();
              if (url.isNotEmpty) {
                final service = ref.read(pluginManagerServiceProvider);
                await service.addPluginFromUrl(url);
                if (mounted) {
                  Navigator.pop(context);
                  _loadPlugins();
                }
              }
            },
            child: Text(AppLocalizations.of(context).add),
          ),
        ],
      ),
    );
  }

  Widget _buildPluginStatusCard(BuildContext context) {
    final installedCount = _plugins.length;
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.extension_rounded, color: theme.colorScheme.primary, size: 24),
              const SizedBox(width: 12),
              Text(
                AppLocalizations.of(context).pluginManagement,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatusItem('Installed', '$installedCount', theme),
              _buildStatusItem('Active Drivers', '$installedCount', theme),
              _buildStatusItem('Auto Update', 'ON', theme),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusItem(String label, String value, ThemeData theme) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 11.5,
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    final filteredPlugins = _searchKeyword.isEmpty
        ? _plugins
        : _plugins.where((plugin) {
            final name = (plugin.name ?? '').toLowerCase();
            return name.contains(_searchKeyword.toLowerCase());
          }).toList();

    return GenericListPage<PluginSourceData>(
      title: l10n.pluginManagement,
      items: filteredPlugins,
      isLoading: _isLoading,
      headerContent: _buildPluginStatusCard(context),
      onAdd: () => _showAddPluginDialog(context),
      emptyText: l10n.noPlugins,
      emptyIcon: Icons.extension_outlined,
      onSearchChanged: (keyword) {
        setState(() {
          _searchKeyword = keyword;
        });
      },
      searchHintText: l10n.search,
      adInterval: 3,
      adBuilder: () => const AdsInlineBanner(),
      itemBuilder: (context, plugin) => plugin_pkg_ui.PyroPhoneLookupPluginCardWidget(
        data: plugin,
        onTap: () {},
      ),
      getItemId: (plugin) => plugin.name ?? '',
      onRefresh: _loadPlugins,
    );
  }
}
