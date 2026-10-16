import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yourcallyourrule/features/deletion_proposer/models/server_verification_report.dart';

part 'sync_payload.freezed.dart';
part 'sync_payload.g.dart';

/// 强类型的同步 Payload 多态联合类，替代手写的自由 Map，保持 pending_operations 队列百分百兼容。
@freezed
sealed class SyncPayload with _$SyncPayload {
  const factory SyncPayload.numberUpdate({
    required String phoneNumber,
    required String label,
    required int action,
    int? count,
    String? countryIsoCode,
  }) = NumberUpdatePayload;

  const factory SyncPayload.proposeDeletion({
    required ServerVerificationReport report,
    required String timestamp,
  }) = ProposeDeletionPayload;

  const factory SyncPayload.voteDeletion({
    required String voteType,
    Map<String, dynamic>? additionalData,
    required String timestamp,
  }) = VoteDeletionPayload;

  factory SyncPayload.fromJson(Map<String, dynamic> json) => _$SyncPayloadFromJson(json);
}
