/// 来电显示数据实体类
/// 包含来电显示所需的所有信息
class CallerIdData {
  final String phoneNumber;
  final String? name;
  final String? countryName;
  final String? region;
  final String? carrier;
  final PhoneNumberType numberType;
  final List<Label>? labels;
  final String? avatar;
  final int count;

  CallerIdData({
    required this.phoneNumber,
    this.name,
    this.countryName,
    this.region,
    this.carrier,
    this.numberType = PhoneNumberType.unknown,
    this.labels,
    this.avatar,
    this.count = 0,
  });

  /// 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'phoneNumber': phoneNumber,
      'name': name,
      'countryName': countryName,
      'region': region,
      'carrier': carrier,
      'numberType': numberType.index,
      'labels': labels?.map((label) => label.toJson()).toList(),
      'avatar': avatar,
      'count': count,
    };
  }

  /// 从JSON创建实例
  factory CallerIdData.fromJson(Map<String, dynamic> json) {
    return CallerIdData(
      phoneNumber: json['phoneNumber'],
      name: json['name'],
      countryName: json['countryName'],
      region: json['region'],
      carrier: json['carrier'],
      numberType: PhoneNumberType.values[json['numberType'] ?? 0],
      labels: (json['labels'] as List?)
          ?.map((labelJson) => Label.fromJson(labelJson))
          .toList(),
      avatar: json['avatar'],
      count: json['count'] ?? 0,
    );
  }
}

/// 电话号码类型枚举
enum PhoneNumberType {
  mobile,
  fixedLine,
  tollFree,
  premiumRate,
  sharedCost,
  voip,
  personalNumber,
  pager,
  uan,
  voicemail,
  unknown,
}

/// 标签实体类
class Label {
  final String label;
  final String? color;
  final String? icon;

  Label({
    required this.label,
    this.color,
    this.icon,
  });

  /// 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'color': color,
      'icon': icon,
    };
  }

  /// 从JSON创建实例
  factory Label.fromJson(Map<String, dynamic> json) {
    return Label(
      label: json['label'],
      color: json['color'],
      icon: json['icon'],
    );
  }
}