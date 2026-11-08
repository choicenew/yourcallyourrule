import 'package:drift/drift.dart';
import 'package:pyro_phone_call_history_protocol/pyro_phone_call_history_protocol.dart';
import 'package:yourcallyourrule/data/database/local/local_database.dart';

/// 自动可生成的映射器工具 (CallLogEntry <-> Drift Companion/Data)
abstract class CallLogModelMapper {
  static CallLogEntry fromData(CallLog data) {
    return CallLogEntry(
      id: data.id,
      phoneNumber: data.phoneNumber,
      callType: data.callType.name,
      timestamp: data.timestamp.millisecondsSinceEpoch,
      durationSeconds: data.duration != null ? (data.duration! / 1000).round() : null,
      name: data.name,
      location: data.countryIso,
    );
  }

  static CallHistoryCompanion toCompanion(CallLogEntry entry) {
    return CallHistoryCompanion(
      id: Value(entry.id),
      phoneNumber: Value(entry.phoneNumber),
      name: Value(entry.name),
      timestamp: Value(DateTime.fromMillisecondsSinceEpoch(entry.timestamp ?? DateTime.now().millisecondsSinceEpoch).toIso8601String()),
      duration: Value(entry.durationSeconds != null ? entry.durationSeconds! * 1000 : null),
      callType: Value(entry.callType),
      countryIso: Value(entry.location),
    );
  }
}