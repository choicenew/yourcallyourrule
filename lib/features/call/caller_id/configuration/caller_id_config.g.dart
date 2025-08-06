// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'caller_id_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CallerIdConfig _$CallerIdConfigFromJson(Map<String, dynamic> json) =>
    _CallerIdConfig(
      backgroundColorStart: const ColorConverter()
          .fromJson((json['backgroundColorStart'] as num).toInt()),
      backgroundColorEnd: const ColorConverter()
          .fromJson((json['backgroundColorEnd'] as num).toInt()),
      textNameColor: const ColorConverter()
          .fromJson((json['textNameColor'] as num).toInt()),
      textNumberColor: const ColorConverter()
          .fromJson((json['textNumberColor'] as num).toInt()),
      textLocationColor: const ColorConverter()
          .fromJson((json['textLocationColor'] as num).toInt()),
      textCarrierColor: const ColorConverter()
          .fromJson((json['textCarrierColor'] as num).toInt()),
      textCountryNameColor: const ColorConverter()
          .fromJson((json['textCountryNameColor'] as num).toInt()),
      textLabelsColor: const ColorConverter()
          .fromJson((json['textLabelsColor'] as num).toInt()),
      textCountColor: const ColorConverter()
          .fromJson((json['textCountColor'] as num).toInt()),
      textNumberTypeColor: const ColorConverter()
          .fromJson((json['textNumberTypeColor'] as num).toInt()),
      textIconLabelColor: const ColorConverter()
          .fromJson((json['textIconLabelColor'] as num).toInt()),
      textIconLocationColor: const ColorConverter()
          .fromJson((json['textIconLocationColor'] as num).toInt()),
      textIconCallTypeColor: const ColorConverter()
          .fromJson((json['textIconCallTypeColor'] as num).toInt()),
      avatarBorderColor: const ColorConverter()
          .fromJson((json['avatarBorderColor'] as num).toInt()),
      textStirColor: const ColorConverter()
          .fromJson((json['textStirColor'] as num).toInt()),
      textSimCardColor: const ColorConverter()
          .fromJson((json['textSimCardColor'] as num).toInt()),
      nameFontSize: (json['nameFontSize'] as num).toDouble(),
      numberFontSize: (json['numberFontSize'] as num).toDouble(),
      locationFontSize: (json['locationFontSize'] as num).toDouble(),
      carrierFontSize: (json['carrierFontSize'] as num).toDouble(),
      countryNameFontSize: (json['countryNameFontSize'] as num).toDouble(),
      labelsFontSize: (json['labelsFontSize'] as num).toDouble(),
      countFontSize: (json['countFontSize'] as num).toDouble(),
      numberTypeFontSize: (json['numberTypeFontSize'] as num).toDouble(),
      stirFontSize: (json['stirFontSize'] as num).toDouble(),
      simCardFontSize: (json['simCardFontSize'] as num).toDouble(),
      avatarPosition: const OffsetConverter()
          .fromJson(json['avatarPosition'] as Map<String, dynamic>),
      namePosition: const OffsetConverter()
          .fromJson(json['namePosition'] as Map<String, dynamic>),
      carrierPosition: const OffsetConverter()
          .fromJson(json['carrierPosition'] as Map<String, dynamic>),
      countryNamePosition: const OffsetConverter()
          .fromJson(json['countryNamePosition'] as Map<String, dynamic>),
      labelsPosition: const OffsetConverter()
          .fromJson(json['labelsPosition'] as Map<String, dynamic>),
      countPosition: const OffsetConverter()
          .fromJson(json['countPosition'] as Map<String, dynamic>),
      numberTypePosition: const OffsetConverter()
          .fromJson(json['numberTypePosition'] as Map<String, dynamic>),
      numberPosition: const OffsetConverter()
          .fromJson(json['numberPosition'] as Map<String, dynamic>),
      locationPosition: const OffsetConverter()
          .fromJson(json['locationPosition'] as Map<String, dynamic>),
      callTypePosition: const OffsetConverter()
          .fromJson(json['callTypePosition'] as Map<String, dynamic>),
      simCardPosition: const OffsetConverter()
          .fromJson(json['simCardPosition'] as Map<String, dynamic>),
      stirPosition: const OffsetConverter()
          .fromJson(json['stirPosition'] as Map<String, dynamic>),
      securityMessagePosition: const OffsetConverter()
          .fromJson(json['securityMessagePosition'] as Map<String, dynamic>),
      securityMessageTextColor: const ColorConverter()
          .fromJson((json['securityMessageTextColor'] as num).toInt()),
      securityMessageFontSize:
          (json['securityMessageFontSize'] as num).toDouble(),
      securityMessageContainerWidth:
          (json['securityMessageContainerWidth'] as num).toDouble(),
      securityMessageScrollSpeed:
          (json['securityMessageScrollSpeed'] as num).toDouble(),
      securityMessageEnabled: json['securityMessageEnabled'] as bool,
    );

