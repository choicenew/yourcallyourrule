import 'dart:async';
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:yourcallyourrule/features/initial_setup/models/setup_config.dart';
import 'package:pyro_phone_subscription_protocol/pyro_phone_subscription_protocol.dart';
import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:pyro_phone_contacts_protocol/pyro_phone_contacts_protocol.dart';

/// InitialSetup 订阅与加载全流程管道模拟引擎 (Initial Setup Pipeline Orchestrator)
class InitialSetupSubscriptionOrchestrator {
  final List<PhoneSubscriptionPayload> activeSubscriptions = [];

  /// 1. 加载 InitialSetup 配置文件与数据提取 (SetupConfig Parsing)
  SetupConfig parseSetupConfigJson(String rawJson) {
    final Map<String, dynamic> decoded = jsonDecode(rawJson) as Map<String, dynamic>;
    return SetupConfig.fromMap(decoded);
  }

  /// 2. 根据国家/地区选择规则包并触发 Subscribe (Subscribe Country Rule Pack)
  Future<PhoneSubscriptionPayload> subscribeCountryRulePack({
    required CountryData country,
    bool useCdn = true,
  }) async {
    final downloadUrl = country.getEffectiveUrl(useCdn: useCdn);
    final payload = PhoneSubscriptionPayload(
      payloadId: 'sub_init_${country.id}',
      kind: PhoneSubscriptionKind.rulesManifest,
      rawJsonMap: {
        'name': '${country.name} 默认防骚扰规则包',
        'countryCode': country.countryCode,
        'downloadUrl': downloadUrl,
        'ruleType': country.ruleType,
      },
      timestamp: DateTime.now().millisecondsSinceEpoch,
    );

    activeSubscriptions.add(payload);
    return payload;
  }

  /// 3. 全流程接收下载流并解析提取强规则实体 (Fetch, Parse & Load Pipeline)
  Future<List<dynamic>> processSubscriptionDownloadStream({
    required PhoneSubscriptionPayload payload,
    required String mockManifestContent,
  }) async {
    final Map<String, dynamic> decoded = jsonDecode(mockManifestContent) as Map<String, dynamic>;

    final List<PhoneRuleEntity> phoneRules = [];
    final List<RegexRuleEntity> regexRules = [];
    final List<PhoneContactEntry> contacts = [];

    if (decoded.containsKey('phoneRules')) {
      final list = decoded['phoneRules'] as List<dynamic>;
      for (final item in list) {
        final map = item as Map<String, dynamic>;
        phoneRules.add(PhoneRuleEntity(
          id: map['id'] as String,
          name: map['name'] as String,
          phoneNumber: map['phoneNumber'] as String,
          actionType: map['actionType'] as String? ?? 'block',
          subscriptionId: payload.id,
        ));
      }
    }

    if (decoded.containsKey('regexRules')) {
      final list = decoded['regexRules'] as List<dynamic>;
      for (final item in list) {
        final map = item as Map<String, dynamic>;
        regexRules.add(RegexRuleEntity(
          id: map['id'] as String,
          name: map['name'] as String,
          pattern: map['pattern'] as String,
          actionType: map['actionType'] as String? ?? 'block',
          subscriptionId: payload.id,
        ));
      }
    }

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

    return [...phoneRules, ...regexRules, ...contacts];
  }
}

