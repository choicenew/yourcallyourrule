import 'dart:typed_data';

/// Pure Dart Bloom Filter bitmap implementation for space-efficient membership testing
class BloomFilter {
  final int bitArraySize;
  final int numHashFunctions;
  final Uint8List _bits;

  BloomFilter({
    this.bitArraySize = 1024 * 1024 * 8, // 1MB bitmap (8M bits)
    this.numHashFunctions = 4,
  }) : _bits = Uint8List((bitArraySize + 7) ~/ 8);

  void add(String item) {
    final hashes = _getHashes(item);
    for (final hash in hashes) {
      final bitIdx = hash % bitArraySize;
      final byteIdx = bitIdx ~/ 8;
      final bitOffset = bitIdx % 8;
      _bits[byteIdx] |= (1 << bitOffset);
    }
  }

  bool mightContain(String item) {
    final hashes = _getHashes(item);
    for (final hash in hashes) {
      final bitIdx = hash % bitArraySize;
      final byteIdx = bitIdx ~/ 8;
      final bitOffset = bitIdx % 8;
      if ((_bits[byteIdx] & (1 << bitOffset)) == 0) {
        return false;
      }
    }
    return true;
  }

  List<int> _getHashes(String item) {
    final bytes = item.codeUnits;
    int h1 = 5381;
    int h2 = 0;

    for (final b in bytes) {
      h1 = ((h1 << 5) + h1) ^ b;
      h2 = (h2 * 31) ^ b;
    }

    final hashes = <int>[];
    for (int i = 0; i < numHashFunctions; i++) {
      hashes.add((h1 + i * h2).abs());
    }
    return hashes;
  }
}