Map<String, dynamic> _$CallerIdConfigToJson(_CallerIdConfig instance) =>
    <String, dynamic>{
      'backgroundColorStart':
          const ColorConverter().toJson(instance.backgroundColorStart),
      'backgroundColorEnd':
          const ColorConverter().toJson(instance.backgroundColorEnd),
      'textNameColor': const ColorConverter().toJson(instance.textNameColor),
      'textNumberColor':
          const ColorConverter().toJson(instance.textNumberColor),
      'textLocationColor':
          const ColorConverter().toJson(instance.textLocationColor),
      'textCarrierColor':
          const ColorConverter().toJson(instance.textCarrierColor),
      'textCountryNameColor':
          const ColorConverter().toJson(instance.textCountryNameColor),
      'textLabelsColor':
          const ColorConverter().toJson(instance.textLabelsColor),
      'textCountColor': const ColorConverter().toJson(instance.textCountColor),
      'textNumberTypeColor':
          const ColorConverter().toJson(instance.textNumberTypeColor),
      'textIconLabelColor':
          const ColorConverter().toJson(instance.textIconLabelColor),
      'textIconLocationColor':
          const ColorConverter().toJson(instance.textIconLocationColor),
      'textIconCallTypeColor':
          const ColorConverter().toJson(instance.textIconCallTypeColor),
      'avatarBorderColor':
          const ColorConverter().toJson(instance.avatarBorderColor),
      'textStirColor': const ColorConverter().toJson(instance.textStirColor),
      'textSimCardColor':
          const ColorConverter().toJson(instance.textSimCardColor),
      'nameFontSize': instance.nameFontSize,
      'numberFontSize': instance.numberFontSize,
      'locationFontSize': instance.locationFontSize,
      'carrierFontSize': instance.carrierFontSize,
      'countryNameFontSize': instance.countryNameFontSize,
      'labelsFontSize': instance.labelsFontSize,
      'countFontSize': instance.countFontSize,
      'numberTypeFontSize': instance.numberTypeFontSize,
      'stirFontSize': instance.stirFontSize,
      'simCardFontSize': instance.simCardFontSize,
      'avatarPosition': const OffsetConverter().toJson(instance.avatarPosition),
      'namePosition': const OffsetConverter().toJson(instance.namePosition),
      'carrierPosition':
          const OffsetConverter().toJson(instance.carrierPosition),
      'countryNamePosition':
          const OffsetConverter().toJson(instance.countryNamePosition),
      'labelsPosition': const OffsetConverter().toJson(instance.labelsPosition),
      'countPosition': const OffsetConverter().toJson(instance.countPosition),
      'numberTypePosition':
          const OffsetConverter().toJson(instance.numberTypePosition),
      'numberPosition': const OffsetConverter().toJson(instance.numberPosition),
      'locationPosition':
          const OffsetConverter().toJson(instance.locationPosition),
      'callTypePosition':
          const OffsetConverter().toJson(instance.callTypePosition),
      'simCardPosition':
          const OffsetConverter().toJson(instance.simCardPosition),
      'stirPosition': const OffsetConverter().toJson(instance.stirPosition),
      'securityMessagePosition':
          const OffsetConverter().toJson(instance.securityMessagePosition),
      'securityMessageTextColor':
          const ColorConverter().toJson(instance.securityMessageTextColor),
      'securityMessageFontSize': instance.securityMessageFontSize,
      'securityMessageContainerWidth': instance.securityMessageContainerWidth,
      'securityMessageScrollSpeed': instance.securityMessageScrollSpeed,
      'securityMessageEnabled': instance.securityMessageEnabled,
    };
