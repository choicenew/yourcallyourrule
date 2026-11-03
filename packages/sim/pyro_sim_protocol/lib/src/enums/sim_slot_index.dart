/// Strongly typed SIM card slot index.
enum SimSlotIndex {
  slot1(0, 'SIM 1'),
  slot2(1, 'SIM 2'),
  unknown(-1, 'Unknown Slot');

  final int rawIndex;
  final String label;

  const SimSlotIndex(this.rawIndex, this.label);

  static SimSlotIndex fromInt(int raw) {
    switch (raw) {
      case 0:
        return SimSlotIndex.slot1;
      case 1:
        return SimSlotIndex.slot2;
      default:
        return SimSlotIndex.unknown;
    }
  }
}
