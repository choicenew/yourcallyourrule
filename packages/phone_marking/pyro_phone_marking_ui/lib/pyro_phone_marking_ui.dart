library pyro_phone_marking_ui;

import 'package:flutter/material.dart';
import 'package:pyro_phone_marking_protocol/pyro_phone_marking_protocol.dart';

/// 号码打标 ListTile 组件
class PhoneMarkTileView extends StatelessWidget {
  final LabelPhoneEntry entry;

  const PhoneMarkTileView({
    super.key,
    required this.entry,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.label),
      title: Text(entry.phoneNumber),
      subtitle: Text('${entry.name} • ${entry.labelId}'),
    );
  }
}