void main() {
  group('🚀 InitialSetup 初始化数据 -> 订阅 Subscribe -> 数据流加载全流程测试', () {
    late InitialSetupSubscriptionOrchestrator orchestrator;

    setUp(() {
      orchestrator = InitialSetupSubscriptionOrchestrator();
    });

    test('1. 验证 InitialSetup 引导配置文件解析与 SetupConfig / CountryData 强实体构建', () {
      final String mockAppDeltaSetupConfig = jsonEncode({
        'config_version': '3.2.0',
        'rulesets': [
          {
            'source_id': 'cn_rules',
            'country_code': 'CN',
            'name': '中国防骚扰全量规则库',
            'icon_url': 'https://cdn.example.com/flags/cn.png',
            'description': '包含骚扰号段、外呼推销及黑名单',
            'rule_type': 'phone_and_regex',
            'manifest_url': 'https://raw.githubusercontent.com/choicenew/rules/main/cn_manifest.json',
            'cdn_manifest_url': 'https://cdn.jsdelivr.net/gh/choicenew/rules@main/cn_manifest.json',
          },
          {
            'source_id': 'us_rules',
            'country_code': 'US',
            'name': 'United States Spam Shield',
            'icon_url': 'https://cdn.example.com/flags/us.png',
            'description': 'FTC Robocall & Telemarket Rules',
            'rule_type': 'regex',
            'manifest_url': 'https://raw.githubusercontent.com/choicenew/rules/main/us_manifest.json',
            'cdn_manifest_url': 'https://cdn.jsdelivr.net/gh/choicenew/rules@main/us_manifest.json',
          }
        ],
        'plugins_recommendation': {
          'title': '推荐插件',
          'description': '增强型在线反查引擎',
          'web_portal_url': 'https://plugins.example.com/portal',
        }
      });

      final config = orchestrator.parseSetupConfigJson(mockAppDeltaSetupConfig);

      expect(config.version, equals('3.2.0'));
      expect(config.countriesData.length, equals(2));

      final cnData = config.countriesData.firstWhere((c) => c.countryCode == 'CN');
      expect(cnData.name, equals('中国防骚扰全量规则库'));
      expect(cnData.getEffectiveUrl(useCdn: true), equals('https://cdn.jsdelivr.net/gh/choicenew/rules@main/cn_manifest.json'));
      expect(cnData.getEffectiveUrl(useCdn: false), equals('https://raw.githubusercontent.com/choicenew/rules/main/cn_manifest.json'));

      expect(config.pluginsRecommendation?.title, equals('推荐插件'));
    });

    test('2. 验证 InitialSetup 选定 CN 规则库 -> 触发 Subscribe 订阅流程', () async {
      final country = CountryData(
        id: 'cn_rules',
        countryCode: 'CN',
        name: '中国防骚扰全量规则库',
        iconUrl: 'https://cdn.example.com/flags/cn.png',
        description: '包含骚扰号段、外呼推销及黑名单',
        ruleType: 'phone_and_regex',
        manifestUrl: 'https://raw.githubusercontent.com/choicenew/rules/main/cn_manifest.json',
        cdnManifestUrl: 'https://cdn.jsdelivr.net/gh/choicenew/rules@main/cn_manifest.json',
      );

      final subscriptionPayload = await orchestrator.subscribeCountryRulePack(
        country: country,
        useCdn: true,
      );

      expect(subscriptionPayload.id, equals('sub_init_cn_rules'));
      expect(subscriptionPayload.displayName, equals('中国防骚扰全量规则库 默认防骚扰规则包'));
      expect(subscriptionPayload.downloadUrl, equals('https://cdn.jsdelivr.net/gh/choicenew/rules@main/cn_manifest.json'));
      expect(subscriptionPayload.kind.id, equals('rulesManifest'));

      expect(orchestrator.activeSubscriptions.length, equals(1));
    });

    test('3. 验证从 Subscribe 到 Manifest 规则流加载落盘与拦截匹配全流程测试', () async {
      final country = CountryData(
        id: 'cn_rules',
        countryCode: 'CN',
        name: '中国防骚扰全量规则库',
        iconUrl: 'https://cdn.example.com/flags/cn.png',
        description: '测试规则包',
        ruleType: 'phone_and_regex',
        manifestUrl: 'https://cdn.jsdelivr.net/gh/choicenew/rules@main/cn_manifest.json',
      );

      final payload = await orchestrator.subscribeCountryRulePack(country: country, useCdn: true);

      // 模拟服务器下载得到的真实 Manifest JSON
      final mockCnManifestJson = jsonEncode({
        'version': '2026.11.14',
        'phoneRules': [
          {
            'id': 'init_pr_001',
            'name': '高频诈骗电话',
            'phoneNumber': '+8695212345',
            'actionType': 'block',
          }
        ],
        'regexRules': [
          {
            'id': 'init_rr_002',
            'name': '951/952 商业广告推销号段',
            'pattern': r'^(\+86)?95[12]\d{6,7}$',
            'actionType': 'block',
          }
        ],
        'contacts': [
          {
            'id': 'init_ct_003',
            'name': '防诈骗求助热线',
            'phoneNumbers': ['+8696110'],
          }
        ]
      });

      final loadedEntities = await orchestrator.processSubscriptionDownloadStream(
        payload: payload,
        mockManifestContent: mockCnManifestJson,
      );

      expect(loadedEntities.length, equals(3));

      final phoneRules = loadedEntities.whereType<PhoneRuleEntity>().toList();
      final regexRules = loadedEntities.whereType<RegexRuleEntity>().toList();
      final contacts = loadedEntities.whereType<PhoneContactEntry>().toList();

      expect(phoneRules.length, equals(1));
      expect(phoneRules[0].phoneNumber, equals('+8695212345'));
      expect(phoneRules[0].subscriptionId, equals('sub_init_cn_rules'));

      expect(regexRules.length, equals(1));
      expect(regexRules[0].matches('+86952888888'), isTrue);

      expect(contacts.length, equals(1));
      expect(contacts[0].name, equals('防诈骗求助热线'));
      expect(contacts[0].phoneNumber, equals('+8696110'));
    });
  });
}
