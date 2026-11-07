library pyro_phone_contacts_ui;

import 'package:flutter/material.dart';
import 'package:pyro_phone_contacts_protocol/pyro_phone_contacts_protocol.dart';

/// 联系人 ListTile 组件
class PhoneContactTileView extends StatelessWidget {
  final PhoneContactEntry entry;

  const PhoneContactTileView({
    super.key,
    required this.entry,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.contacts),
      title: Text(entry.displayName),
      subtitle: Text(entry.phoneNumbers.join(', ')),
    );
  }
}
