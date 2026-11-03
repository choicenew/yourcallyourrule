import '../enums/tile_state_type.dart';

/// Entity model for Quick Settings Tile.
class TileInfoEntity {
  final String label;
  final String subtitle;
  final TileStateType state;

  const TileInfoEntity({
    required this.label,
    required this.subtitle,
    required this.state,
  });

  Map<String, dynamic> toMap() {
    return {
      'label': label,
      'subtitle': subtitle,
      'state': state.name,
    };
  }

  factory TileInfoEntity.fromMap(Map<dynamic, dynamic> map) {
    return TileInfoEntity(
      label: (map['label'] ?? 'Call Blocker').toString(),
      subtitle: (map['subtitle'] ?? 'Active').toString(),
      state: TileStateType.fromString((map['state'] ?? 'inactive').toString()),
    );
  }
}
