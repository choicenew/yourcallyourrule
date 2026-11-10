import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_phone_lookup_plugin_protocol/pyro_phone_lookup_plugin_protocol.dart';
import 'package:pyro_phone_lookup_plugin_hub/pyro_phone_lookup_plugin_hub.dart';
import 'package:pyro_phone_lookup_plugin_ui/pyro_phone_lookup_plugin_ui.dart' as plugin_pkg_ui;
import 'package:yourcallyourrule/ads/adwidgets/inline_adaptive_ad.dart';
import 'package:yourcallyourrule/features/common/widgets/generic_list_with_ads_page.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class PluginManagementPage extends ConsumerWidget {
  const PluginManagementPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final plugins = ref.watch(phoneLookupPluginControlCenterProvider).plugins;

    return GenericListWithAdsPage<PluginSourceData>(
      title: l10n.pluginManagementTitle,
      items: plugins,
      emptyText: l10n.noPluginsFound,
      adInterval: 3,
      adBuilder: () => const InlineAdaptiveAd(),
      itemBuilder: (context, plugin) => plugin_pkg_ui.PyroPhoneLookupPluginCardWidget(
        data: plugin,
        onTap: () => ref.read(phoneLookupPluginControlCenterProvider).editPlugin(plugin),
      ),
      getItemId: (plugin) => plugin.name ?? '',
      onAdd: () => ref.read(phoneLookupPluginControlCenterProvider).openAddPluginDialog(context),
      onSearchChanged: (query) => ref.read(phoneLookupPluginControlCenterProvider).searchPlugins(query),
      onDeleteSelected: () => ref.read(phoneLookupPluginControlCenterProvider).deleteSelectedPlugins(),
    );
  }
}
