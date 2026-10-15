// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proposal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Proposal _$ProposalFromJson(Map<String, dynamic> json) => _Proposal(
  phoneNumber: json['phoneNumber'] as String,
  proposalStartTime: DateTime.parse(json['proposalStartTime'] as String),
  status: $enumDecode(_$ProposalStatusEnumMap, json['status']),
  highestRiskLevel: $enumDecode(_$RiskLevelEnumMap, json['highestRiskLevel']),
  proposalCount: (json['proposalCount'] as num).toInt(),
  verifiedOwnerCount: (json['verifiedOwnerCount'] as num).toInt(),
  lastUpdated: DateTime.parse(json['lastUpdated'] as String),
  verificationReportJson: json['verificationReportJson'] as String?,
  labelsJson: json['labelsJson'] as String?,
);

Map<String, dynamic> _$ProposalToJson(_Proposal instance) => <String, dynamic>{
  'phoneNumber': instance.phoneNumber,
  'proposalStartTime': instance.proposalStartTime.toIso8601String(),
  'status': _$ProposalStatusEnumMap[instance.status]!,
  'highestRiskLevel': _$RiskLevelEnumMap[instance.highestRiskLevel]!,
  'proposalCount': instance.proposalCount,
  'verifiedOwnerCount': instance.verifiedOwnerCount,
  'lastUpdated': instance.lastUpdated.toIso8601String(),
  'verificationReportJson': instance.verificationReportJson,
  'labelsJson': instance.labelsJson,
};

const _$ProposalStatusEnumMap = {
  ProposalStatus.pending: 'pending',
  ProposalStatus.approved: 'approved',
  ProposalStatus.rejected: 'rejected',
  ProposalStatus.expired: 'expired',
};

const _$RiskLevelEnumMap = {
  RiskLevel.verified: 'verified',
  RiskLevel.low: 'low',
  RiskLevel.medium: 'medium',
  RiskLevel.high: 'high',
};
