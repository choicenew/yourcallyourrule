import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yourcallyourrule/data/models/sync/sync_operation_type.dart';
import 'package:yourcallyourrule/features/deletion_proposer/models/server_verification_report.dart';
import 'package:yourcallyourrule/features/deletion_proposal/domain/models/sync_payload.dart';

void main() async {
  final workerUrl = 'https://callrule-test-worker.ueeducationc.workers.dev';
  final apiSecret = 'slroeeb@gmail.comyourcallyourrule17086608725';

  print('=== 开始在线 TypeScript + Zod 强实体 Cloudflare Worker 端到端实测 ===');

  final headers = {
    'Content-Type': 'application/json',
    'X-API-SECRET': apiSecret,
  };

  // ---------------------------------------------------------------------------
  // 测试 1: 强实体合法数据提交 (PROPOSE_DELETION + ServerVerificationReport)
  // ---------------------------------------------------------------------------
  try {
    print('\n[测试 1] 提交合法强实体 PROPOSE_DELETION 报文...');
    final report = ServerVerificationReport(
      simState: 'READY',
      finalRisk: 'Verified',
      deviceId: 'device_ts_zod_001',
      isRoaming: false,
      simCountry: 'CN',
      ipCountry: 'CN',
      isNumberMatch: true,
      riskScore: 0,
    );

    final payload = SyncPayload.proposeDeletion(
      report: report,
      timestamp: DateTime.now().toIso8601String(),
    );

    final proposeEnvelope = {
      'id': 'ts-zod-propose-${DateTime.now().millisecondsSinceEpoch}',
      'entityId': '+8610000000099',
      'operation': SyncOperationType.proposeDeletion.toRawString(),
      'payload': payload.toJson(),
      'timestamp': DateTime.now().toIso8601String(),
    };

    final response = await http.post(
      Uri.parse('$workerUrl/sync'),
      headers: headers,
      body: jsonEncode({'operations': [proposeEnvelope], 'sourceDeviceId': 'device_ts_zod_001'}),
    );

    print('合法请求 Status: ${response.statusCode}');
    print('合法请求 Body: ${response.body}');
  } catch (e) {
    print('[测试 1 异常]: $e');
  }

  // ---------------------------------------------------------------------------
  // 测试 2: 契约硬性校验防御 (故意传脏数据，验证 Zod 在网关层拦截)
  // ---------------------------------------------------------------------------
  try {
    print('\n[测试 2] 故意传递非法的脏数据 Payload (缺少必填的 finalRisk 属性)...');
    final invalidEnvelope = {
      'id': 'ts-zod-bad-${DateTime.now().millisecondsSinceEpoch}',
      'entityId': '+8610000000099',
      'operation': SyncOperationType.proposeDeletion.toRawString(),
      'payload': {
        'report': {
          'simState': 'READY',
          // 故意缺少 finalRisk 必填字段，触发 Zod 网关拒绝
        },
        'timestamp': DateTime.now().toIso8601String(),
      },
      'timestamp': DateTime.now().toIso8601String(),
    };

    final response = await http.post(
      Uri.parse('$workerUrl/sync'),
      headers: headers,
      body: jsonEncode({'operations': [invalidEnvelope], 'sourceDeviceId': 'device_ts_zod_001'}),
    );

    print('脏数据拦截 Status: ${response.statusCode} (期待 400)');
    print('脏数据拦截 Body: ${response.body}');
  } catch (e) {
    print('[测试 2 异常]: $e');
  }

  print('\n=== 在线 TypeScript + Zod 强实体实测结束 ===');
}
