// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proposal_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProposalEntity _$ProposalEntityFromJson(Map<String, dynamic> json) =>
    _ProposalEntity(
      id: json['id'] as String,
      phoneNumber: json['phoneNumber'] as String,
      reason: json['reason'] as String,
      status: json['status'] as String? ?? 'pending',
      voteCount: (json['voteCount'] as num?)?.toInt() ?? 0,
      createdAt: (json['createdAt'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProposalEntityToJson(_ProposalEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'phoneNumber': instance.phoneNumber,
      'reason': instance.reason,
      'status': instance.status,
      'voteCount': instance.voteCount,
      'createdAt': instance.createdAt,
    };
