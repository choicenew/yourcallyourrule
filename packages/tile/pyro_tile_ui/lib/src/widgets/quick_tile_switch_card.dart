import 'package:flutter/material.dart';
import 'package:pyro_tile_protocol/pyro_tile_protocol.dart';

/// Card component allowing users to add or toggle Quick Settings Tile.
class QuickTileSwitchCard extends StatelessWidget {
  final TileStateType state;
  final VoidCallback? onAddTilePressed;

  const QuickTileSwitchCard({
    super.key,
    required this.state,
    this.onAddTilePressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final isActive = state == TileStateType.active;

    return Card(
      child: ListTile(
        leading: Icon(
          Icons.dashboard_customize,
          color: isActive ? colorScheme.primary : colorScheme.onSurfaceVariant,
        ),
        title: const Text('下拉快捷开关 (Quick Settings Tile)'),
        subtitle: Text(
          isActive ? '拦截开关已挂载至下拉通知栏' : '点击添加快捷开关至系统下拉通知栏',
        ),
        trailing: OutlinedButton(
          onPressed: onAddTilePressed,
          child: const Text('添加开关'),
        ),
      ),
    );
  }
}
