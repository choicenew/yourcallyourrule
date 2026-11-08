/// Cloudflare 基础设施纯物理连接配置
class CloudflareConfig {
  final String workerUrl;
  final String apiSecret;
  final String accountId;
  final String? r2BucketName;

  const CloudflareConfig({
    required this.workerUrl,
    required this.apiSecret,
    required this.accountId,
    this.r2BucketName,
  });

  bool get isValid => workerUrl.isNotEmpty && apiSecret.isNotEmpty;

  Map<String, String> get authHeaders => {
        'Content-Type': 'application/json',
        'X-API-SECRET': apiSecret,
        if (accountId.isNotEmpty) 'X-ACCOUNT-ID': accountId,
      };
}
