import 'package:flutter/foundation.dart';
import 'package:pyro_phone_caller_identity_protocol/pyro_phone_caller_identity_protocol.dart';

/// 真实内存级身份画像拉取驱动 (MemoryCallerIdentityFetchDriver)
class MemoryCallerIdentityFetchDriver implements CallerIdentityFetchDriver {
  final Map<String, CallerIdData> _cache = {};

  MemoryCallerIdentityFetchDriver();

  @override
  Future<CallerIdData?> fetchProfile(String phoneNumber) async {
    return _cache[phoneNumber];
  }

  void saveProfile(CallerIdData profile) {
    _cache[profile.phoneNumber] = profile;
    debugPrint('[MemoryIdentityDriver] 保存身份画像: ${profile.phoneNumber} -> ${profile.name}');
  }
}
