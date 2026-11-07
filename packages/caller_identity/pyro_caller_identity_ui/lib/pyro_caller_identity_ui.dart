library pyro_caller_identity_ui;

import 'package:flutter/material.dart';
import 'package:pyro_caller_identity_protocol/pyro_caller_identity_protocol.dart';

/// 身份画像卡片组件 (CallerProfileTileView)
class CallerProfileTileView extends StatelessWidget {
  final CallerProfile profile;

  const CallerProfileTileView({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.account_circle),
      title: Text(profile.name ?? profile.phoneNumber),
      subtitle: Text('${profile.region ?? "Unknown"} • ${profile.labels.join(", ")}'),
    );
  }
}
