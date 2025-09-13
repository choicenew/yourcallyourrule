class StirInfo {
  final bool isVerified;
  final bool isNotVerified;
  final bool isFailed;
  final String? phoneNumber;

  StirInfo({
    required this.isVerified,
    required this.isNotVerified,
    required this.isFailed,
    this.phoneNumber,
  });

  Map<String, dynamic> toJson() => {
    'isVerified': isVerified,
    'isNotVerified': isNotVerified,
    'isFailed': isFailed,
    'phoneNumber': phoneNumber,
  };

  factory StirInfo.fromJson(Map<String, dynamic> json) => StirInfo(
    isVerified: json['isVerified'],
    isNotVerified: json['isNotVerified'],
    isFailed: json['isFailed'],
    phoneNumber: json['phoneNumber'],
  );
  Map<String, dynamic> toMap() => {
        'isVerified': isVerified,
        'isNotVerified': isNotVerified,
        'isFailed': isFailed,
        'phoneNumber': phoneNumber,
      };

  factory StirInfo.fromMap(Map<String, dynamic> map) => StirInfo(
        isVerified: map['isVerified'] ?? false,
        isNotVerified: map['isNotVerified'] ?? false,
        isFailed: map['isFailed'] ?? false,
        phoneNumber: map['phoneNumber'],
      );

  bool isStirVerified() => isVerified;
}