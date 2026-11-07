import 'package:freezed_annotation/freezed_annotation.dart';

part 'proposal_entity.freezed.dart';
part 'proposal_entity.g.dart';

/// 纯数据驱动删除提案强实体 (ProposalEntity)
@freezed
abstract class ProposalEntity with _$ProposalEntity {
  const ProposalEntity._();

  const factory ProposalEntity({
    required String id,
    required String phoneNumber,
    required String reason,
    @Default('pending') String status,
    @Default(0) int voteCount,
    int? createdAt,
  }) = _ProposalEntity;

  factory ProposalEntity.fromJson(Map<String, dynamic> json) => _$ProposalEntityFromJson(json);

  factory ProposalEntity.fromMap(Map<String, dynamic> map) => ProposalEntity.fromJson(map);

  Map<String, dynamic> toMap() => toJson();
}
