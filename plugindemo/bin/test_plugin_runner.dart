import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:plugindemo/features/plugin/services/core/js_execution_service.dart';
import 'package:plugindemo/features/plugin/services/core/native_request_channel.dart';

/// 纯 Dart / 无模拟器 JS 插件自动化测试断言脚本
/// 允许开发者或 AI 直接运行 `dart test_plugin.dart` 或在 IDE 中直接右键运行
/// 全程无需启动 Android 模拟器，使用本地 QuickJS 引擎执行与网络抓取测试！
void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  print('===========================================================');
  print('🚀 [纯 Dart / 无模拟器] JS 插件自动化测试执行器启动...');
  print('===========================================================');

  // 1. 获取要测试的插件路径/内容
  String scriptContent = '';
  String pluginPath = '';

  if (args.isNotEmpty) {
    pluginPath = args[0];
  } else {
    // 默认测试官方标准模板插件 Chinese.js
    pluginPath = Platform.isWindows
        ? r'..\yourcallrule\plugins html\template\Chinese.js'
        : '../yourcallrule/plugins html/template/Chinese.js';
  }

  final file = File(pluginPath);
  if (await file.exists()) {
    print('📄 加载插件脚本文件: $pluginPath');
    scriptContent = await file.readAsString();
  } else {
    print('⚠️ 文件不存在: $pluginPath，改用内控测试样例');
    scriptContent = _getFallbackScript();
  }

  // 2. 初始化 QuickJS 与 Native 核心通道
  final jsService = JsExecutionService(
    onLog: (msg) => print('  [JS-LOG] $msg'),
  );
  await jsService.init();

  const sysUserAgent =
      'Mozilla/5.0 (Linux; Android 14; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Mobile Safari/537.36';

  final requestChannel = NativeRequestChannel(
    jsService,
    defaultUserAgent: sysUserAgent,
    onLog: (msg) => print('  [NET-LOG] $msg'),
  );
  requestChannel.register();

  // 3. 注册就绪监听与结果收集器
  final completer = Completer<Map<String, dynamic>?>();
  String detectedPluginId = 'unknown';

  jsService.registerHandler('TestPageChannel', (args) {
    print('  ⚡ TestPageChannel: $args');
    try {
      dynamic msg = args;
      if (args is List && args.isNotEmpty) msg = args[0];
      if (msg is String) msg = jsonDecode(msg);
      if (msg is Map && msg['type'] == 'pluginLoaded') {
        detectedPluginId = msg['pluginId']?.toString() ?? 'unknown';
        print('  ✅ 确认插件加载就绪, ID: $detectedPluginId');
      }
    } catch (_) {}
  });

  jsService.registerHandler('PluginResultChannel', (args) {
    print('\n===========================================================');
    print('📦 收到插件执行结果 (PluginResultChannel):');
    print('===========================================================');
    try {
      dynamic msg = args;
      if (args is List && args.isNotEmpty) msg = args[0];
      Map<String, dynamic> result;
      if (msg is String) {
        result = jsonDecode(msg);
      } else {
        result = Map<String, dynamic>.from(msg);
      }
      print(const JsonEncoder.withIndent('  ').convert(result));
      if (!completer.isCompleted) {
        completer.complete(result);
      }
    } catch (e) {
      print('❌ 解析插件结果失败: $e');
      if (!completer.isCompleted) completer.complete(null);
    }
  });

  // 4. 加载插件源码到 QuickJS 引擎
  print('⚙️ 正在向 QuickJS 引擎注入插件代码...');
  await jsService.evaluate(scriptContent);

  // 5. 发起测试查询（模拟来电，输入测试号码）
  final testPhoneNumber = args.length > 1 ? args[1] : '13800138000';
  final requestId = 'standalone_test_${DateTime.now().millisecondsSinceEpoch}';

  print('📞 发起测试号码查询: $testPhoneNumber (RequestID: $requestId)');

  await jsService.injectConfig(detectedPluginId, {
    'userAgent': sysUserAgent,
    'strategy': 'direct',
  });

  await jsService.evaluate('''
    (function() {
      var keys = Object.keys(globalThis.plugin || {});
      var pid = "$detectedPluginId";
      if (!globalThis.plugin[pid] && keys.length > 0) {
        pid = keys[0];
      }
      if (globalThis.plugin && globalThis.plugin[pid]) {
        console.log('[NativeTest] Executing generateOutput for ' + pid);
        globalThis.plugin[pid].generateOutput(
          "$testPhoneNumber",
          "$testPhoneNumber",
          "+86$testPhoneNumber",
          "$requestId"
        );
      } else {
        console.error('[NativeTest] No plugin found in globalThis.plugin!');
      }
    })();
  ''');

  // 6. 等待结果并执行自动化断言
  try {
    final result = await completer.future.timeout(
      const Duration(seconds: 25),
      onTimeout: () {
        print('❌ [ERROR] 插件测试超时 (25s)，未收到 PluginResultChannel 回调！');
        return null;
      },
    );

    print('\n===========================================================');
    print('🔍 自动化断言判定结果 (Automated Assertions):');
    print('===========================================================');

    if (result != null) {
      final success = result['success'] == true;
      final sourceLabel = result['sourceLabel']?.toString() ?? '';
      final predefinedLabel = result['predefinedLabel']?.toString() ?? '';
      final name = result['name']?.toString() ?? '';
      final count = result['count'] ?? 0;

      print('  • 执行状态 (success): $success');
      print('  • 来源标签 (sourceLabel): "$sourceLabel"');
      print('  • 预定义标签 (predefinedLabel): "$predefinedLabel"');
      print('  • 机构名称 (name): "$name"');
      print('  • 标记次数 (count): $count');

      if (success) {
        print('\n🎉 【PASS】插件自动化单测通过！流程闭环无误！');
      } else {
        print('\n⚠️ 【FAIL】插件执行返回失败或无有效标签数据！');
      }
    } else {
      print('\n❌ 【FAIL】插件未能在规定时间内完成请求回调！');
    }
  } catch (e) {
    print('❌ 测试异常: $e');
  } finally {
    jsService.dispose();
    await requestChannel.cleanup();
    print('🧹 清理 QuickJS RAM 完毕，测试结束。');
  }
}

String _getFallbackScript() {
  return '''
    (function(scope) {
      const PLUGIN_CONFIG = { id: 'fallbackTest', name: 'Fallback Test', version: '1.0.0' };
      if (!scope.plugin) scope.plugin = {};
      scope.plugin[PLUGIN_CONFIG.id] = {
        info: PLUGIN_CONFIG,
        generateOutput: function(phone, national, e164, reqId) {
          sendMessage('PluginResultChannel', JSON.stringify({
            success: true,
            phoneNumber: phone,
            sourceLabel: '广告推销',
            predefinedLabel: 'Telemarketing',
            count: 99,
            requestId: reqId
          }));
        }
      };
      if (typeof sendMessage === 'function') {
        sendMessage('TestPageChannel', JSON.stringify({ type: 'pluginLoaded', pluginId: PLUGIN_CONFIG.id }));
      }
    })(globalThis);
  ''';
}
