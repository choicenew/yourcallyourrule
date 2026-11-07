class CloudFileItem {
  final String name;
  final String path;
  final int size;
  final DateTime lastModified;
  final bool isDirectory;
  final String? hash;
  final String? mimeType;
  final Map<String, dynamic> metadata;

  const CloudFileItem({
    required this.name,
    required this.path,
    this.size = 0,
    required this.lastModified,
    this.isDirectory = false,
    this.hash,
    this.mimeType,
    this.metadata = const {},
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'path': path,
        'size': size,
        'lastModified': lastModified.toIso8601String(),
        'isDirectory': isDirectory,
        if (hash != null) 'hash': hash,
        if (mimeType != null) 'mimeType': mimeType,
        if (metadata.isNotEmpty) 'metadata': metadata,
      };

  factory CloudFileItem.fromJson(Map<String, dynamic> json) => CloudFileItem(
        name: json['name'] as String? ?? '',
        path: json['path'] as String? ?? '',
        size: json['size'] as int? ?? 0,
        lastModified: json['lastModified'] != null
            ? DateTime.tryParse(json['lastModified'].toString()) ?? DateTime.now()
            : DateTime.now(),
        isDirectory: json['isDirectory'] as bool? ?? false,
        hash: json['hash'] as String?,
        mimeType: json['mimeType'] as String?,
        metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
      );
}
