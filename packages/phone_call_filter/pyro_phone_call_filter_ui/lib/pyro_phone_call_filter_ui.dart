import 'package:flutter/material.dart';
import 'package:pyro_phone_call_filter_protocol/pyro_phone_call_filter_protocol.dart';

/// 过滤器卡片组件 (FilterTileView)
class FilterTileView extends StatelessWidget {
  final CallFilterType filterType;

  const FilterTileView({
    super.key,
    required this.filterType,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.filter_list),
      title: Text(filterType.id),
    );
  }
}
