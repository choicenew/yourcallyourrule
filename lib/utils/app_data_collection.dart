

import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AnalyticsService {
  static FirebaseAnalytics? _analytics;
  static FirebaseAnalyticsObserver? _observer;

  static FirebaseAnalytics get analytics => _analytics!;
  static FirebaseAnalyticsObserver get observer => _observer!;

  static Future<void> init() async {
    try {
      await Firebase.initializeApp();
      _analytics = FirebaseAnalytics.instance;
      _observer = FirebaseAnalyticsObserver(analytics: _analytics!);
      await logDeviceInfo();
    } catch (e) {
     // print('Failed to initialize AnalyticsService: $e');
    }
  }


  static Future<void> logDeviceInfo() async {
    try {
      var deviceInfo = await _getDeviceInfo();
      var appInfo = await _getAppInfo();
      var locale = await _getLocale();
      // 只获取一次设备信息和应用版本号
      await _analytics?.setUserProperty(
          name: 'device_model', value: deviceInfo['model']);
      await _analytics?.setUserProperty(
          name: 'device_os', value: deviceInfo['os']);
      await _analytics?.setUserProperty(
          name: 'app_version',
          value: '${appInfo['version']} (${appInfo['buildNumber']})');
      // 获取语言和地区信息
      await _analytics?.setUserProperty(
          name: 'user_language', value: locale['language']);
      await _analytics?.setUserProperty(
          name: 'user_region', value: locale['region']);
    } catch (e) {
      //
    }
  }

  // 获取设备信息
  static Future<Map<String, String>> _getDeviceInfo() async {
    var deviceInfo = <String, String>{};
    try {
      var deviceInfoPlugin = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        var androidInfo = await deviceInfoPlugin.androidInfo;
        deviceInfo['model'] = androidInfo.model;
        deviceInfo['os'] = 'Android ${androidInfo.version.release}';
      } else if (Platform.isIOS) {
        var iosInfo = await deviceInfoPlugin.iosInfo;
        deviceInfo['model'] = iosInfo.model;
        deviceInfo['os'] = '${iosInfo.systemName} ${iosInfo.systemVersion}';
      }
    } on PlatformException catch (e) {
      //
    }
    return deviceInfo;
  }

  // 获取语言和地区信息
  static Future<Map<String, String>> _getLocale() async {
    var locale = <String, String>{};
    try {
      var platformLocale = Platform.localeName;
      var parts = platformLocale.split('_');
      locale['language'] = parts[0];
      locale['region'] = parts.length > 1 ? parts[1] : '';
    } catch (e) {
     //
    }
    return locale;
  }

  static Future<Map<String, String>> _getAppInfo() async {
    var appInfo = <String, String>{};
    try {
      var packageInfo = await PackageInfo.fromPlatform();
      appInfo['version'] = packageInfo.version;
      appInfo['buildNumber'] = packageInfo.buildNumber;
    } catch (e) {
      //
    }
    return appInfo;
  }
}

