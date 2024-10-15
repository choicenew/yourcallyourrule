// models/blacklist_whitelist_model.dart

class SmsBlacklistEntry {
  String? avatar;
  String? label;
  String phoneNumber;
  String? name;
  bool isSubscribed;

  String? url; // Added URL attribute

  SmsBlacklistEntry({
    this.avatar,
    this.label,
    required this.phoneNumber,
    this.name,
    this.isSubscribed = false, // Added default value

    this.url, // Added URL attribute
  });

  Map<String, dynamic> toJson() => {
        'avatar': avatar,
        'label': label,
        'phoneNumber': phoneNumber,
        'name': name,
        'isSubscribed': isSubscribed,

        'url': url, // Added URL attribute
      };

  static SmsBlacklistEntry fromJson(Map<String, dynamic> json) =>
      SmsBlacklistEntry(
        avatar: json['avatar'],
        label: json['label'],
        phoneNumber: json['phoneNumber'],
        name: json['name'],
        isSubscribed:
            json['isSubscribed'] ?? false, // Ensure isSubscribed is initialized

        url: json['url'], // Added URL attribute
      );
}

class SmsWhitelistEntry {
  String? avatar;
  String? label;
  String phoneNumber;
  String? name;
  bool isSubscribed;

  String? url; // Added URL attribute

  SmsWhitelistEntry({
    this.avatar,
    this.label,
    required this.phoneNumber,
    this.name,
    this.isSubscribed = false, // Added default value

    this.url, // Added URL attribute
  });

  Map<String, dynamic> toJson() => {
        'avatar': avatar,
        'label': label,
        'phoneNumber': phoneNumber,
        'name': name,
        'isSubscribed': isSubscribed,

        'url': url, // Added URL attribute
      };

  static SmsWhitelistEntry fromJson(Map<String, dynamic> json) =>
      SmsWhitelistEntry(
        avatar: json['avatar'],
        label: json['label'],
        phoneNumber: json['phoneNumber'],
        name: json['name'],
        isSubscribed:
            json['isSubscribed'] ?? false, // Ensure isSubscribed is initialized

        url: json['url'], // Added URL attribute
      );
}
