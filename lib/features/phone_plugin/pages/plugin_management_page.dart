import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return GenericListPage<PluginSourceData>(
      title: l10n.pluginManagement,
      items: _plugins,
      isLoading: _isLoading,
      emptyText: l10n.noPlugins,
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
