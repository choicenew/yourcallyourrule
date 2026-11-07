import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_caller_identity_protocol/pyro_caller_identity_protocol.dart';

part 'caller_identity_service.g.dart';

@Riverpod(keepAlive: true)
CallerIdentityService callerIdentityService(Ref ref) {
  final service = CallerIdentityService.instance;
  return service;
}

/// 身份画像聚合服务中枢 (CallerIdentityService)
class CallerIdentityService {
  static final CallerIdentityService instance = CallerIdentityService._();

  CallerIdentityService._();

  final List<CallerIdentityFetchDriver> _fetchDrivers = [];
  final _profileController = StreamController<CallerProfile>.broadcast();

  Stream<CallerProfile> get profileStream => _profileController.stream;

  void registerFetchDriver(CallerIdentityFetchDriver driver) {
    _fetchDrivers.add(driver);
    debugPrint('[CallerIdentityHub] 已挂载注册画像 Driver: ${driver.runtimeType}');
  }

  CallerProfile assembleProfile({
    required String phoneNumber,
    String? name,
    String? region,
    String? countryName,
    String? carrier,
    List<String>? labels,
    int localCount = 0,
    int pluginCount = 0,
    int remoteCount = 0,
  }) {
    final profile = CallerProfile(
      phoneNumber: phoneNumber,
      name: name,
      region: region,
      countryName: countryName,
      carrier: carrier,
      labels: labels ?? [],
      localCount: localCount,
      pluginCount: pluginCount,
      remoteCount: remoteCount,
    );
    _profileController.add(profile);
    debugPrint('[CallerIdentityHub] 组装身份画像完成: $phoneNumber -> ${profile.name}');
    return profile;
  }
}
