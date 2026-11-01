/// Representation of an incoming SMS/RCS/Messaging notification or message
class SmsMessageEntity {
  final String id;
  final String sender;
  final String body;
  final DateTime timestamp;
  final String? packageName;
  final Map<String, String>? extraMetadata;

  const SmsMessageEntity({
    required this.id,
    required this.sender,
    required this.body,
    required this.timestamp,
    this.packageName,
    this.extraMetadata,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'sender': sender,
        'body': body,
        'timestamp': timestamp.toIso8601String(),
        'packageName': packageName,
        'extraMetadata': extraMetadata,
      };

  factory SmsMessageEntity.fromJson(Map<String, dynamic> json) {
    return SmsMessageEntity(
      id: json['id'] as String? ?? '',
      sender: json['sender'] as String? ?? '',
      body: json['body'] as String? ?? '',
      timestamp: DateTime.tryParse(json['timestamp'] as String? ?? '') ?? DateTime.now(),
      packageName: json['packageName'] as String?,
      extraMetadata: (json['extraMetadata'] as Map<String, dynamic>?)?.map(
        (k, v) => MapEntry(k, v.toString()),
      ),
    );
  }
}
