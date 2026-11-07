import 'package:flutter/foundation.dart';
import 'package:pyro_caller_identity_protocol/pyro_caller_identity_protocol.dart';

/// 真实内存级身份画像拉取驱动 (MemoryCallerIdentityFetchDriver)
class MemoryCallerIdentityFetchDriver implements CallerIdentityFetchDriver {
  final Map<String, CallerProfile> _cache = {};

  MemoryCallerIdentityFetchDriver();

  @override
  Future<CallerProfile?> fetchProfile(String phoneNumber) async {
    return _cache[phoneNumber];
  }

  void saveProfile(CallerProfile profile) {
    _cache[profile.phoneNumber] = profile;
    debugPrint('[MemoryIdentityDriver] 保存身份画像: ${profile.phoneNumber} -> ${profile.name}');
  }
}
