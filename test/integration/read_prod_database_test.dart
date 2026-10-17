import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yourcallyourrule/env.dart';

void main() async {
  final prodWorkerUrl = Env.cfWorkerUrl;
  final prodApiSecret = Env.workerApiSecret;

  print('=== 读取生产 Cloudflare Worker (https://callruleapi.oakgeol.workers.dev) 数据库当前数据 ===');

  final headers = {
    'Content-Type': 'application/json',
    'X-API-SECRET': prodApiSecret,
  };

  // 1. 拉取增量同步数据 GET /sync (CN, US, FR)
  try {
    final queryParams = {
      'since': DateTime.fromMillisecondsSinceEpoch(0).toIso8601String(),
      'deviceId': 'prod_read_data_inspector_001',
      'countryCodes': 'CN,US,FR',
    };

    final uri = Uri.parse('$prodWorkerUrl/sync').replace(queryParameters: queryParams);
    print('\n[1. 增量日志与活跃提议数据拉取] 请求: $uri');

    final response = await http.get(uri, headers: headers);
    print('HTTP Status: ${response.statusCode}');
    print('Body:\n${response.body}');
  } catch (e) {
    print('[1. 异常]: $e');
  }

  // 2. 拉取中国 CN 国家初始全量包
  try {
    final uri = Uri.parse('$prodWorkerUrl/country-data').replace(queryParameters: {'countryCode': 'CN'});
    print('\n[2. 中国 (CN) 全量号码表数据] 请求: $uri');

    final response = await http.get(uri, headers: headers);
    print('HTTP Status: ${response.statusCode}');
    print('Body:\n${response.body}');
  } catch (e) {
    print('[2. 异常]: $e');
  }

  // 3. 拉取美国 US 国家初始全量包
  try {
    final uri = Uri.parse('$prodWorkerUrl/country-data').replace(queryParameters: {'countryCode': 'US'});
    print('\n[3. 美国 (US) 全量号码表数据] 请求: $uri');

    final response = await http.get(uri, headers: headers);
    print('HTTP Status: ${response.statusCode}');
    print('Body:\n${response.body}');
  } catch (e) {
    print('[3. 异常]: $e');
  }

  // 4. 拉取系统配额配置 /api/v1/config/proposal-limits
  try {
    final uri = Uri.parse('$prodWorkerUrl/api/v1/config/proposal-limits');
    print('\n[4. 生产配置接口] 请求: $uri');

    final response = await http.get(uri, headers: headers);
    print('HTTP Status: ${response.statusCode}');
    print('Body:\n${response.body}');
  } catch (e) {
    print('[4. 异常]: $e');
  }

  print('\n=== 生产库数据拉取完成 ===');
}
