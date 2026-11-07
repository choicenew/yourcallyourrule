// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone_contact_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PhoneContactEntry _$PhoneContactEntryFromJson(Map<String, dynamic> json) =>
    _PhoneContactEntry(
      id: json['id'] as String,
      displayName: json['displayName'] as String,
      phoneNumbers: (json['phoneNumbers'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      photoUrl: json['photoUrl'] as String?,
      isStarred: json['isStarred'] as bool? ?? false,
    );

Map<String, dynamic> _$PhoneContactEntryToJson(_PhoneContactEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'displayName': instance.displayName,
      'phoneNumbers': instance.phoneNumbers,
      'photoUrl': instance.photoUrl,
      'isStarred': instance.isStarred,
    };
