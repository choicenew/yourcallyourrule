import 'package:flutter/foundation.dart';
import 'package:hetu_script/hetu_script.dart';
import 'package:hetu_script/binding.dart';

// Delegates
import '../../delegates/delegates.dart';
// Separated Device Bindings
import '../sdk/battery/battery_binding.dart';
import '../sdk/html/html_binding.dart';
import '../sdk/location/location_binding.dart';
import '../sdk/motion/motion_binding.dart';
import '../sdk/network/network_binding.dart';
import '../sdk/storage/storage_binding.dart';
// SDK Bindings
import '../sdk/system/config_binding.dart';
import '../sdk/time/time_binding.dart';
import '../sdk/translation/translation_binding.dart';
import '../sdk/usage/usage_binding.dart';
import '../sdk/user/user_binding.dart';
import '../sdk/weather/weather_binding.dart';
import '../sdk/webview/webview_binding.dart';
import '../services/device_service.dart';
import '../services/weather_service.dart';
// Standard Library Bindings
import '../std/base32/base32.binding.dart';
import '../std/base64/base64.binding.dart';
import '../std/crypto/crypto_binding.dart';
import '../std/datetime/datetime_binding.dart';
import '../std/future/future_binding.dart';
import '../std/http/http_client.binding.dart';
import '../std/regex/regex_binding.dart';
import '../std/timer/timer_binding.dart';
import '../std/utf8/utf8_binding.dart';
import '../std/util/util_binding.dart';

/// 针对 [Hetu] 的外部绑定扩展，解耦所有的标准库与 SDK 绑定注册
extension PyroHetuBindingExtension on Hetu {
  /// 获取 Pyro 引擎提供的标准库扩展类绑定列表
  List<HTExternalClass> getPyroStandardClasses({
    CookieDelegate? cookieDelegate,
  }) {
    return [
      Base32ClassBinding(),
      Base64ClassBinding(),
      CryptoBinding(),
      DateTimeClassBinding(),
      DurationClassBinding(),
      HttpBaseOptionsClassBinding(),
      RequestOptionsClassBinding(),
      HttpResponseClassBinding(),
      HttpClientClassBinding(cookieDelegate),
      RegexClassBinding(),
      ExpressionMatchClassBinding(),
      SimpleMatchClassBinding(),
      TimerClassBinding(),
      UtilBinding(),
      FutureUtilsBinding(),
      Utf8CodecBinding(),
    ];
  }

  /// 获取 Pyro 引擎提供的宿主环境与设备 SDK 类绑定列表
  List<HTExternalClass> getPyroSdkClasses({
    required WebViewDelegate webViewDelegate,
    required UserDelegate userDelegate,
    required ConfigDelegate configDelegate,
    required StorageDelegate storageDelegate,
    required TranslationDelegate translationDelegate,
    required DeviceService deviceService,
    required WeatherService weatherService,
    WeatherDelegate? weatherDelegate,
  }) {
    return [
      WebviewBinding(webViewDelegate),
      UserBinding(userDelegate),
      ConfigBinding(configDelegate),
      StorageBinding(storageDelegate),
      TranslationBinding(translationDelegate),
      BatteryBinding(deviceService),
      NetworkBinding(deviceService),
      LocationBinding(deviceService),
      MotionBinding(deviceService),
      TimeBinding(deviceService),
      WeatherBinding(delegate: weatherDelegate, service: weatherService),
      HtmlBinding(),
      DocumentClassBinding(),
      ElementClassBinding(),
      UsageBinding(),
    ];
  }

  /// 一键初始化 Pyro 运行环境及其全部扩展绑定
  void initPyroBindings({
    required WebViewDelegate webViewDelegate,
    required UserDelegate userDelegate,
    required ConfigDelegate configDelegate,
    required StorageDelegate storageDelegate,
    required TranslationDelegate translationDelegate,
    required DeviceService deviceService,
    required WeatherService weatherService,
    WeatherDelegate? weatherDelegate,
    Map<String, Function> additionalFunctions = const {},
    List<HTExternalClass> additionalClasses = const [],
  }) {
    final cookieDelegate = webViewDelegate is CookieDelegate
        ? webViewDelegate as CookieDelegate
        : null;

    final stdClasses = getPyroStandardClasses(cookieDelegate: cookieDelegate);
    final sdkClasses = getPyroSdkClasses(
      webViewDelegate: webViewDelegate,
      userDelegate: userDelegate,
      configDelegate: configDelegate,
      storageDelegate: storageDelegate,
      translationDelegate: translationDelegate,
      deviceService: deviceService,
      weatherService: weatherService,
      weatherDelegate: weatherDelegate,
    );

    init(
      useDefaultModuleAndBinding: true,
      externalFunctions: {
        'debugPrint': ({
          List<dynamic> positionalArgs = const [],
          Map<String, dynamic> namedArgs = const {},
        }) {
          debugPrint(
            positionalArgs.isNotEmpty ? positionalArgs.elementAt(0)?.toString() : '',
          );
        },
        ...additionalFunctions,
      },
      externalClasses: [
        ...stdClasses,
        ...sdkClasses,
        ...additionalClasses,
      ],
    );
  }
}
