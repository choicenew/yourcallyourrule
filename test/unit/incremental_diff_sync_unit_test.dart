import 'package:flutter_test/flutter_test.dart';
import 'package:yourcallyourrule/core/entities/rule/allowed_blocked_rule.dart';
import 'package:yourcallyourrule/core/entities/rule/phone_rule.dart';
import 'package:yourcallyourrule/core/entities/rule/regex_rule.dart';
import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';
import 'package:yourcallyourrule/core/entities/rule/sim_slot_rule.dart';
import 'package:yourcallyourrule/core/entities/sms/sms_regex_rule.dart';
import 'package:yourcallyourrule/core/entities/subscription/subscription.dart';
import 'package:yourcallyourrule/core/repositories/rule_repository.dart';
import 'package:yourcallyourrule/core/repositories/rule_repository_impl.dart';
import 'package:yourcallyourrule/core/repositories/subscription_repository.dart';
import 'package:yourcallyourrule/core/services/rule_import_export_service.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/core/value_objects/url.dart';
import 'package:yourcallyourrule/data/datasources/local/local_label_datasource.dart';
import 'package:yourcallyourrule/data/datasources/local/local_phone_rule_datasource.dart';
import 'package:yourcallyourrule/data/datasources/local/local_regex_rule_datasource.dart';
import 'package:yourcallyourrule/data/datasources/local/local_sim_slot_rule_datasource.dart';
import 'package:yourcallyourrule/data/models/label_model.dart';
import 'package:yourcallyourrule/data/models/phone_rule_model.dart';
import 'package:yourcallyourrule/data/models/regex_rule_model.dart';
import 'package:yourcallyourrule/data/models/sim_slot_rule_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('RuleRepositoryImpl 批量事务单测断言', () {
    late FakePhoneRuleDataSource fakePhoneDS;
    late FakeRegexRuleDataSource fakeRegexDS;
    late FakeLabelDataSource fakeLabelDS;
    late FakeSimSlotRuleDataSource fakeSimSlotDS;
    late RuleRepositoryImpl repository;

    setUp(() {
      fakePhoneDS = FakePhoneRuleDataSource();
      fakeRegexDS = FakeRegexRuleDataSource();
      fakeLabelDS = FakeLabelDataSource();
      fakeSimSlotDS = FakeSimSlotRuleDataSource();
      repository = RuleRepositoryImpl(
        fakePhoneDS,
        fakeRegexDS,
        fakeLabelDS,
        fakeSimSlotDS,
      );
    });

    test('1. saveAll 批量保存时分流调用不同 Data Source 的 insertAll', () async {
      final phoneRule = PhoneRule(
        id: 'p1',
        name: 'Phone 1',
        phoneNumber: PhoneNumber('+8613800138000'),
        action: RuleAction.block,
      );
      final regexRule = RegexRule(
        id: 'r1',
        name: 'Regex 1',
        pattern: r'^138.*',
        action: RuleAction.block,
      );

      final result = await repository.saveAll([phoneRule, regexRule]);

      expect(result.length, equals(2));
      expect(fakePhoneDS.insertedModels.length, equals(1));
      expect(fakePhoneDS.insertedModels.first.id, equals('p1'));
      expect(fakeRegexDS.insertedModels.length, equals(1));
      expect(fakeRegexDS.insertedModels.first.id, equals('r1'));
    });

    test('2. deleteAll 批量删除时分流调用不同 Data Source 的 deleteAll', () async {
      final phoneRule = PhoneRule(
        id: 'p1',
        name: 'Phone 1',
        phoneNumber: PhoneNumber('+8613800138000'),
        action: RuleAction.block,
      );
      final regexRule = RegexRule(
        id: 'r1',
        name: 'Regex 1',
        pattern: r'^138.*',
        action: RuleAction.block,
      );

      final success = await repository.deleteAll([phoneRule, regexRule]);

      expect(success, isTrue);
      expect(fakePhoneDS.deletedIds, contains('p1'));
      expect(fakeRegexDS.deletedIds, contains('r1'));
    });
  });

  group('RuleImportExportService Isolate 线程解析单测断言', () {
    late FakeRuleRepository fakeRepo;
    late RuleImportExportService service;

    setUp(() {
      fakeRepo = FakeRuleRepository();
      service = RuleImportExportService(fakeRepo);
    });

    test('3. parseJsonData 在 Isolate 副线程中成功解析 JSON 并规范化 bool 字段', () async {
      final jsonStr = '''
      [
        {
          "id": "rule_100",
          "name": "Test Rule",
          "ruleType": "phone_rule",
          "action": "block",
          "phoneNumber": "+8613900000000",
          "isEnabled": 1
        }
      ]
      ''';

      final rules = await service.parseJsonData(jsonStr);

      expect(rules.length, equals(1));
      final rule = rules.first as PhoneRule;
      expect(rule.id, equals('rule_100'));
      expect(rule.phoneNumber.value, equals('+8613900000000'));
      expect(rule.isEnabled, isTrue);
    });

    test('4. parseCsvData 成功解析 CSV 格式规则明细', () async {
      final csvStr = 'name,phoneNumber,labelId,action,isEnabled\n'
          'Spam Call,+8613888888888,default,block,true\n';

      final rules = await service.parseCsvData(csvStr);

      expect(rules.length, equals(1));
      final rule = rules.first as PhoneRule;
      expect(rule.name, equals('Spam Call'));
      expect(rule.phoneNumber.value, equals('+8613888888888'));
    });
  });
}

