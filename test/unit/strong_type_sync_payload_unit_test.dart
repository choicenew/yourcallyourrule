import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sim_reader/sim_reader.dart';
import 'package:yourcallyourrule/data/database/remote/remote_database.dart';
import 'package:yourcallyourrule/features/deletion_proposer/models/server_verification_report.dart';
import 'package:yourcallyourrule/features/deletion_proposal/domain/models/sync_payload.dart';
import 'package:yourcallyourrule/features/deletion_proposal/data/proposal_datasource_impl.dart';
import 'package:yourcallyourrule/features/deletion_proposer/logic/verification_logic.dart';
import 'package:yourcallyourrule/features/device_profile/services/device_profile_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Mock path_provider plugin for NativeDatabase directory access in unit tests
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(
    const MethodChannel('plugins.flutter.io/path_provider'),
    (MethodCall methodCall) async {
      return '.';
    },
  );

  group('强类型 ServerVerificationReport 单元测试', () {
    test('1. ServerVerificationReport 实例创建、序列化与反序列化 100% 无损还原', () {
      final report = ServerVerificationReport(
        simState: 'READY',
        finalRisk: 'Verified',
        deviceId: 'device_hash_123',
        isRoaming: false,
        simCountry: 'CN',
        ipCountry: 'CN',
        isNumberMatch: true,
        riskScore: 0,
      );

      final jsonMap = report.toJson();
      expect(jsonMap['simState'], equals('READY'));
      expect(jsonMap['finalRisk'], equals('Verified'));
      expect(jsonMap['deviceId'], equals('device_hash_123'));
      expect(jsonMap['isRoaming'], equals(false));
      expect(jsonMap['isNumberMatch'], equals(true));

      final restored = ServerVerificationReport.fromJson(jsonMap);
      expect(restored, equals(report));
      expect(restored.simState, equals('READY'));
      expect(restored.finalRisk, equals('Verified'));
      expect(restored.isNumberMatch, equals(true));
    });

    test('2. VerificationResult 与 analyzeProfile 输出强类型 ServerVerificationReport', () {
      final rawProfile = RawDeviceProfile(
        hashedDeviceId: 'hash_999',
        simState: 'READY',
        simInfo: SimInfo(isNetworkRoaming: false, countryCode: 'CN', phoneNumber: '+8613800138000'),
        ipInfo: IpInfo(countryCode: 'CN'),
      );

      final input = VerificationInput(
        rawProfile: rawProfile,
        inputNumberE164: '+8613800138000',
        simNumberE164: '+8613800138000',
      );

      final result = analyzeProfile(input);
      expect(result.riskLevel, equals(RiskLevel.Verified));
      expect(result.reportForServer, isA<ServerVerificationReport>());
      expect(result.reportForServer.simState, equals('READY'));
      expect(result.reportForServer.finalRisk, equals('Verified'));
      expect(result.reportForServer.isNumberMatch, equals(true));
    });
  });

  group('强类型 SyncPayload 联合类单元测试', () {
    test('1. SyncPayload.proposeDeletion 序列化与反序列化双向转换', () {
      final report = ServerVerificationReport(
        simState: 'READY',
        finalRisk: 'Low',
        deviceId: 'dev_555',
        isRoaming: false,
        simCountry: 'US',
        ipCountry: 'US',
        isNumberMatch: false,
        riskScore: 2,
      );

      final payload = SyncPayload.proposeDeletion(
        report: report,
        timestamp: '2026-10-16T12:00:00.000Z',
      );

      final jsonMap = payload.toJson();
      expect(jsonMap['runtimeType'], equals('proposeDeletion'));
      expect(jsonMap['report'], isA<ServerVerificationReport>());
      final reportInPayload = jsonMap['report'] as ServerVerificationReport;
      expect(reportInPayload.finalRisk, equals('Low'));

      final restored = SyncPayload.fromJson({
        'runtimeType': jsonMap['runtimeType'],
        'report': reportInPayload.toJson(),
        'timestamp': jsonMap['timestamp'],
      });
      expect(restored, equals(payload));
      expect(restored, isA<ProposeDeletionPayload>());
      final proposePayload = restored as ProposeDeletionPayload;
      expect(proposePayload.report.finalRisk, equals('Low'));
      expect(proposePayload.report.simState, equals('READY'));
    });

    test('2. SyncPayload.numberUpdate 序列化与反序列化', () {
      final payload = SyncPayload.numberUpdate(
        phoneNumber: '+8613800000000',
        label: '诈骗电话',
        action: 1,
        count: 5,
        countryIsoCode: 'CN',
      );

      final jsonMap = payload.toJson();
      final restored = SyncPayload.fromJson(jsonMap);
      expect(restored, equals(payload));
      expect(restored, isA<NumberUpdatePayload>());
      final updatePayload = restored as NumberUpdatePayload;
      expect(updatePayload.phoneNumber, equals('+8613800000000'));
      expect(updatePayload.label, equals('诈骗电话'));
    });

    test('3. SyncPayload.voteDeletion 序列化与反序列化', () {
      final payload = SyncPayload.voteDeletion(
        voteType: 'proposal_agree_delete',
        additionalData: {'reason': '诈骗号码'},
        timestamp: '2026-10-16T12:00:00.000Z',
      );

      final jsonMap = payload.toJson();
      final restored = SyncPayload.fromJson(jsonMap);
      expect(restored, equals(payload));
      expect(restored, isA<VoteDeletionPayload>());
      final votePayload = restored as VoteDeletionPayload;
      expect(votePayload.voteType, equals('proposal_agree_delete'));
    });
  });

  group('ProposalDataSourceImpl 集成强实体测试 - pending_operations 离线队列连通性', () {
    late RemoteDatabase db;
    late ProposalDataSourceImpl dataSource;

    setUp(() {
      db = RemoteDatabase();
      dataSource = ProposalDataSourceImpl(db);
    });

    test('1. proposeDeletion 写入强实体，从 pending_operations 表成功提取解包', () async {
      final report = ServerVerificationReport(
        simState: 'READY',
        finalRisk: 'Verified',
        deviceId: 'dev_777',
        isRoaming: false,
        simCountry: 'CN',
        ipCountry: 'CN',
        isNumberMatch: true,
      );

      // 1. 写入离线队列
      await dataSource.proposeDeletion(
        phoneNumber: '+8613800138000',
        report: report,
      );

      // 2. 检查待同步队列
      final pendingOps = await dataSource.getPendingDeletionProposalOperations();
      expect(pendingOps.isNotEmpty, isTrue);
      final op = pendingOps.firstWhere((e) => e['entityId'] == '+8613800138000');
      expect(op['entityId'], equals('+8613800138000'));
      expect(op['operation'], equals('PROPOSE_DELETION'));

      // 3. 校验 payload 的强实体正确性
      final payloadMap = op['payload'] as Map<String, dynamic>;
      final syncPayload = SyncPayload.fromJson(payloadMap);
      expect(syncPayload, isA<ProposeDeletionPayload>());
      final proposePayload = syncPayload as ProposeDeletionPayload;
      expect(proposePayload.report.finalRisk, equals('Verified'));
      expect(proposePayload.report.isNumberMatch, equals(true));
      expect(proposePayload.report.deviceId, equals('dev_777'));
    });

    test('2. voteOnDeletionProposal 写入强实体，从 pending_operations 表提取解包', () async {
      await dataSource.voteOnDeletionProposal(
        phoneNumber: '+8613800138000',
        voteType: 'proposal_agree_delete',
        additionalData: {'voterDeviceId': 'voter_001'},
      );

      final votes = await dataSource.getPendingDeletionVotes();
      expect(votes.isNotEmpty, isTrue);
      final voteOp = votes.firstWhere((e) => e['entityId'] == '+8613800138000');
      expect(voteOp['operation'], equals('VOTE_DELETION'));

      final payloadMap = voteOp['payload'] as Map<String, dynamic>;
      final syncPayload = SyncPayload.fromJson(payloadMap);
      expect(syncPayload, isA<VoteDeletionPayload>());
      final votePayload = syncPayload as VoteDeletionPayload;
      expect(votePayload.voteType, equals('proposal_agree_delete'));
    });
  });
}
