import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:pyro_phone_call_history_protocol/pyro_phone_call_history_protocol.dart';
import 'package:pyro_phone_contacts_protocol/pyro_phone_contacts_protocol.dart';
import 'package:pyro_phone_marking_protocol/pyro_phone_marking_protocol.dart';

/// 强类型全流程数据流模拟处理引擎 (Simulated Call Filter Pipeline Engine)
class CallFilterFullPipelineEngine {
  final List<PhoneContactEntry> contacts;
  final List<PhoneRuleEntity> phoneRules;
  final List<RegexRuleEntity> regexRules;
  final List<LabelPhoneEntry> labelPhones;

  CallFilterFullPipelineEngine({
    this.contacts = const [],
    this.phoneRules = const [],
    this.regexRules = const [],
    this.labelPhones = const [],
  });

  /// 执行全流程来电拦截与决策匹配数据流 (Full Pipeline Evaluation)
  PipelineEvaluationResult evaluateIncomingCall({
    required String phoneNumber,
    required int simSlotIndex,
    String? carrierName,
    bool blockUnknownNumbers = false,
  }) {
    final startTime = DateTime.now();

    // 阶段 1: 联系人白名单全流程匹配 (Contacts Whitelist Stage)
    final contactMatch = contacts.any(
      (c) => c.phoneNumber == phoneNumber || c.phoneNumber.endsWith(phoneNumber.replaceAll('+86', '')),
    );
    if (contactMatch) {
      return PipelineEvaluationResult(
        phoneNumber: phoneNumber,
        simSlotIndex: simSlotIndex,
        action: 'allow',
        matchedReason: '白名单联系人直接放行',
        stage: 'ContactsWhitelist',
        evaluationTimeMs: DateTime.now().difference(startTime).inMilliseconds,
      );
    }

    // 阶段 2: 电话号码规则/黑名单匹配 (Phone Rules Stage)
    for (final rule in phoneRules.where((r) => r.isEnabled)) {
      if (rule.phoneNumber == phoneNumber || phoneNumber.contains(rule.phoneNumber ?? '')) {
        return PipelineEvaluationResult(
          phoneNumber: phoneNumber,
          simSlotIndex: simSlotIndex,
          action: rule.actionType,
          matchedReason: '精准号码规则匹配: ${rule.name}',
          stage: 'PhoneRules',
          ruleId: rule.id,
          evaluationTimeMs: DateTime.now().difference(startTime).inMilliseconds,
        );
      }
    }

    // 阶段 3: 正则表达式规则匹配 (Regex Rules Stage)
    for (final rule in regexRules.where((r) => r.isEnabled)) {
      final regExp = RegExp(rule.pattern);
      if (regExp.hasMatch(phoneNumber)) {
        return PipelineEvaluationResult(
          phoneNumber: phoneNumber,
          simSlotIndex: simSlotIndex,
          action: rule.actionType,
          matchedReason: '正则表达式规则匹配: ${rule.name} (${rule.pattern})',
          stage: 'RegexRules',
          ruleId: rule.id,
          evaluationTimeMs: DateTime.now().difference(startTime).inMilliseconds,
        );
      }
    }

    // 阶段 4: 标记号码阈值匹配 (Community Labeling Stage)
    final labelMatch = labelPhones.firstWhere(
      (l) => l.phoneNumber == phoneNumber,
      orElse: () => const LabelPhoneEntry(id: '', phoneNumber: '', labelId: '', isEnabled: false),
    );
    if (labelMatch.isEnabled && labelMatch.labelId.isNotEmpty) {
      return PipelineEvaluationResult(
        phoneNumber: phoneNumber,
        simSlotIndex: simSlotIndex,
        action: 'block',
        matchedReason: '社区云标记拦截: 标记类型 [${labelMatch.labelId}]',
        stage: 'CommunityLabel',
        evaluationTimeMs: DateTime.now().difference(startTime).inMilliseconds,
      );
    }

    // 阶段 5: 默认策略 (Default Strategy Stage)
    if (blockUnknownNumbers) {
      return PipelineEvaluationResult(
        phoneNumber: phoneNumber,
        simSlotIndex: simSlotIndex,
        action: 'block',
        matchedReason: '陌生号码拦截策略',
        stage: 'DefaultUnknownPolicy',
        evaluationTimeMs: DateTime.now().difference(startTime).inMilliseconds,
      );
    }

    return PipelineEvaluationResult(
      phoneNumber: phoneNumber,
      simSlotIndex: simSlotIndex,
      action: 'allow',
      matchedReason: '默认正常放行',
      stage: 'DefaultPass',
      evaluationTimeMs: DateTime.now().difference(startTime).inMilliseconds,
    );
  }
}

