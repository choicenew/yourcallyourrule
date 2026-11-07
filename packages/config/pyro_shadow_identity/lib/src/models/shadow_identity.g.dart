// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shadow_identity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShadowIdentity _$ShadowIdentityFromJson(Map<String, dynamic> json) =>
    ShadowIdentity(
      id: json['id'] as String,
      name: json['name'] as String,
      isPersonaAccount: json['isPersonaAccount'] as bool? ?? false,
      interestKeywords: (json['interestKeywords'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastAccessedAt: DateTime.parse(json['lastAccessedAt'] as String),
    );

Map<String, dynamic> _$ShadowIdentityToJson(ShadowIdentity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'isPersonaAccount': instance.isPersonaAccount,
      'interestKeywords': instance.interestKeywords,
      'metadata': instance.metadata,
      'createdAt': instance.createdAt.toIso8601String(),
      'lastAccessedAt': instance.lastAccessedAt.toIso8601String(),
    };
