library pyro_phone_lookup_plugin_ui;

import 'package:flutter/material.dart';
import 'package:pyro_phone_lookup_plugin_protocol/pyro_phone_lookup_plugin_protocol.dart';

/// 查号插件卡片组件 (PhoneLookupPluginTileView)
class PhoneLookupPluginTileView extends StatelessWidget {
  final PluginSourceData data;

  const PhoneLookupPluginTileView({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.search),
      title: Text(data.name ?? data.phoneNumber ?? 'Unknown Plugin Data'),
      subtitle: Text('${data.sourceLabel ?? "No Label"} • Count: ${data.count ?? 0}'),
    );
  }
}
