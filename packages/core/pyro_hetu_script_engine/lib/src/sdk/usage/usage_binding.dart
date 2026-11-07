import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:app_usage/app_usage.dart';
import 'package:hetu_script/hetu_script.dart';
import 'package:hetu_script/binding.dart';

class UsageBinding extends HTExternalClass {
  UsageBinding() : super('Usage');

  @override
  dynamic memberGet(String id, {String? from, bool isRecursive = false, bool ignoreUndefined = false}) {
    switch (id) {
      case 'Usage.getTodayUsage':
      case 'getTodayUsage':
        return ({List<dynamic> positionalArgs = const [],
            Map<String, dynamic> namedArgs = const {}}) async {
          if (!Platform.isAndroid) return {};

          try {
            DateTime endDate = DateTime.now();
            DateTime startDate = endDate.subtract(const Duration(hours: 24));
            List<AppUsageInfo> infoList =
                await AppUsage().getAppUsage(startDate, endDate);

            Map<String, double> usageMap = {};
            for (var info in infoList) {
              // Convert to minutes
              usageMap[info.packageName] = info.usage.inMinutes.toDouble();
            }
            return usageMap;
          } catch (e) {
            debugPrint('[UsageBinding] Error: $e');
            return {};
          }
        };
      default:
        throw HTError.undefined(id);
    }
  }
}
