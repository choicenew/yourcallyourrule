// 导入必要的库
import 'package:json_annotation/json_annotation.dart';

// 定义 ContactSubscriptionModel 类
@JsonSerializable()
class ContactSubscriptionModel {
  int? id;
  String name;
  String url;
  bool enabled;
  DateTime lastUpdated;
  bool isAutoUpdate;

  // 构造函数
   ContactSubscriptionModel({
    this.id,
    required this.name,
    required this.url,
    this.enabled = true,
    DateTime? lastUpdated, // 将 lastUpdated 声明为可空类型
    this.isAutoUpdate = false,
  }) : lastUpdated = lastUpdated ?? DateTime.now(); // 使用空值合并运算符设置默认值

  // 将 ContactSubscriptionModel 对象转换为 JSON 格式
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'url': url,
        'enabled': enabled,
        'lastUpdated': lastUpdated.toIso8601String(),
        'isAutoUpdate': isAutoUpdate,
      };

  // 从 JSON 格式创建 ContactSubscriptionModel 对象
  static ContactSubscriptionModel fromJson(Map<String, dynamic> json) =>
      ContactSubscriptionModel(
        id: json['id'] as int?,
        name: json['name'],
        url: json['url'],
        enabled: json['enabled'] ?? true,
        lastUpdated: json['lastUpdated'] != null
            ? DateTime.tryParse(json['lastUpdated']) ?? DateTime.now()
            : DateTime.now(),
        isAutoUpdate: json['isAutoUpdate'] ?? false,
      );
}

