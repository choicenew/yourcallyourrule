/// Quick Settings Tile active state.
enum TileStateType {
  active,
  inactive,
  unavailable;

  static TileStateType fromString(String raw) {
    switch (raw.trim().toLowerCase()) {
      case 'active':
        return TileStateType.active;
      case 'unavailable':
        return TileStateType.unavailable;
      case 'inactive':
      default:
        return TileStateType.inactive;
    }
  }
}