/// 拦截全流程决策输出实体 (Pipeline Result Entity)
class PipelineEvaluationResult {
  final String phoneNumber;
  final int simSlotIndex;
  final String action; // 'allow', 'block', 'silence'
  final String matchedReason;
  final String stage;
  final String? ruleId;
  final int evaluationTimeMs;

  const PipelineEvaluationResult({
    required this.phoneNumber,
    required this.simSlotIndex,
    required this.action,
    required this.matchedReason,
    required this.stage,
    this.ruleId,
    required this.evaluationTimeMs,
  });
}

void main() {
  group('🛡️ 全流程来电拦截与过滤匹配数据流 (Full Call Filter Pipeline Data Flow)', () {
    late CallFilterFullPipelineEngine engine;

    setUp(() {
      engine = CallFilterFullPipelineEngine(
        contacts: const [
          PhoneContactEntry(
            id: 'c_1',
            name: '张三 (公司同事)',
            phoneNumber: '+8613900001111',
          ),
        ],
        phoneRules: const [
          PhoneRuleEntity(
            id: 'r_phone_1',
            name: '黑名单广告中介',
            phoneNumber: '+8613899990000',
            actionType: 'block',
            isEnabled: true,
          ),
        ],
        regexRules: const [
          RegexRuleEntity(
            id: 'r_regex_1',
            name: '骚扰电话号段 (170/171虚拟卡)',
            pattern: r'^(\+86)?17[01]\d{8}$',
            actionType: 'block',
            isEnabled: true,
          ),
        ],
        labelPhones: const [
          LabelPhoneEntry(
            id: 'l_1',
            phoneNumber: '+8618600008888',
            labelId: 'label_spam_fraud',
            isEnabled: true,
          ),
        ],
      );
    });

    test('全流程数据流 1. 白名单联系人来电 -> 触发 Stage 1 (ContactsWhitelist) 拦截器直接放行', () {
      final result = engine.evaluateIncomingCall(
        phoneNumber: '+8613900001111',
        simSlotIndex: 0,
      );

      expect(result.action, equals('allow'));
      expect(result.stage, equals('ContactsWhitelist'));
      expect(result.matchedReason, contains('白名单'));
    });

    test('全流程数据流 2. 精准黑名单号码来电 -> 触发 Stage 2 (PhoneRules) 决策阻断并返回 Rule ID', () {
      final result = engine.evaluateIncomingCall(
        phoneNumber: '+8613899990000',
        simSlotIndex: 1,
      );

      expect(result.action, equals('block'));
      expect(result.stage, equals('PhoneRules'));
      expect(result.ruleId, equals('r_phone_1'));
      expect(result.matchedReason, contains('黑名单广告中介'));
    });

    test('全流程数据流 3. 170/171 虚拟骚扰号段来电 -> 触发 Stage 3 (RegexRules) 正则表达式规则决策阻断', () {
      final result = engine.evaluateIncomingCall(
        phoneNumber: '+8617012345678',
        simSlotIndex: 0,
      );

      expect(result.action, equals('block'));
      expect(result.stage, equals('RegexRules'));
      expect(result.ruleId, equals('r_regex_1'));
      expect(result.matchedReason, contains('170/171'));
    });

    test('全流程数据流 4. 社区高频标记号码来电 -> 触发 Stage 4 (CommunityLabel) 标记类型阈值阻断', () {
      final result = engine.evaluateIncomingCall(
        phoneNumber: '+8618600008888',
        simSlotIndex: 1,
      );

      expect(result.action, equals('block'));
      expect(result.stage, equals('CommunityLabel'));
      expect(result.matchedReason, contains('label_spam_fraud'));
    });

    test('全流程数据流 5. 开启“拦截陌生人”策略 -> 触发 Stage 5 (DefaultUnknownPolicy) 拦截无记录号码', () {
      final result = engine.evaluateIncomingCall(
        phoneNumber: '+8615011112222',
        simSlotIndex: 0,
        blockUnknownNumbers: true,
      );

      expect(result.action, equals('block'));
      expect(result.stage, equals('DefaultUnknownPolicy'));
    });

    test('全流程数据流 6. 正常未标记号码来电 -> 经过全部 Stage 无阻断 -> 阶段 DefaultPass 放行并归档日志', () {
      final result = engine.evaluateIncomingCall(
        phoneNumber: '+8615011112222',
        simSlotIndex: 0,
        blockUnknownNumbers: false,
      );

      expect(result.action, equals('allow'));
      expect(result.stage, equals('DefaultPass'));

      // 验证 CallLogEntry 日志归档生成数据流
      final callLog = CallLogEntry(
        id: 'log_999',
        phoneNumber: result.phoneNumber,
        name: '未知号码',
        timestamp: DateTime.now().millisecondsSinceEpoch,
        callType: 'incoming',
      );
      expect(callLog.phoneNumber, equals('+8615011112222'));
      expect(callLog.callType, equals('incoming'));
    });
  });
}
