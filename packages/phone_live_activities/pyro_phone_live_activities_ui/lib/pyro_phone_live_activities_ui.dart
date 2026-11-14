library pyro_phone_live_activities_ui;

import 'package:material_ui/material_ui.dart';
import 'package:pyro_phone_live_activities_protocol/pyro_phone_live_activities_protocol.dart';

/// 灵动岛预览 ListTile 组件
class LiveActivityTileView extends StatelessWidget {
  final PhoneLiveActivityRecord record;

  const LiveActivityTileView({
    super.key,
    required this.record,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.style),
      title: Text(record.title),
      subtitle: Text('${record.phoneNumber} • ${record.subtitle ?? "Active"}'),
    );
  }
}
