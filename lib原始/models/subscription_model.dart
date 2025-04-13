

class SubscriptionModel {
  int? id; // 订阅 ID
  String name; // 订阅名称
  String url; // 订阅地址
  bool enabled; // 是否启用
  bool isWhitelist; // 是否白名单
  bool isBlacklist; // 是否黑名单

  DateTime lastUpdated; // 最后更新时间
  bool isAutoUpdate; // 是否自动更新

  SubscriptionModel({
    this.id,
    required this.name,
    required this.url,
    this.enabled = true,
    this.isWhitelist = false,
    this.isBlacklist = false,
    DateTime? lastUpdated,
    this.isAutoUpdate = false,
  }) : lastUpdated = lastUpdated ?? DateTime.now();


  // 工厂方法，从Map构建订阅模型
  factory SubscriptionModel.fromMap(Map<String, dynamic> map) {
    return SubscriptionModel(
      name: map['name'],
      url: map['url'],
      enabled: map['enabled'],
      isWhitelist: map['isWhitelist'],
      isBlacklist: map['isBlacklist'],
      lastUpdated: DateTime.tryParse(map['lastUpdated']) ?? DateTime.now(),
      isAutoUpdate: map['isAutoUpdate'],
    );
  }


  // 将 SubscriptionModel 对象转换为 JSON 格式
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'url': url,
        'enabled': enabled,
        'isWhitelist': isWhitelist,
        'isBlacklist': isBlacklist,
        'lastUpdated': lastUpdated.toIso8601String(),
        'isAutoUpdate': isAutoUpdate,
      };

  // 从 JSON 格式创建 SubscriptionModel 对象
  factory SubscriptionModel.fromJson(Map<String, dynamic> json) =>
      SubscriptionModel(
        id: json['id'] as int?,
        name: json['name'] as String,
        url: json['url'] as String,
        enabled: json['enabled'] as bool,
        isWhitelist: json['isWhitelist'] as bool,
        isBlacklist: json['isBlacklist'] as bool,
        lastUpdated: json['lastUpdated'] != null
            ? DateTime.tryParse(json['lastUpdated'] as String) ?? DateTime.now()
            : DateTime.now(),
        isAutoUpdate: json['isAutoUpdate'] as bool,
      );
}


