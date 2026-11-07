# pyro_platform_http_adapter

纯粹解耦的跨平台 Dio HTTP 适配器与全局网络无感接管库。

## 特性
1. **PyroPlatformNetwork.install()**: 一行代码开启全局 `HttpOverrides`，无感接管宿主与河图脚本引擎 (`pyro_hetu_script_engine`) 的底层 `HttpClient`。
2. **WinHttpDioAdapter**: Windows 下采用 Schannel 原生 TLS 栈，完美规避 JA3 拦截。
3. **NativeAdapter**: iOS / Android / macOS 下采用 Cronet 与 Native HTTP 协议栈。

## 使用方式

### 一行代码无感接管 (主 App 入口)
```dart
import 'package:pyro_platform_http_adapter/pyro_platform_http_adapter.dart';

void main() {
  PyroPlatformNetwork.install(); // 👈 一行代码开启全局原生网络适配
  runApp(const MyApp());
}
```

### 显式挂载到特定 Dio 实例
```dart
import 'package:pyro_platform_http_adapter/pyro_platform_http_adapter.dart';

final dio = Dio();
dio.httpClientAdapter = PlatformHttpAdapter.create();
```
