import 'package:flutter/material.dart';

/// 来电显示数据实体类
class CallerIdData {
  final String phoneNumber;
  final String name;
  final String countryName;
  final String? region;
  final String? carrier;
  final String avatar;
  final List<LabelInfo> labels;
  final int? count;
  final NumberType? numberType;

  CallerIdData({
    required this.phoneNumber,
    required this.name,
    required this.countryName,
    this.region,
    this.carrier,
    required this.avatar,
    required this.labels,
    this.count,
    this.numberType,
  });

  /// 获取头像图片
  ImageProvider get avatarImage {
    if (avatar.startsWith('assets/')) {
      return AssetImage(avatar);
    } else {
      return NetworkImage(avatar);
    }
  }

  /// 将 CallerIdData 对象转换为 Map
  Map<String, dynamic> toJson() {
    return {
      'phoneNumber': phoneNumber,
      'name': name,
      'countryName': countryName,
      'region': region,
      'carrier': carrier,
      'avatar': avatar,
      'labels': labels.map((label) => label.toJson()).toList(),
      'count': count,
      'numberType': numberType?.index,
    };
  }

  /// 从 Map 创建 CallerIdData 对象
  factory CallerIdData.fromJson(Map<String, dynamic> json) => CallerIdData(
        phoneNumber: json['phoneNumber'] as String,
        name: json['name'] as String,
        countryName: json['countryName'] as String,
        region: json['region'] as String?,
        carrier: json['carrier'] as String?,
        avatar: json['avatar'] as String,
        labels: (json['labels'] as List<dynamic>)
            .map((e) => LabelInfo.fromJson(e as Map<String, dynamic>))
            .toList(),
        count: json['count'] as int?,
        numberType: json['numberType'] != null
            ? NumberType.values[json['numberType'] as int]
            : null,
      );
}

/// 标签信息
class LabelInfo {
  final String label;
  final int count;

  LabelInfo({required this.label, required this.count});

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'count': count,
    };
  }

  factory LabelInfo.fromJson(Map<String, dynamic> json) {
    return LabelInfo(
      label: json['label'] as String,
      count: json['count'] as int,
    );
  }
}

/// 号码类型枚举
enum NumberType {
  mobile,
  fixed,
  tollfree,
  premium,
  sharedCost,
  voip,
  personalNumber,
  pager,
  uan,
  voicemail,
  unknown;

  String translated(BuildContext context) {
    // 这里应该使用国际化字符串，暂时返回英文
    switch (this) {
      case NumberType.mobile:
        return 'Mobile';
      case NumberType.fixed:
        return 'Fixed Line';
      case NumberType.tollfree:
        return 'Toll Free';
      case NumberType.premium:
        return 'Premium Rate';
      case NumberType.sharedCost:
        return 'Shared Cost';
      case NumberType.voip:
        return 'VoIP';
      case NumberType.personalNumber:
        return 'Personal Number';
      case NumberType.pager:
        return 'Pager';
      case NumberType.uan:
        return 'UAN';
      case NumberType.voicemail:
        return 'Voicemail';
      case NumberType.unknown:
        return 'Unknown';
    }
  }
}