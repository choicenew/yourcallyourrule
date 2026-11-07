class SyncConflictResolver {
  /// 基于实体内部的 updatedAt 时间戳进行后写胜出 (LWW) 解决冲突
  List<Map<String, dynamic>> resolveConflicts({
    required List<Map<String, dynamic>> localItems,
    required List<Map<String, dynamic>> remoteItems,
    String idKey = 'id',
    String updatedAtKey = 'updatedAt',
  }) {
    final Map<String, Map<String, dynamic>> mergedMap = {};

    for (final item in localItems) {
      final id = item[idKey]?.toString();
      if (id != null) {
        mergedMap[id] = item;
      }
    }

    for (final remoteItem in remoteItems) {
      final id = remoteItem[idKey]?.toString();
      if (id == null) continue;

      if (!mergedMap.containsKey(id)) {
        mergedMap[id] = remoteItem;
      } else {
        final localItem = mergedMap[id]!;
        final localTime = _extractTimestamp(localItem[updatedAtKey]);
        final remoteTime = _extractTimestamp(remoteItem[updatedAtKey]);

        if (remoteTime >= localTime) {
          mergedMap[id] = remoteItem;
        }
      }
    }

    return mergedMap.values.toList();
  }

  int _extractTimestamp(dynamic value) {
    if (value is int) return value;
    if (value is String) {
      final parsed = DateTime.tryParse(value);
      if (parsed != null) return parsed.millisecondsSinceEpoch;
    }
    if (value is DateTime) return value.millisecondsSinceEpoch;
    return 0;
  }
}
