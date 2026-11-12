class SmsSubscription {
  final String id;
  final String name;
  final String url;
  final bool isEnabled;
  final DateTime? lastUpdated;

  const SmsSubscription({
    required this.id,
    required this.name,
    required this.url,
    this.isEnabled = true,
    this.lastUpdated,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'url': url,
      'isEnabled': isEnabled,
      'lastUpdated': lastUpdated?.toIso8601String(),
    };
  }

  factory SmsSubscription.fromMap(Map<String, dynamic> map) {
    return SmsSubscription(
      id: map['id'] as String? ?? '',
      name: map['name'] as String? ?? '',
      url: map['url'] as String? ?? '',
      isEnabled: map['isEnabled'] as bool? ?? true,
      lastUpdated: map['lastUpdated'] != null ? DateTime.parse(map['lastUpdated'] as String) : null,
    );
  }

  SmsSubscription copyWith({
    String? id,
    String? name,
    String? url,
    bool? isEnabled,
    DateTime? lastUpdated,
  }) {
    return SmsSubscription(
      id: id ?? this.id,
      name: name ?? this.name,
      url: url ?? this.url,
      isEnabled: isEnabled ?? this.isEnabled,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}
