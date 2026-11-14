import 'dart:async';
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_phone_subscription_protocol/pyro_phone_subscription_protocol.dart';
import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:pyro_phone_contacts_protocol/pyro_phone_contacts_protocol.dart';

/// 订阅全流程数据流加载器模拟 (Simulated Subscription Data Stream Loader)
class SubscriptionPipelineLoader {
  final List<PhoneSubscriptionPayload> _activeSubscriptions = [];
  final StreamController<SubscriptionLoadStatusEvent> _statusController = StreamController<SubscriptionLoadStatusEvent>.broadcast();

  Stream<SubscriptionLoadStatusEvent> get statusStream => _statusController.stream;
  List<PhoneSubscriptionPayload> get activeSubscriptions => List.unmodifiable(_activeSubscriptions);

  /// 步骤 1: 订阅 (Subscribe)
  Future<PhoneSubscriptionPayload> subscribe({
    required String subscriptionId,
    required PhoneSubscriptionKind kind,
    required String name,
    required String downloadUrl,
  }) async {
    _statusController.add(SubscriptionLoadStatusEvent(
      subscriptionId: subscriptionId,
      status: SubscriptionStatus.subscribing,
      message: '正在发起订阅: $name',
    ));

    final payload = PhoneSubscriptionPayload(
      payloadId: subscriptionId,
      kind: kind,
      rawJsonMap: {
        'displayName': name,
        'downloadUrl': downloadUrl,
        'createdAt': DateTime.now().toIso8601String(),
      },
      timestamp: DateTime.now().millisecondsSinceEpoch,
    );

    _activeSubscriptions.add(payload);
    return payload;
  }

  /// 步骤 2: 模拟网络/流数据加载 (Loading / Fetching Stream)
  Stream<String> fetchRawDataStream(String url, String mockJsonContent) async* {
    final chunks = [
      mockJsonContent.substring(0, (mockJsonContent.length / 2).floor()),
      mockJsonContent.substring((mockJsonContent.length / 2).floor()),
    ];
    for (final chunk in chunks) {
      await Future.delayed(const Duration(milliseconds: 10));
      yield chunk;
    }
  }

  /// 步骤 3: 全流程流解析与规则提取 (Parsing & Extraction Pipeline)
  Future<ParsedSubscriptionContent> processSubscriptionDataStream({
    required PhoneSubscriptionPayload subscription,
    required String mockStreamJson,
  }) async {
    _statusController.add(SubscriptionLoadStatusEvent(
      subscriptionId: subscription.id,
      status: SubscriptionStatus.loading,
      message: '正在从流解压数据载荷...',
    ));

    final StringBuffer buffer = StringBuffer();
    await for (final chunk in fetchRawDataStream(subscription.downloadUrl ?? '', mockStreamJson)) {
      buffer.write(chunk);
    }

    final String fullJson = buffer.toString();
    final Map<String, dynamic> decoded = jsonDecode(fullJson) as Map<String, dynamic>;

    final List<PhoneRuleEntity> phoneRules = [];
    final List<RegexRuleEntity> regexRules = [];
    final List<PhoneContactEntry> contacts = [];

    // 解析电话黑白名单规则
    if (decoded.containsKey('phoneRules')) {
      final list = decoded['phoneRules'] as List<dynamic>;
      for (final item in list) {
        final map = item as Map<String, dynamic>;
        phoneRules.add(PhoneRuleEntity(
          id: map['id'] as String,
          name: map['name'] as String,
          phoneNumber: map['phoneNumber'] as String,
          actionType: map['actionType'] as String? ?? 'block',
          subscriptionId: subscription.id,
        ));
      }
    }

    // 解析正则号段规则
    if (decoded.containsKey('regexRules')) {
      final list = decoded['regexRules'] as List<dynamic>;
      for (final item in list) {
        final map = item as Map<String, dynamic>;
        regexRules.add(RegexRuleEntity(
          id: map['id'] as String,
          name: map['name'] as String,
          pattern: map['pattern'] as String,
          actionType: map['actionType'] as String? ?? 'block',
          subscriptionId: subscription.id,
        ));
      }
    }

    // 解析通讯录名录
    if (decoded.containsKey('contacts')) {
      final list = decoded['contacts'] as List<dynamic>;
      for (final item in list) {
        final map = item as Map<String, dynamic>;
        contacts.add(PhoneContactEntry(
          id: map['id'] as String,
          name: map['name'] as String,
          phoneNumber: (map['phoneNumbers'] as List<dynamic>).first as String,
        ));
      }
    }

    _statusController.add(SubscriptionLoadStatusEvent(
      subscriptionId: subscription.id,
      status: SubscriptionStatus.synced,
      message: '订阅同步完成, 共加载 ${phoneRules.length + regexRules.length + contacts.length} 条规则项',
    ));

    return ParsedSubscriptionContent(
      subscriptionId: subscription.id,
      phoneRules: phoneRules,
      regexRules: regexRules,
      contacts: contacts,
    );
  }

  void dispose() {
    _statusController.close();
  }
}

/// 订阅状态枚举与事件实体 (Status Events & Output Entities)
enum SubscriptionStatus { unsubscribed, subscribing, loading, synced, failed }

