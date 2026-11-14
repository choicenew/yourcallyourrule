// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone_contact_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PhoneContactEntry _$PhoneContactEntryFromJson(Map<String, dynamic> json) =>
    _PhoneContactEntry(
      id: json['id'] as String,
      phoneNumber: json['phoneNumber'] as String,
      name: json['name'] as String,
      avatar: json['avatar'] as String?,
      url: json['url'] as String?,
      note: json['note'] as String?,
      labelIds: json['labelIds'] as String?,
      isFavorite: (json['isFavorite'] as num?)?.toInt() ?? 0,
      lastUpdated: json['lastUpdated'] as String? ?? '',
    );

Map<String, dynamic> _$PhoneContactEntryToJson(_PhoneContactEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'phoneNumber': instance.phoneNumber,
      'name': instance.name,
      'avatar': instance.avatar,
      'url': instance.url,
      'note': instance.note,
      'labelIds': instance.labelIds,
      'isFavorite': instance.isFavorite,
      'lastUpdated': instance.lastUpdated,
    };
