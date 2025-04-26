import '../../lib/core/base/base_entity.dart';

/// 短信文本条目基类
abstract class SmsTextEntry extends BaseEntity {
  /// 关键词
  final String keyword;
  
  /// 名称
  final String? name;
  
  /// 是否来自订阅
  final bool isSubscribed;
  
  /// 订阅URL
  final String? url;

  SmsTextEntry({
    required super.id,
    required this.keyword,
    this.name,
    this.isSubscribed = false,
    this.url,
  });

  @override
  Map<String, dynamic> toMap();
}

/// 短信黑名单文本条目
class SmsTextBlacklistEntry extends SmsTextEntry {
  SmsTextBlacklistEntry({
    required String id,
    required String keyword,
    String? name,
    bool isSubscribed = false,
    String? url,
  }) : super(
          id: id,
          keyword: keyword,
          name: name,
          isSubscribed: isSubscribed,
          url: url,
        );

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'keyword': keyword,
        'name': name,
        'isSubscribed': isSubscribed ? 1 : 0,
        'url': url,
      };

  /// 从Map创建实体
  factory SmsTextBlacklistEntry.fromMap(Map<String, dynamic> map) {
    return SmsTextBlacklistEntry(
      id: map['id']?.toString() ?? map['keyword'] ?? '',
      keyword: map['keyword'] ?? '',
      name: map['name'],
      isSubscribed: map['isSubscribed'] == 1,
      url: map['url'],
    );
  }
}

/// 短信白名单文本条目
class SmsTextWhitelistEntry extends SmsTextEntry {
  SmsTextWhitelistEntry({
    required String id,
    required String keyword,
    String? name,
    bool isSubscribed = false,
    String? url,
  }) : super(
          id: id,
          keyword: keyword,
          name: name,
          isSubscribed: isSubscribed,
          url: url,
        );

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'keyword': keyword,
        'name': name,
        'isSubscribed': isSubscribed ? 1 : 0,
        'url': url,
      };

  /// 从Map创建实体
  factory SmsTextWhitelistEntry.fromMap(Map<String, dynamic> map) {
    return SmsTextWhitelistEntry(
      id: map['id']?.toString() ?? map['keyword'] ?? '',
      keyword: map['keyword'] ?? '',
      name: map['name'],
      isSubscribed: map['isSubscribed'] == 1,
      url: map['url'],
    );
  }
}