class SubscriptionLoadStatusEvent {
  final String subscriptionId;
  final SubscriptionStatus status;
  final String message;

  const SubscriptionLoadStatusEvent({
    required this.subscriptionId,
    required this.status,
    required this.message,
  });
}

class ParsedSubscriptionContent {
  final String subscriptionId;
  final List<PhoneRuleEntity> phoneRules;
  final List<RegexRuleEntity> regexRules;
  final List<PhoneContactEntry> contacts;

  const ParsedSubscriptionContent({
    required this.subscriptionId,
    required this.phoneRules,
    required this.regexRules,
    required this.contacts,
  });

  int get totalItems => phoneRules.length + regexRules.length + contacts.length;
}

void main() {
  group('🔄 订阅全流程数据流测试: 从 Subscribe 注册到 Stream 拼接加载与实体验证', () {
    late SubscriptionPipelineLoader loader;

    setUp(() {
      loader = SubscriptionPipelineLoader();
    });

    tearDown(() {
      loader.dispose();
    });

    test('1. 验证发起订阅 (Subscribe) 阶段: 强实体 Payload 建立与状态切置', () async {
      final statusEvents = <SubscriptionLoadStatusEvent>[];
      loader.statusStream.listen(statusEvents.add);

      final payload = await loader.subscribe(
        subscriptionId: 'sub_spam_pack_2026',
        kind: PhoneSubscriptionKind.phoneRules,
        name: '全国高频骚扰号段订阅包',
        downloadUrl: 'https://rules.example.com/spam_pack.json',
      );

      await Future.delayed(Duration.zero);

      expect(payload.id, equals('sub_spam_pack_2026'));
      expect(payload.displayName, equals('全国高频骚扰号段订阅包'));
      expect(payload.downloadUrl, equals('https://rules.example.com/spam_pack.json'));
      expect(payload.kind.id, equals('phoneRules'));

      expect(loader.activeSubscriptions.length, equals(1));
      expect(statusEvents.first.status, equals(SubscriptionStatus.subscribing));
    });

    test('2. 验证数据流加载 (Loading & Stream) 到解析验证: 电话规则、正则规则、通讯录 100% 正确落盘匹配', () async {
      final statusEvents = <SubscriptionLoadStatusEvent>[];
      loader.statusStream.listen(statusEvents.add);

      final subscription = await loader.subscribe(
        subscriptionId: 'sub_master_rules_v1',
        kind: PhoneSubscriptionKind.rulesManifest,
        name: '综合防骚扰规则全量包',
        downloadUrl: 'https://cdn.rules.org/manifest.json',
      );

      // 模拟服务器分块推送的原始 JSON 数据流
      final mockRawJson = jsonEncode({
        'version': '2.0.0',
        'phoneRules': [
          {
            'id': 'pr_101',
            'name': '境外黑电话 00852',
            'phoneNumber': '+85212345678',
            'actionType': 'block',
          },
          {
            'id': 'pr_102',
            'name': '高危欺诈电话',
            'phoneNumber': '+8619988887777',
            'actionType': 'block',
          }
        ],
        'regexRules': [
          {
            'id': 'rr_201',
            'name': '400 商业推销号段',
            'pattern': r'^(\+86)?400\d{7}$',
            'actionType': 'silence',
          }
        ],
        'contacts': [
          {
            'id': 'ct_301',
            'name': '客服官方热线',
            'phoneNumbers': ['+8610000', '+8610010'],
          }
        ],
      });

      // 执行全流程流解析与加载
      final result = await loader.processSubscriptionDataStream(
        subscription: subscription,
        mockStreamJson: mockRawJson,
      );

      await Future.delayed(Duration.zero);

      // 验证解析总项数
      expect(result.totalItems, equals(4));

      // 验证 PhoneRules 解析
      expect(result.phoneRules.length, equals(2));
      expect(result.phoneRules[0].id, equals('pr_101'));
      expect(result.phoneRules[0].phoneNumber, equals('+85212345678'));
      expect(result.phoneRules[0].subscriptionId, equals('sub_master_rules_v1'));
      expect(result.phoneRules[0].isSubscribed, isTrue);

      // 验证 RegexRules 解析
      expect(result.regexRules.length, equals(1));
      expect(result.regexRules[0].pattern, equals(r'^(\+86)?400\d{7}$'));
      expect(result.regexRules[0].actionType, equals('silence'));
      expect(result.regexRules[0].subscriptionId, equals('sub_master_rules_v1'));
      expect(result.regexRules[0].isSubscribed, isTrue);

      // 验证 Contacts 解析
      expect(result.contacts.length, equals(1));
      expect(result.contacts[0].name, equals('客服官方热线'));
      expect(result.contacts[0].phoneNumber, equals('+8610000'));

      // 验证全流程状态事件流 (subscribing -> loading -> synced)
      expect(statusEvents.map((e) => e.status), containsAllInOrder([
        SubscriptionStatus.subscribing,
        SubscriptionStatus.loading,
        SubscriptionStatus.synced,
      ]));
    });
  });
}
