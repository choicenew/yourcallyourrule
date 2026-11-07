abstract class CloudDriveCredentials {
  final String providerId;
  const CloudDriveCredentials({required this.providerId});

  Map<String, dynamic> toJson();
}

class BasicAuthCredentials extends CloudDriveCredentials {
  final String serverUrl;
  final String username;
  final String password;

  const BasicAuthCredentials({
    required super.providerId,
    required this.serverUrl,
    required this.username,
    required this.password,
  });

  @override
  Map<String, dynamic> toJson() => {
        'providerId': providerId,
        'serverUrl': serverUrl,
        'username': username,
        'password': password,
      };

  factory BasicAuthCredentials.fromJson(Map<String, dynamic> json) =>
      BasicAuthCredentials(
        providerId: json['providerId'] as String? ?? 'webdav',
        serverUrl: json['serverUrl'] as String? ?? '',
        username: json['username'] as String? ?? '',
        password: json['password'] as String? ?? '',
      );
}

class OAuthCredentials extends CloudDriveCredentials {
  final String accessToken;
  final String? refreshToken;
  final DateTime? expiresAt;
  final String? accountId;

  const OAuthCredentials({
    required super.providerId,
    required this.accessToken,
    this.refreshToken,
    this.expiresAt,
    this.accountId,
  });

  @override
  Map<String, dynamic> toJson() => {
        'providerId': providerId,
        'accessToken': accessToken,
        if (refreshToken != null) 'refreshToken': refreshToken,
        if (expiresAt != null) 'expiresAt': expiresAt!.toIso8601String(),
        if (accountId != null) 'accountId': accountId,
      };

  factory OAuthCredentials.fromJson(Map<String, dynamic> json) =>
      OAuthCredentials(
        providerId: json['providerId'] as String? ?? '',
        accessToken: json['accessToken'] as String? ?? '',
        refreshToken: json['refreshToken'] as String?,
        expiresAt: json['expiresAt'] != null
            ? DateTime.tryParse(json['expiresAt'].toString())
            : null,
        accountId: json['accountId'] as String?,
      );
}
