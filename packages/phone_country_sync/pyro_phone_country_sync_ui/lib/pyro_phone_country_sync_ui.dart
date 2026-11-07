library pyro_phone_country_sync_ui;

import 'package:flutter/material.dart';
import 'package:pyro_phone_country_sync_protocol/pyro_phone_country_sync_protocol.dart';

/// 国家代码同步 ListTile 组件
class CountrySyncTileView extends StatelessWidget {
  final CountrySyncPayload payload;

  const CountrySyncTileView({
    super.key,
    required this.payload,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.public),
      title: Text(payload.countryIsoCode),
      subtitle: Text('Records: ${payload.totalRecords} • Status: ${payload.status}'),
    );
  }
}
