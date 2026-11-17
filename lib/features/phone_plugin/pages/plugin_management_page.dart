import 'package:file_picker/file_picker.dart';
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
    final l10n = AppLocalizations.of(context);
    final urlController = TextEditingController();
    final isZh = Localizations.localeOf(context).languageCode.toLowerCase().startsWith('zh');
    final nameController = TextEditingController();
    final versionController = TextEditingController(text: '1.0.0');
    final descriptionController = TextEditingController();
    bool manualEntry = false;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(l10n.addPlugin),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: urlController,
                  decoration: InputDecoration(
                    labelText: l10n.pluginUrl,
                    hintText: l10n.enterPluginUrl,
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8),
                SwitchListTile(
                  secondary: Icon(
                    Icons.keyboard_sharp,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  title: Text(l10n.manualEntry),
                  value: manualEntry,
                  onChanged: (bool value) {
                    setDialogState(() {
                      manualEntry = value;
                    });
                  },
                ),
                if (manualEntry) ...[
                  const SizedBox(height: 8),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: l10n.pluginName,
                      hintText: l10n.enterPluginName,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: versionController,
                    decoration: InputDecoration(
                      labelText: l10n.pluginVersion,
                      hintText: l10n.enterVersion,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      labelText: l10n.pluginDescription,
                      hintText: l10n.enterPluginDescription,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ],
                const SizedBox(height: 8),
                TextButton.icon(
                  onPressed: () async {
                    Navigator.pop(context);
                    await _addPluginFromLocal();
                  },
                  icon: const Icon(Icons.file_upload),
                  label: Text(l10n.addPluginFromLocalFile),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(l10n.cancelButton),
            ),
            ElevatedButton(
              onPressed: () async {
                final service = ref.read(pluginManagerServiceProvider);
                if (manualEntry) {
                  final name = nameController.text.trim();
                  final url = urlController.text.trim();
                  final desc = descriptionController.text.trim();
                  if (name.isNotEmpty) {
                    await service.addPlugin(
                      PluginSourceData(
                        name: name,
                        phoneNumber: url,
                        sourceLabel: desc,
                        count: 0,
                      ),
                    );
                    if (mounted) {
                      Navigator.pop(context);
                      _loadPlugins();
                    }
                  }
                } else {
                  final url = urlController.text.trim();
                  if (url.isNotEmpty) {
                    await service.addPluginFromUrl(url);
                    if (mounted) {
                      Navigator.pop(context);
                      _loadPlugins();
                    }
                  }
                }
              },
              child: Text(l10n.add),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addPluginFromLocal() async {
    final l10n = AppLocalizations.of(context);
    try {
      final result = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['js'],
      );
      if (result.isNotEmpty && result.first.path != null) {
        final path = result.first.path!;
        final service = ref.read(pluginManagerServiceProvider);
        final added = await service.addPluginFromLocal(path);
        if (added != null && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.pluginAddedSuccess(added.name ?? ''))),
          );
          _loadPlugins();
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.addPluginFailedWithError(e.toString()))),
        );
      }
    }
  }

  Widget _buildPluginStatusCard(BuildContext context) {
    final installedCount = _plugins.length;
    final theme = Theme.of(context);
    final isZh = Localizations.localeOf(context).languageCode.toLowerCase().startsWith('zh');
    final l10n = AppLocalizations.of(context);

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
                l10n.pluginManagement,
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
              _buildStatusItem(l10n.installed, '$installedCount', theme),
              _buildStatusItem(l10n.enabled, '$installedCount', theme),
              _buildStatusItem(l10n.autoUpdate, l10n.enabledStatus, theme),
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
