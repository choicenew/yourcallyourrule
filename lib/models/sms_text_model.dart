// models/blacklist_whitelist_model.dart

class SmsTextBlacklistEntry {

  String keyword;
  String? name;
  bool isSubscribed;

  String? url; // Added URL attribute

  SmsTextBlacklistEntry({

    required this.keyword,
    this.name,
    this.isSubscribed = false, // Added default value

    this.url, // Added URL attribute
  });

  Map<String, dynamic> toJson() => {

        'keyword': keyword,
        'name': name,
        'isSubscribed': isSubscribed,

        'url': url, // Added URL attribute
      };

  static SmsTextBlacklistEntry fromJson(Map<String, dynamic> json) =>
      SmsTextBlacklistEntry(

        keyword: json['keyword'],
        name: json['name'],
        isSubscribed:
            json['isSubscribed'] ?? false, // Ensure isSubscribed is initialized

        url: json['url'], // Added URL attribute
      );
}

class SmsTextWhitelistEntry {

  String keyword;
  String? name;
  bool isSubscribed;

  String? url; // Added URL attribute

  SmsTextWhitelistEntry({

    required this.keyword,
    this.name,
    this.isSubscribed = false, // Added default value

    this.url, // Added URL attribute
  });

  Map<String, dynamic> toJson() => {
    
        'keyword': keyword,
        'name': name,
        'isSubscribed': isSubscribed,

        'url': url, // Added URL attribute
      };

  static SmsTextWhitelistEntry fromJson(Map<String, dynamic> json) =>
      SmsTextWhitelistEntry(
 
        keyword: json['keyword'],
        name: json['name'],
        isSubscribed:
            json['isSubscribed'] ?? false, // Ensure isSubscribed is initialized

        url: json['url'], // Added URL attribute
      );
}
