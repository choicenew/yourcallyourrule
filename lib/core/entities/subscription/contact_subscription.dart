import 'package:yourcallyourrule/core/base/base_entity.dart';
import 'package:yourcallyourrule/core/value_objects/url.dart';

class ContactSubscription extends BaseEntity {
  final String name;
  final Url url;
  final bool isEnabled;
  final bool autoUpdate;
  final DateTime lastUpdated;

  const ContactSubscription({
    required super.id,
    required this.name,
    required this.url,
    this.isEnabled = true,
    this.autoUpdate = false,
    required this.lastUpdated,
  });

  ContactSubscription copyWith({
    bool? isEnabled,
    bool? autoUpdate,
    DateTime? lastUpdated,
  }) {
    return ContactSubscription(
      id: id,
      name: name,
      url: url,
      isEnabled: isEnabled ?? this.isEnabled,
      autoUpdate: autoUpdate ?? this.autoUpdate,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'url': url.toString(),
      'isEnabled': isEnabled,
      'autoUpdate': autoUpdate,
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }

  factory ContactSubscription.fromMap(Map<String, dynamic> map) {
    return ContactSubscription(
      id: map['id'],
      name: map['name'],
      url: Url.fromString(map['url']),
      isEnabled: map['isEnabled'] ?? true,
      autoUpdate: map['autoUpdate'] ?? false,
      lastUpdated: DateTime.parse(map['lastUpdated']),
    );
  }
}