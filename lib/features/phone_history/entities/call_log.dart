import 'package:pyro_phone_call_history_protocol/pyro_phone_call_history_protocol.dart';
import 'local_call_type.dart';

/// 100% 遵照 Package Architecture Protocol 架构：
/// 主 App 绝不重复声明手写 CallLog 实体 Class，全量直接由 pyro_phone_call_history_protocol 中的 CallLogEntry 承载
typedef CallLog = CallLogEntry;

/// 兼容拓展，平滑支持历史字段访问与映射
extension CallLogEntityCompatibility on CallLogEntry {
  LocalCallType get localCallType => LocalCallType.fromString(callType);
  DateTime get dateTime => DateTime.fromMillisecondsSinceEpoch(timestamp ?? DateTime.now().millisecondsSinceEpoch);
  DateTime get timestampDateTime => dateTime;
  int? get durationMs => durationSeconds != null ? durationSeconds! * 1000 : null;
  String? get carrierName => null;
  String? get simDisplayName => null;
  int get simSlotIndex => 0;
  int get subscriptionId => 0;
  List<String>? get labelIds => null;
  String get countryIso => location ?? '';
}