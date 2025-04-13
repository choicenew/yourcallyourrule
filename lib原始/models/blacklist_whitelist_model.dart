// models/blacklist_whitelist_model.dart

abstract class ListEntry {
  String? avatar;
  String label;
  String phoneNumber;
  String? name;
  bool isSubscribed;
  int? count;
  String? url;

  ListEntry({
    this.avatar,
    required this.label,
    required this.phoneNumber,
    this.name,
    this.isSubscribed = false,
    this.count,
    this.url,
  });

  Map<String, dynamic> toMap();
}

class BlacklistEntry extends ListEntry {
  BlacklistEntry({
    super.avatar,
    required super.label,
    required super.phoneNumber,
    super.name,
    super.isSubscribed,
    super.count,
    super.url,
  });

  @override
  Map<String, dynamic> toMap() => {
        'avatar': avatar,
        'label': label,
        'phoneNumber': phoneNumber,
        'name': name,
        'isSubscribed': isSubscribed ? 1 : 0,
        'count': count,
        'url': url,
      };

  static BlacklistEntry fromJson(Map<String, dynamic> json) => BlacklistEntry(
        avatar: json['avatar'],
        label: json['label'],
        phoneNumber: json['phoneNumber'],
        name: json['name'],
        isSubscribed: json['isSubscribed'] == 1,
        count: json['count'],
        url: json['url'],
      );
}

class WhitelistEntry extends ListEntry {
  WhitelistEntry({
    super.avatar,
    required super.label,
    required super.phoneNumber,
    super.name,
    super.isSubscribed,
    super.count,
    super.url,
  });

  @override
  Map<String, dynamic> toMap() => {
        'avatar': avatar,
        'label': label,
        'phoneNumber': phoneNumber,
        'name': name,
        'isSubscribed': isSubscribed ? 1 : 0,
        'count': count,
        'url': url,
      };

  static WhitelistEntry fromJson(Map<String, dynamic> json) => WhitelistEntry(
        avatar: json['avatar'],
        label: json['label'],
        phoneNumber: json['phoneNumber'],
        name: json['name'],
        isSubscribed: json['isSubscribed'] == 1,
        count: json['count'],
        url: json['url'],
      );
}