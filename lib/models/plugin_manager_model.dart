



class Plugin {
  final String id;
  final String name;
  final String url;
  final String version;
  late final bool enabled;
  final int order;
  final String script; // Add this line
  
  Plugin({
    required this.id,
    required this.name,
    required this.url,
    required this.version,
    required this.enabled,
    required this.order,
    required this.script,
  });

  factory Plugin.fromJson(Map<String, dynamic> json) {
    return Plugin(
      id: json['id'],
      name: json['name'],
      url: json['url'],
      version: json['version'],
      enabled: json['enabled'] == 1,
      order: json['order'],
      script: json['script'], // Add this line
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'url': url,
      'version': version,
      'enabled': enabled ? 1 : 0,
      'order': order,
      'script': script, // Add this line
    };
  }
}
