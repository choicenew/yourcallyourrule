/// State type of SIM card insertion.
enum SimStateType {
  ready,
  absent,
  locked,
  unknown;

  static SimStateType fromString(String raw) {
    switch (raw.trim().toLowerCase()) {
      case 'ready':
        return SimStateType.ready;
      case 'absent':
        return SimStateType.absent;
      case 'locked':
        return SimStateType.locked;
      default:
        return SimStateType.unknown;
    }
  }
}
