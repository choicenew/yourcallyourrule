library pyro_phone_count_filter_ui;

import 'package:flutter/material.dart';
import 'package:pyro_phone_count_filter_protocol/pyro_phone_count_filter_protocol.dart';

/// 频次过滤器设置组件 (PhoneCountFilterTileView)
class PhoneCountFilterTileView extends StatelessWidget {
  final PhoneCountFilterConfig config;

  const PhoneCountFilterTileView({
    super.key,
    required this.config,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.numbers),
      title: const Text('Local Count Filter'),
      subtitle: Text('Threshold: ${config.countThreshold} • Enabled: ${config.enableLocalCountFilter}'),
    );
  }
}
