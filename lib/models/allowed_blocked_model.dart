// 数据库模型类
abstract class ListEntry {
  String phoneNumber;
  String label;
  String? name;
  String? avatar;


  ListEntry({
    required this.phoneNumber,
    required this.label,
    this.name,
    this.avatar,

  });

  Map<String, dynamic> toMap();
}

class BlockedEntry extends ListEntry {
  BlockedEntry({
    required super.phoneNumber,
    required super.label,
    super.name,
    super.avatar,

  });

  @override
  Map<String, dynamic> toMap() => {
        'phoneNumber': phoneNumber,
        'label': label,
        'name': name,
        'avatar': avatar,

      };

  static BlockedEntry fromJson(Map<String, dynamic> json) => BlockedEntry(
        phoneNumber: json['phoneNumber'],
        label: json['label'],
        name: json['name'],
        avatar: json['avatar'],

      );
}

class AllowedEntry extends ListEntry {
  AllowedEntry({
    required super.phoneNumber,
    required super.label,
    super.name,
    super.avatar,

  });

  @override
  Map<String, dynamic> toMap() => {
        'phoneNumber': phoneNumber,
        'label': label,
        'name': name,
        'avatar': avatar,

      };

  static AllowedEntry fromJson(Map<String, dynamic> json) => AllowedEntry(
        phoneNumber: json['phoneNumber'],
        label: json['label'],
        name: json['name'],
        avatar: json['avatar'],

      );
}
/*
// 数据模型扩展类
extension AllowedEntryExtension on AllowedEntry {
  // 检查号码是否在允许名单中
  bool isAllowed() {
    return true; // 实际逻辑需要根据数据库查询结果判断
  }
}

extension BlockedEntryExtension on BlockedEntry {
  // 检查号码是否在阻止名单中
  bool isBlocked() {
    return true; // 实际逻辑需要根据数据库查询结果判断
  }
}
*/