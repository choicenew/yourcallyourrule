import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_cloudflare_proxy/pyro_cloudflare_proxy.dart';

void main() {
  group('CloudflareBypassClient 代理拦截客户端测试', () {
    test('Cookie 捕获与 Header 注入验证测试', () {
      final client = CloudflareBypassClient();
      final domain = 'manga18.club';

      client.updateProxyCookies(
        domain,
        {'cf_clearance': 'mock_cf_token_123', 'session': 'xyz'},
        'Mozilla/5.0 Headless',
      );

      final config = client.getProxyConfig(domain);
      expect(config, isNotNull);
      expect(config!.hasCfClearance, isTrue);

      final mergedHeaders = client.mergeProxyHeaders(domain, {'Accept': 'application/json'});
      expect(mergedHeaders['Cookie'], contains('cf_clearance=mock_cf_token_123'));
      expect(mergedHeaders['User-Agent'], equals('Mozilla/5.0 Headless'));
    });
  });
}
