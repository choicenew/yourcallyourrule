import 'package:flutter/foundation.dart';
import 'package:pyro_phone_remote_filter_protocol/pyro_phone_remote_filter_protocol.dart';

/// 真实内存级远程号码过滤持久化驱动 (MemoryRemoteNumberStorageDriver)
class MemoryRemoteNumberStorageDriver implements RemoteNumberStorageDriver {
  final Map<String, RemoteNumberEntry> _entries = {};

  MemoryRemoteNumberStorageDriver();

  @override
  Future<RemoteNumberEntry?> getByPhoneNumber(String phoneNumber) async {
    return _entries[phoneNumber];
  }

  @override
  Future<void> saveRemoteNumber(RemoteNumberEntry entry) async {
    _entries[entry.phoneNumber] = entry;
    debugPrint('[MemoryRemoteDriver] 持久化保存远程高危号码: ${entry.phoneNumber}');
  }

  @override
  Future<List<RemoteNumberEntry>> getAllRemoteNumbers() async {
    return _entries.values.toList();
  }
}