class FakePhoneRuleDataSource implements LocalPhoneRuleDataSource {
  final List<PhoneRuleModel> insertedModels = [];
  final List<String> deletedIds = [];

  @override
  Future<List<String>> insertAll(List<PhoneRuleModel> models) async {
    insertedModels.addAll(models);
    return models.map((m) => m.id).toList();
  }

  @override
  Future<int> deleteAll(List<String> ids) async {
    deletedIds.addAll(ids);
    return ids.length;
  }

  @override
  Future<List<PhoneRuleModel>> getAll() async => insertedModels;

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class FakeRegexRuleDataSource implements LocalRegexRuleDataSource {
  final List<RegexRuleModel> insertedModels = [];
  final List<String> deletedIds = [];

  @override
  Future<List<String>> insertAll(List<RegexRuleModel> models) async {
    insertedModels.addAll(models);
    return models.map((m) => m.id).toList();
  }

  @override
  Future<int> deleteAll(List<String> ids) async {
    deletedIds.addAll(ids);
    return ids.length;
  }

  @override
  Future<List<RegexRuleModel>> getAll() async => insertedModels;

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class FakeLabelDataSource implements LocalLabelDataSource {
  final List<LabelModel> insertedModels = [];
  final List<String> deletedIds = [];

  @override
  Future<List<String>> insertAll(List<LabelModel> models) async {
    insertedModels.addAll(models);
    return models.map((m) => m.id).toList();
  }

  @override
  Future<int> deleteAll(List<String> ids) async {
    deletedIds.addAll(ids);
    return ids.length;
  }

  @override
  Future<List<LabelModel>> getAll() async => insertedModels;

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class FakeSimSlotRuleDataSource implements LocalSimSlotRuleDataSource {
  final List<SimSlotRuleModel> insertedModels = [];
  final List<String> deletedIds = [];

  @override
  Future<List<String>> insertAll(List<SimSlotRuleModel> models) async {
    insertedModels.addAll(models);
    return models.map((m) => m.id).toList();
  }

  @override
  Future<int> deleteAll(List<String> ids) async {
    deletedIds.addAll(ids);
    return ids.length;
  }

  @override
  Future<List<SimSlotRuleModel>> getAll() async => insertedModels;

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class FakeRuleRepository implements RuleRepository {
  final List<RuleBase> storedRules = [];
  final List<RuleBase> savedBatch = [];
  final List<RuleBase> deletedBatch = [];

  @override
  Future<List<RuleBase>> getAll() async => storedRules;

  @override
  Future<List<RuleBase>> saveAll(List<RuleBase> entities) async {
    savedBatch.addAll(entities);
    storedRules.addAll(entities);
    return entities;
  }

  @override
  Future<bool> deleteAll(List<RuleBase> entities) async {
    deletedBatch.addAll(entities);
    storedRules.removeWhere((r) => entities.any((e) => e.id == r.id));
    return true;
  }

  @override
  RuleBase createRuleFromMap(Map<String, dynamic> map) {
    return PhoneRule.fromMap(map);
  }

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class FakeSubscriptionRepository implements SubscriptionRepository {
  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
