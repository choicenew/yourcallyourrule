import 'package:pyro_phone_caller_identity_protocol/pyro_phone_caller_identity_protocol.dart';
import 'package:pyro_phone_contacts_protocol/pyro_phone_contacts_protocol.dart';
import 'package:pyro_phone_marking_protocol/pyro_phone_marking_protocol.dart';

/// 呼叫评估诊断报告（用于号码排错、验证与 Dry-Run 模拟）
class CallEvaluationReport {
  final CallerIdData? callerIdData;
  final PhoneContactEntry? matchedContact;
  final LabelPhoneEntry? matchedLabel;
  final Map<String, bool> rulesResults;

  const CallEvaluationReport({
    this.callerIdData,
    this.matchedContact,
    this.matchedLabel,
    this.rulesResults = const {},
  });
}
