import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart' as dom;
import 'package:yourcallyourrule/generated/app_localizations.dart';

// 特殊的代理前缀，JS插件会用这个前缀构建iframe的src
const String PROXY_SCHEME = "https";
const String PROXY_HOST = "flutter-webview-proxy.internal";
const String PROXY_PATH_FETCH = "/fetch";

class TestPage extends StatefulWidget {
  const TestPage({
    super.key,
    //required this.title
  });

  //final String title;

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final TextEditingController _pluginUrlController = TextEditingController(
    text:
        'https://raw.githubusercontent.com/haygcao/test/refs/heads/main/newtellows.js', // 您的在线 JS 插件 URL
  );
  String _queryResult = '';
  String _jsLogs = ''; // 用于显示JS和代理日志
  InAppWebViewController? _webViewController;
  bool _isPluginJsLoaded = false;
  String? _loadedPluginId;
  final Map<String, Completer<Map<String, dynamic>?>> _requestCompleters = {};

  // --- 状态变量 ---
  // 简单模式的控制器和格式
  final _simplePhoneController = TextEditingController();
  String _selectedNumberFormat = 'phoneNumber';

  // 高级模式的控制器
  final _advancedPhoneNumberController = TextEditingController();
  final _advancedNationalNumberController = TextEditingController();
  final _advancedE164NumberController = TextEditingController();

  // --- 新增: 用于切换模式的开关状态 ---
  bool _isAdvancedMode = false;

  @override
  void initState() {
    super.initState();
  }

  void _addLog(String log) {
    print(log); // 打印到控制台
    if (mounted) {
      setState(() {
        _jsLogs =
            "${DateTime.now().toIso8601String().split('T').last} $log\n$_jsLogs";
        if (_jsLogs.length > 5000) {
          // 限制日志长度
          _jsLogs = _jsLogs.substring(0, 5000);
        }
      });
    }
  }

  Future<void> _setupRequestChannel(InAppWebViewController controller) async {
    controller.addJavaScriptHandler(
      handlerName: 'RequestChannel',
      callback: (args) async {
        if (args.isNotEmpty) {
          _addLog('JS->Flutter (RequestChannel): ${args[0]}');
        }
      },
    );
  }

  Future<void> _loadPluginJs() async {
    if (_webViewController == null) {
      _addLog('Error: WebView controller is null. Cannot load plugin JS.');
      return;
    }
    String pluginUrl = _pluginUrlController.text;
    if (pluginUrl.isEmpty) {
      _addLog('Error: Plugin JS URL is empty.');
      return;
    }
    _addLog('Attempting to load JS plugin code from: $pluginUrl');
    try {
      final response = await http.get(Uri.parse(pluginUrl));
      if (response.statusCode == 200) {
        await _webViewController!.evaluateJavascript(source: response.body);
        _addLog(
          'JS plugin code injected. Waiting for "pluginLoaded" message from JS...',
        );
      } else {
        _addLog(
          'Failed to load JS plugin code. Status: ${response.statusCode}',
        );
      }
    } catch (e) {
      _addLog('Error loading JS plugin code: $e');
    }
  }

  // 这是最终的、经过错误修正的完整函数

  // =======================================================================
// --- 成员变量 (还是用Map，为了清理) ---
 //=======================================================================
      final Map<String, String> _sessionOrigins = {}; // 用于存储<requestId, origin>
// 并发安全版 _shouldInterceptRequest
Future<WebResourceResponse?> _shouldInterceptRequest(
    InAppWebViewController controller, WebResourceRequest request) async {
  final uri = request.url;
  String? requestId;
  
    // --- 分支 1: 处理我们自己的代理URL，这是会话的起点 ---
  if (uri.scheme == PROXY_SCHEME && uri.host == PROXY_HOST) {
    // 主代理请求
    requestId = uri.queryParameters['requestId'];
    final originParam = uri.queryParameters['originalOrigin'];

    if (requestId != null && originParam != null && originParam.isNotEmpty) {
       _addLog('Session starting for requestId [$requestId] with origin [$originParam]');
      _sessionOrigins[requestId] = originParam;
    }
    return _handleOriginalProxyRequest(controller, request); // 使用您原封不动的原始处理器
  } 
  
  // --- 分支 2: 精确打击 - 尝试通过 Referer 识别泄漏请求 ---
  final referer = request.headers?['Referer'] ?? request.headers?['referer'];
  if (referer != null) {
      try {
        final refererUri = Uri.parse(referer);
        // 确保 Referer 是我们的代理 URL，这样才能从中解析 requestId
        if (refererUri.host == PROXY_HOST) { 
            final requestId = refererUri.queryParameters['requestId'];
            if (requestId != null) {
                final expectedOrigin = _sessionOrigins[requestId];
                // 如果找到了对应的会话，并且 origin 匹配，就精确处理
                if (expectedOrigin != null && uri.origin == expectedOrigin) {
                  _addLog('🎯 Precisely caught LEAKED request via Referer for session [$requestId]: ${request.url}');
                  return _handleLeakedRequest(controller, request);
                }
            }
        }
      } catch(e) { /* Referer 格式可能无效，忽略错误并继续 */ }
  }
         
        
  // --- 分支 3: 保险层 - 捕获所有其他发往活跃 origin 的请求 ---
  // .values 会返回所有 active origins 的集合
  if (_sessionOrigins.values.contains(uri.origin)) {
    _addLog('🔥 Insurance layer caught a request to an active origin: ${uri.toString()}');
    return _handleLeakedRequest(controller, request);
  }

  // --- 如果以上都不匹配，则放行 ---
  _addLog('Request does not belong to any active session: ${uri.toString()}');
  return null;
}



// =======================================================================
// ==      1. 严谨、独立的HTML预处理函数 (最终语法正确版)      ==
// =======================================================================
/// 对HTML内容进行预处理，将所有相对路径的资源URL重写为我们的代理URL。
/// @param htmlBody 原始HTML字符串。
/// @param requestUri 触发这次代理的完整URI (e.g., https://.../fetch?requestId=...)。
///                   我们需要它来获取 requestId 和 originalOrigin。
/// @return 处理过的HTML字符串。
/// 对HTML内容进行预处理。
/// 它会先检查内容是否为HTML，如果不是，则直接返回原始内容。
/// 如果是HTML，它会将所有相对路径的资源URL重写为我们的代理URL。
String _preprocessHtml(String htmlBody, http.Response response, Uri requestUri) {
  // 假设 _addLog, PROXY_HOST, PROXY_PATH_FETCH 已经定义
  // void _addLog(String message) { print(message); }
  // const PROXY_HOST = 'your-proxy-domain.com';
  // const PROXY_PATH_FETCH = '/fetch';
  final contentType = response.headers['content-type'] ?? '';
  if (!contentType.contains('text/html')) {
    _addLog('Skipping pre-processing: Content is not HTML ($contentType).');
    return htmlBody;
  }
  
  _addLog('🚀 Starting HTML pre-processing...');

  final requestId = requestUri.queryParameters['requestId'];
  final targetOrigin = requestUri.queryParameters['originalOrigin'];

  if (targetOrigin == null || targetOrigin.isEmpty) {
    _addLog('⚠️ Cannot pre-process HTML: originalOrigin is missing.');
    return htmlBody;
  }






  
  // **关键修正点：**
  // 使用三引号 r'''...''' 来定义原始字符串，以避免内部的单引号 ' 和双引号 "
  // 引起Dart语法错误。这是解决“爆红报错”的根本方法。
  final attrRegex = RegExp(r'''(src|href)\s*=\s*("([^"]+)"|\'([^\']+)\')''', caseSensitive: false);

  final processedHtml = htmlBody.replaceAllMapped(attrRegex, (match) {
    final originalMatch = match.group(0)!;
    final attr = match.group(1);
    
    // 如果group(3)不为null, 说明是双引号匹配; 否则是group(4)单引号匹配
    final path = match.group(3) ?? match.group(4);


    if (path == null || path.isEmpty || path.startsWith('#') || path.startsWith(RegExp(r'^\w+:', caseSensitive: false))) {
      return originalMatch;
    }
    
    try {
      final fullOriginalUrl = Uri.parse(targetOrigin).resolve(path).toString();
      final newProxyUrl = Uri.https(
          PROXY_HOST,
          PROXY_PATH_FETCH,
          { 'requestId': requestId ?? '', 'originalOrigin': targetOrigin, 'targetUrl': fullOriginalUrl }
      ).toString();

      _addLog('🔄 Pre-processing URL in Dart: $path -> $newProxyUrl');
      // 保持原始的引号类型
      if (match.group(3) != null) {
        return '$attr="$newProxyUrl"'; // 双引号
      } else {
        return "$attr='$newProxyUrl'"; // 单引号
      }
    } catch (e) {
      _addLog('⚠️ Error pre-processing path "$path": $e.');
      return originalMatch;
    }
  });

  _addLog('✅ HTML pre-processing finished.');
  return processedHtml;
}




/// 一个独立的、通用的HTML内容净化函数。
/// 它会从请求的URI中解析'purgeRules'参数，并根据规则对HTML内容进行清理。
///
/// @param htmlBody 原始的HTML内容字符串。
/// @param requestUri 触发本次代理的请求URI，用于从中获取净化规则。
/// @return 净化后的HTML字符串。如果无需净化或发生错误，则返回原始字符串。
String _purgeHarmfulContent(String htmlBody, Uri requestUri) {
  final purgeRulesParam = requestUri.queryParameters['purgeRules'];

  // 如果没有提供净化规则，直接返回原始HTML，不进行任何操作。
  if (purgeRulesParam == null || purgeRulesParam.isEmpty) {
    return htmlBody;
  }

  _addLog('🔬 Starting DOM content sanitization based on purge rules...');

  try {
    final rules = jsonDecode(Uri.decodeComponent(purgeRulesParam)) as List;
    // 如果规则列表为空，也直接返回
    if (rules.isEmpty) {
      _addLog('  - Purge rules list is empty. Skipping.');
      return htmlBody;
    }

    var document = html_parser.parse(htmlBody);
    bool documentModified = false;

    for (var rule in rules) {
      final ruleMap = rule as Map<String, dynamic>;
      final type = ruleMap['type'] as String?;
      final selector = ruleMap['selector'] as String?;
      
      if (type == 'remove' && selector != null) {
        final elementsToRemove = document.querySelectorAll(selector);
        final contentMatch = ruleMap['contentMatch'] as String?;
        
        if (elementsToRemove.isEmpty) {
          _addLog('  - Rule with selector "$selector" found no matching elements.');
          continue;
        }

        int removedCount = 0;
        for (var element in elementsToRemove) {
          // 如果有内容匹配规则，则检查元素内容是否符合
          if (contentMatch == null || (element.innerHtml.contains(contentMatch))) {
            element.remove();
            removedCount++;
            documentModified = true;
          }
        }
        if (removedCount > 0) {
           _addLog('  - Rule successfully removed $removedCount element(s) matching selector: "$selector"');
        }
      }
      // 未来可以扩展其他类型的规则，比如 'modifyAttribute', 'clearContent' 等
    }
    
    _addLog('✅ DOM sanitization finished.');
    // 仅在实际发生修改时才重新序列化HTML，以提高性能
    return documentModified ? document.outerHtml : htmlBody;

  } catch (e) {
    _addLog('⚠️ Error applying purge rules: $e. Returning original HTML.');
    // 发生任何错误时，都安全地返回原始HTML，确保流程不中断
    return htmlBody;
  }
}










// 2. 处理器一：原封不动的原始逻辑 (现在它不再需要更新 _currentProxyOrigin)
Future<WebResourceResponse?> _handleOriginalProxyRequest(
      InAppWebViewController controller, WebResourceRequest request) async {
    final uri = request.url;

    _addLog(
        'Intercepted request: ${uri.toString()} | isForMainFrame: ${request.isForMainFrame}');

    if (uri.scheme == PROXY_SCHEME &&
        uri.host == PROXY_HOST &&
        uri.path.startsWith(PROXY_PATH_FETCH)) {
      _addLog('Proxy request matched for URL: ${uri.toString()}');

      final targetUrlParam = uri.queryParameters['targetUrl'];
      final headersParam = uri.queryParameters['headers'];

      if (targetUrlParam == null || targetUrlParam.isEmpty) {
        _addLog('Proxy Error: Missing targetUrl parameter.');
        return WebResourceResponse(
          contentType: 'text/plain',
          data:
              Uint8List.fromList('Proxy Error: Missing targetUrl parameter'.codeUnits),
          statusCode: 400,
        );
      }

      try {
        final targetUrl = Uri.parse(targetUrlParam);
        _addLog('Proxying to target: $targetUrl');

        Map<String, String> requestHeaders = {};
        if (headersParam != null && headersParam.isNotEmpty) {
          try {
            final decodedHeaders =
                jsonDecode(Uri.decodeComponent(headersParam)) as Map<String, dynamic>;
            decodedHeaders
                .forEach((key, value) => requestHeaders[key] = value.toString());
            _addLog('Using custom headers from plugin: $requestHeaders');
          } catch (e) {
            _addLog('Error decoding headers: $e');
          }
        }
        
        final cookieManager = CookieManager.instance();
        final cookies = await cookieManager.getCookies(url: WebUri.uri(targetUrl));
        if (cookies.isNotEmpty) {
             requestHeaders['Cookie'] = cookies.map((c) => '${c.name}=${c.value}').join('; ');
        }
       

        _addLog(
            'Making backend HTTP GET to: $targetUrl with headers: $requestHeaders');
        final response = await http.get(targetUrl, headers: requestHeaders);
        _addLog('Backend response received: ${response.statusCode} for $targetUrl');

        String htmlBody = utf8.decode(response.bodyBytes, allowMalformed: true);

    // 【无损插入点】 - 调用上面那个已经修正好的函数
            htmlBody = _purgeHarmfulContent(htmlBody, uri); //清除脚本由js本身提供
    htmlBody = _preprocessHtml(htmlBody, response, uri); //预处理html




        String receiverScript = '''
          <script type="text/javascript">
            // IIFE to avoid polluting the global scope
            (function() {
              console.log('[Injected-Receiver] Hello from the script injected by Flutter!');

              function handleMessage(event) {
                if (event.data && event.data.type === 'executeScript') {
                    console.log('[Injected-Receiver] Received a script to execute from parent window.');
                    try {
                      eval(event.data.script);
                      console.log('[Injected-Receiver] Script execution started.');
                    } catch (e) {
                      console.error('[Injected-Receiver] Error executing script via eval:', e);
                      window.parent.postMessage({ type: 'phoneQueryResult', data: { success: false, error: 'Eval execution failed: ' + e.toString() } }, '*');
                    }
                }
              }

              window.removeEventListener('message', handleMessage);
              window.addEventListener('message', handleMessage, false);

              console.log('[Injected-Receiver] Message listener is now active and waiting for commands.');
            })();
          </script>
        ''';

   // 获取需要阻止的原始域
      final originToBlock = Uri.parse(targetUrlParam!).origin;
      
         // 生成所有需要注入的脚本
           String domainBlockerScript = getDomainBlockerScript(originToBlock);
          // 2. 获取新的、通用的网络拦截器脚本
          String networkInterceptorScript = getUniversalNetworkInterceptorScript();

          // 3. 将它们组合在一起，确保拦截器在最前面
           String combinedScript = domainBlockerScript + networkInterceptorScript + receiverScript;
//判断contenttype
final contentType = response.headers['content-type'] ?? '';

// 如果contenttype是text/html，则注入脚本

if (contentType.contains('text/html')) {

        if (htmlBody.contains('<head>')) {
          htmlBody = htmlBody.replaceFirst('<head>', '<head>$combinedScript');
          _addLog('Injection successful into <head>.');
        } else if (htmlBody.contains('<html>')) {
          htmlBody =
              htmlBody.replaceFirst('<html>', '<html><head>$combinedScript</head>');
          _addLog('Injection successful by creating a <head> tag.');
        } else {
          htmlBody = combinedScript + htmlBody;
          _addLog('Injection successful by prepending to the document.');
        }
           } else {
        _addLog('⏩ Skipping script injection for non-HTML content ($contentType).');
    }
    
     
      final Map<String, String> responseHeaders = {};
     // 定义一个“黑名单”，包含所有需要被移除的头信息（统一使用小写以便比较）。
     final headersToRemove = [
       'x-frame-options',              // 核心问题：禁止 iframe 嵌入
       'content-security-policy',      // 可能阻止我们注入的脚本或页面内的资源加载
       'permissions-policy',           // 可能限制 iframe 内的功能
       'feature-policy',               // permissions-policy 的旧版名称
       'cross-origin-embedder-policy', // 启用跨域隔离，会破坏代理内容
       'cross-origin-opener-policy',   // 同上
     ];
     // 遍历从 cleverdialer.com 收到的每一个响应头
     response.headers.forEach((key, value) {
       final lowerCaseKey = key.toLowerCase();
       
       // 检查当前头是否在我们的“黑名单”中
       if (!headersToRemove.contains(lowerCaseKey)) {
         // 如果不在黑名单里，就把它加入到最终要返回的响应头中
         responseHeaders[key] = value;
       } else {
         // 如果在黑名单里，就记录日志并丢弃它，不返回给 WebView
          _addLog('Found and REMOVED problematic header: "$key"');
       }
     });
     // --- [修改结束] ---
 
 
 
 
 
 
 
 

 
 
 

        // --- 【最终修正】 ---
        // 错误的参数名 `encoding` 已被修正为正确的 `contentEncoding`
        return WebResourceResponse(
          contentType: 'text/html',
          contentEncoding: 'utf-8',
          data: Uint8List.fromList(utf8.encode(htmlBody)),
          statusCode: response.statusCode,
          headers: responseHeaders,
        );
        // --- 【修正结束】 ---

      } catch (e) {
        _addLog('Proxy request failed entirely: $e');
        return WebResourceResponse(
          contentType: 'text/plain',
          data: Uint8List.fromList('Proxy request failed: $e'.codeUnits),
          statusCode: 500,
        );
      }
    }

    return null;
  }
   
  

// Universal network interceptor script that can be safely injected into all proxied content
// Insert this into your _shouldInterceptRequest function alongside the existing injectionScript
// 修复后的Universal Network Interceptor Script
String getUniversalNetworkInterceptorScript() {
  return '''
    <script type="text/javascript">
      // Universal Network Interceptor - 修复版本
      (function() {
        if (window.universalNetworkInterceptorInjected) return;
        window.universalNetworkInterceptorInjected = true;
        
        console.log('[Universal-Network-Interceptor] Activating universal network interception...');
        
        const PROXY_SCHEME = "$PROXY_SCHEME";
        const PROXY_HOST = "$PROXY_HOST";  
        const PROXY_PATH_FETCH = "$PROXY_PATH_FETCH";
        const PROXY_TEMPLATE = PROXY_SCHEME + "://" + PROXY_HOST + PROXY_PATH_FETCH + "?targetUrl=";
        
        // 检测原始域名
        let originalDomain = '';
        try {
          if (window.location.href.includes('targetUrl=')) {
            const urlParams = new URLSearchParams(window.location.search);
            const targetUrl = decodeURIComponent(urlParams.get('targetUrl') || '');
            if (targetUrl) {
              originalDomain = new URL(targetUrl).origin;
            }
          }
          
          if (!originalDomain && document.referrer) {
            const referrerParams = new URLSearchParams(document.referrer.split('?')[1] || '');
            const referrerTarget = referrerParams.get('targetUrl');
            if (referrerTarget) {
              originalDomain = new URL(decodeURIComponent(referrerTarget)).origin;
            }
          }
          
          console.log('[Universal-Network-Interceptor] Detected original domain:', originalDomain);
        } catch (e) {
          console.warn('[Universal-Network-Interceptor] Could not detect original domain:', e);
        }
        
        // 设置base href
        if (originalDomain && !document.querySelector('base[href]')) {
          const baseElement = document.createElement('base');
          baseElement.href = originalDomain + '/';
          if (document.head) {
            document.head.insertBefore(baseElement, document.head.firstChild);
          } else {
            const head = document.createElement('head');
            head.appendChild(baseElement);
            if (document.documentElement) {
              document.documentElement.insertBefore(head, document.documentElement.firstChild);
            }
          }
          console.log('[Universal-Network-Interceptor] Base href set to:', originalDomain + '/');
        }
        
        // URL转换函数
        function shouldProxyUrl(url) {
          try {
            const urlObj = new URL(url, originalDomain);
            // 代理所有指向原始域名的请求
            return urlObj.origin === originalDomain;
          } catch (e) {
            console.warn('[Universal-Network-Interceptor] Error parsing URL:', url, e);
            return false;
          }
        }
        
        function convertToProxyUrl(url) {
          try {
            const absoluteUrl = new URL(url, originalDomain).toString();
            const proxiedUrl = PROXY_TEMPLATE + encodeURIComponent(absoluteUrl);
            console.log('[Universal-Network-Interceptor] Converting URL:', absoluteUrl, '->', proxiedUrl);
            return proxiedUrl;
          } catch (e) {
            console.warn('[Universal-Network-Interceptor] Error converting URL:', url, e);
            return url;
          }
        }
        
        if (originalDomain) {
          // 拦截fetch请求
          const originalFetch = window.fetch;
          window.fetch = function(resource, options = {}) {
            let url = resource;
            if (resource instanceof Request) {
              url = resource.url;
            }
            
            if (shouldProxyUrl(url)) {
              const proxiedUrl = convertToProxyUrl(url);
              
              if (resource instanceof Request) {
                return originalFetch.call(this, new Request(proxiedUrl, {
                  method: resource.method,
                  headers: resource.headers,
                  body: resource.body,
                  mode: 'cors',
                  ...options
                }));
              }
              return originalFetch.call(this, proxiedUrl, { mode: 'cors', ...options });
            }
            
            return originalFetch.apply(this, arguments);
          };
          
          // 拦截XMLHttpRequest
          const OriginalXHR = window.XMLHttpRequest;
          window.XMLHttpRequest = function() {
            const xhr = new OriginalXHR();
            const originalOpen = xhr.open;
            
            xhr.open = function(method, url, ...args) {
              if (shouldProxyUrl(url)) {
                const proxiedUrl = convertToProxyUrl(url);
                return originalOpen.call(this, method, proxiedUrl, ...args);
              }
              
              return originalOpen.call(this, method, url, ...args);
            };
            
            return xhr;
          };
          
          // 复制静态属性
          Object.setPrototypeOf(window.XMLHttpRequest, OriginalXHR);
          Object.defineProperties(window.XMLHttpRequest, Object.getOwnPropertyDescriptors(OriginalXHR));
          
          // 🔥 新增：动态重写页面中的资源URL
          function rewriteResourceUrls() {
            // 重写所有script标签的src
            document.querySelectorAll('script[src]').forEach(script => {
              const originalSrc = script.src;
              if (shouldProxyUrl(originalSrc) && !originalSrc.includes('flutter-webview-proxy.internal')) {
                const newSrc = convertToProxyUrl(originalSrc);
                console.log('[Universal-Network-Interceptor] Rewriting script src:', originalSrc, '->', newSrc);
                script.src = newSrc;
              }
            });
            
            // 重写所有link标签的href（CSS等）
            document.querySelectorAll('link[href]').forEach(link => {
              const originalHref = link.href;
              if (shouldProxyUrl(originalHref) && !originalHref.includes('flutter-webview-proxy.internal')) {
                const newHref = convertToProxyUrl(originalHref);
                console.log('[Universal-Network-Interceptor] Rewriting link href:', originalHref, '->', newHref);
                link.href = newHref;
              }
            });
          }
          
          // DOM加载完成后重写URL
          if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', rewriteResourceUrls);
          } else {
            rewriteResourceUrls();
          }
          
          // 使用MutationObserver监听动态添加的资源
          const observer = new MutationObserver(function(mutations) {
            mutations.forEach(function(mutation) {
              mutation.addedNodes.forEach(function(node) {
                if (node.nodeType === Node.ELEMENT_NODE) {
                  // 检查新添加的script标签
                  if (node.tagName === 'SCRIPT' && node.src) {
                    if (shouldProxyUrl(node.src) && !node.src.includes('flutter-webview-proxy.internal')) {
                      const newSrc = convertToProxyUrl(node.src);
                      console.log('[Universal-Network-Interceptor] Rewriting dynamic script src:', node.src, '->', newSrc);
                      node.src = newSrc;
                    }
                  }
                  
                  // 检查新添加的link标签
                  if (node.tagName === 'LINK' && node.href) {
                    if (shouldProxyUrl(node.href) && !node.href.includes('flutter-webview-proxy.internal')) {
                      const newHref = convertToProxyUrl(node.href);
                      console.log('[Universal-Network-Interceptor] Rewriting dynamic link href:', node.href, '->', newHref);
                      node.href = newHref;
                    }
                  }
                }
              });
            });
          });
          
          observer.observe(document, { childList: true, subtree: true });
          
          console.log('[Universal-Network-Interceptor] Network interception active for domain:', originalDomain);
        }
      })();
    </script>
  ''';
}
// Usage: In your _shouldInterceptRequest function, add this alongside the existing injection:
// 
// String injectionScript = '''
//   <existing receiver script>
// ''';
// 
// String networkInterceptorScript = getUniversalNetworkInterceptorScript();
// String combinedScript = networkInterceptorScript + injectionScript;
//
// if (htmlBody.contains('<head>')) {
//   htmlBody = htmlBody.replaceFirst('<head>', '<head>$combinedScript');
// } else if (htmlBody.contains('<html>')) {
//   htmlBody = htmlBody.replaceFirst('<html>', '<html><head>$combinedScript</head>');
// } else {
//   htmlBody = combinedScript + htmlBody;
// }

String getDomainBlockerScript(String originToBlock) {
  final escapedOrigin = originToBlock.replaceAll('"', '\\"');
  
  return '''
    <script type="text/javascript">
      // --- Universal Domain Blocker ---
      (function() {
        if (window.domainBlockingActive) return;
        window.domainBlockingActive = true;
        
        const BLOCKED_ORIGIN = "$escapedOrigin";
        const PROXY_HOST = "$PROXY_HOST";
        
        function isBlockedUrl(urlString) {
          if (typeof urlString !== 'string') return false;
          try {
            // 将相对路径转换为绝对路径再判断
            const absoluteUrl = new URL(urlString, document.baseURI).href;
            return absoluteUrl.includes(BLOCKED_ORIGIN) && !absoluteUrl.includes(PROXY_HOST);
          } catch(e) {
            return false; // 无效URL
          }
        }

        // 1. 阻止 location 的修改
        const originalLocation = window.location;
        try {
          Object.defineProperty(window, 'location', {
            get: function() { return originalLocation; },
            set: function(url) {
              if (isBlockedUrl(url)) {
                console.error(`[Domain-Blocker] ❌ Blocked location.href assignment to: \${url}`);
                return; // 直接阻止
              }
              console.log(`[Domain-Blocker] ✅ Allowed location change to: \${url}`);
              originalLocation.href = url;
            },
            configurable: true 
          });
        } catch(e) {
          console.warn('[Domain-Blocker] Could not redefine window.location. Some protections might be inactive.', e);
        }

        // 2. 阻止 window.open
        const originalOpen = window.open;
        window.open = function(url, ...args) {
          if (isBlockedUrl(url)) {
            console.error(`[Domain-Blocker] ❌ Blocked window.open to: \${url}`);
            return null; // 返回null表示窗口打开失败
          }
          return originalOpen.apply(this, arguments);
        };
        
        // ======================= ▼▼▼ 新增整合部分 ▼▼▼ =======================
        
        // 3. 新增：终极防线 - 拦截 beforeunload 事件
        // 这部分作为对 location.href 拦截失败的补充，是专门用来对付 cleverdialer 这种脚本的
        window.addEventListener('beforeunload', function(event) {
             // 在后台场景中，任何未经我们允许的导航都应被视为有害
             console.error(`[Domain-Blocker-Unload] ❌ Intercepted an unload/navigation event. Blocking it as a safety measure.`);
             
             // 标准方法，确保在所有浏览器中都能最大概率地阻止导航
             event.preventDefault(); 
             event.returnValue = ''; 
             return '';
        });

        // ======================= ▲▲▲ 新增整合部分结束 ▲▲▲ =======================





        console.log(`[Domain-Blocker] ✅ Active for origin: \${BLOCKED_ORIGIN}`);
      })();
    </script>
  ''';
}


/// 3. 处理器二：处理泄漏到原始域的直接请求 (完整代码)

Future<WebResourceResponse?> _handleLeakedRequest(
    InAppWebViewController controller, WebResourceRequest request) async {
      
  final uri = request.url;

  try {
    // 1. 使用 http 包发起网络请求，注意要传递原始请求中的头信息（特别是Cookie）
    // 注意：request.headers 是一个 Map<String, String>，可以直接使用
    _addLog('Making backend HTTP GET for LEAKED request to: $uri with headers: ${request.headers}');
    final response = await http.get(uri, headers: request.headers);
    _addLog('Backend response for LEAKED request: ${response.statusCode} for $uri');
        
    // 2. 准备一个新的 Map 来存放清理过的响应头
    final responseHeaders = <String, String>{};

    // 3. 定义需要被移除的有害响应头列表
    final headersToRemove = [
      'x-frame-options',
      'content-security-policy',
      'permissions-policy',
      'feature-policy',
      'cross-origin-embedder-policy',
      'cross-origin-opener-policy',
    ];

    // 4. 遍历从服务器收到的所有响应头
    response.headers.forEach((key, value) {
      // 将头信息的key转为小写以进行不区分大小写的比较
      final lowerCaseKey = key.toLowerCase();
      
      // 5. 如果当前头不在我们的“黑名单”中，就把它加入到最终的响应头里
      if (!headersToRemove.contains(lowerCaseKey)) {
        responseHeaders[key] = value;
      } else {
        // 否则，记录日志并丢弃它
        _addLog('For LEAKED request, REMOVED problematic header: "$key"');
      }
    });

    // 6. 构建并返回一个 WebResourceResponse
    return WebResourceResponse(
      // 使用从服务器获取的真实 content-type
      contentType: response.headers['content-type'],
      // 直接使用从服务器获取的原始响应体字节
      data: response.bodyBytes,
      // 使用从服务器获取的真实状态码
      statusCode: response.statusCode,
      // 使用我们清理过的头信息
      headers: responseHeaders,
      // 如果服务器返回了 reasonPhrase，也一并传递
      reasonPhrase: response.reasonPhrase,
    );
  } catch (e) {
    // 如果在代理过程中发生任何网络错误或其他异常
    _addLog('LEAKED request failed during proxying: $e');
    // 返回一个表示服务器错误的响应，这样WebView端能知道请求失败了
    return WebResourceResponse(
        contentType: 'text/plain',
        data: Uint8List.fromList('Leaked request proxy failed: $e'.codeUnits),
        statusCode: 500, // 500 Internal Server Error
        reasonPhrase: 'Proxy Error'
    );
  }
}







     

     


     
     
                  
                 
     // =======================================================================
  // == 您的 TestPage.dart 中其他代码（如 _setupJavaScriptHandlers）继续 ==
  // =======================================================================

  // ... 其他代码完全不变 ...

  Future<void> _setupJavaScriptHandlers(
    InAppWebViewController controller,
  ) async {
    controller.addJavaScriptHandler(
      handlerName: 'TestPageChannel',
      callback: (args) async {
        if (args.isNotEmpty) {
          final message = args[0] as String;
          _addLog('JS->Flutter (TestPageChannel): $message');
          if (message.contains('pluginLoaded')) {
            try {
              final data = jsonDecode(message);
              if (data['type'] == 'pluginLoaded') {
                setState(() {
                  _isPluginJsLoaded = true;
                  _loadedPluginId = data['pluginId'];
                });
                _addLog('Plugin JS loaded with ID: $_loadedPluginId');
              }
            } catch (e) {
              _addLog('Error parsing pluginLoaded message: $e');
            }
          }
        }
      },
    );
    controller.addJavaScriptHandler(
      handlerName: 'PluginResultChannel',
      callback: (args) async {
        if (args.isNotEmpty) {
          final result = args[0];
          _addLog('JS->Flutter (PluginResultChannel): $result');
          try {
            Map<String, dynamic> resultData;
            if (result is String) {
              resultData = jsonDecode(result);
            } else {
              resultData = Map<String, dynamic>.from(result);
            }
            final requestId = resultData['requestId'] as String?;


          // ▼▼▼        在这里添加会话清理逻辑         ▼▼▼
          // ▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼
          if (requestId != null) {
            _sessionOrigins.remove(requestId);
            _addLog('Session cleaned for completed requestId: $requestId. Current sessions: ${_sessionOrigins.length}');
          }
          // ▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲
          // ▲▲▲          会话清理逻辑结束           ▲▲▲



            if (requestId != null &&
                _requestCompleters.containsKey(requestId)) {
              _requestCompleters[requestId]!.complete(resultData);
              _requestCompleters.remove(requestId);
            }
            if (mounted) {
              setState(() {
                _queryResult = jsonEncode(resultData);
              });
            }
          } catch (e) {
            _addLog('Error parsing plugin result: $e');
            if (mounted) {
              setState(() {
                _queryResult = 'Error parsing result: $e';
              });
            }
          }
        }
      },
    );
  }

  Future<void> _loadPlugin() async {
    await _loadPluginJs();
  }

  @override
  void dispose() {
    _webViewController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.pluginTestPageTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _pluginUrlController,
              decoration: const InputDecoration(
                hintText: 'Enter plugin JS URL',
                labelText: 'Plugin JS URL',
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _loadPlugin,
              child: Text(
                _isPluginJsLoaded ? 'Plugin Loaded ✓' : 'Load Plugin JS',
              ),
            ),
            const SizedBox(height: 16),

            // --- 新增: 模式切换开关 ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Advanced Mode'),
                Switch(
                  value: _isAdvancedMode,
                  onChanged: (value) {
                    setState(() {
                      _isAdvancedMode = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),

            // --- 修改: 根据模式显示不同输入框 ---
            if (_isAdvancedMode)
              // --- 高级模式 ---
              Column(
                children: [
                  TextField(
                    controller: _advancedPhoneNumberController,
                    decoration: const InputDecoration(
                      hintText: 'Enter phone number',
                      labelText: 'Phone Number',
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _advancedNationalNumberController,
                    decoration: const InputDecoration(
                      hintText: 'Enter national number',
                      labelText: 'National Number',
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _advancedE164NumberController,
                    decoration: const InputDecoration(
                      hintText: 'Enter E164 number',
                      labelText: 'E164 Number',
                    ),
                  ),
                ],
              )
            else
              // --- 简单模式 ---
              Column(
                children: [
                  TextField(
                    controller: _simplePhoneController,
                    decoration: const InputDecoration(
                      hintText: 'Enter phone number',
                      labelText: 'Phone Number',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Text('Number Format: '),
                      const SizedBox(width: 8),
                      DropdownButton<String>(
                        value: _selectedNumberFormat,
                        items: const [
                          DropdownMenuItem(
                            value: 'phoneNumber',
                            child: Text('Phone Number'),
                          ),
                          DropdownMenuItem(
                            value: 'nationalNumber',
                            child: Text('National Number'),
                          ),
                          DropdownMenuItem(
                            value: 'e164Number',
                            child: Text('E164 Number'),
                          ),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              _selectedNumberFormat = value;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _isPluginJsLoaded ? _queryPhoneNumber : null,
              child: const Text('Query Phone Info'),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Query Result:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(_queryResult.isEmpty ? 'No result yet' : _queryResult),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Logs:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(
                          _jsLogs.isEmpty ? 'No logs yet' : _jsLogs,
                          style: const TextStyle(
                            fontSize: 12,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 1, // 最小高度
              child: InAppWebView(
                initialUrlRequest: URLRequest(url: WebUri('about:blank')),
                initialSettings: InAppWebViewSettings(
                  javaScriptEnabled: true,
                  domStorageEnabled: true,
                  databaseEnabled: true,
                  useShouldInterceptRequest: true,
                  userAgent:
                      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36',
                ),
                onWebViewCreated: (controller) async {
                  _webViewController = controller;
                  await _setupJavaScriptHandlers(controller);
                  _addLog('InAppWebView created and ready');
                },
                shouldInterceptRequest: _shouldInterceptRequest,
                onLoadStop: (controller, url) {
                  _addLog('WebView loaded: $url');
                },
                onConsoleMessage: (controller, consoleMessage) {
                  _addLog(
                    'Console [${consoleMessage.messageLevel}]: ${consoleMessage.message}',
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _queryPhoneNumber() async {
    if (!_isPluginJsLoaded || _loadedPluginId == null) {
      setState(() {
        _queryResult = 'Plugin JS not loaded. Please load the plugin first.';
      });
      return;
    }

    setState(() {
      _queryResult = 'Querying...';
    });

    String? phoneNumber, nationalNumber, e164Number;

    if (_isAdvancedMode) {
      // --- 高级模式 ---
      phoneNumber = _advancedPhoneNumberController.text.trim();
      nationalNumber = _advancedNationalNumberController.text.trim();
      e164Number = _advancedE164NumberController.text.trim();

      if (phoneNumber.isEmpty && nationalNumber.isEmpty && e164Number.isEmpty) {
        setState(() {
          _queryResult = 'Please enter at least one number in advanced mode.';
        });
        return;
      }
      _addLog('Starting query in advanced mode...');
    } else {
      // --- 简单模式 ---
      final singleNumber = _simplePhoneController.text.trim();
      if (singleNumber.isEmpty) {
        setState(() {
          _queryResult = 'Please enter a phone number.';
        });
        return;
      }
      _addLog(
        'Starting query for phone number: $singleNumber with format: $_selectedNumberFormat',
      );
      // 根据选择的格式，将 singleNumber 赋值给对应的变量
      switch (_selectedNumberFormat) {
        case 'phoneNumber':
          phoneNumber = singleNumber;
          break;
        case 'nationalNumber':
          nationalNumber = singleNumber;
          break;
        case 'e164Number':
          e164Number = singleNumber;
          break;
      }
    }

    try {
      final requestId = 'req_${DateTime.now().millisecondsSinceEpoch}';
      final completer = Completer<Map<String, dynamic>?>();
      _requestCompleters[requestId] = completer;

      // 准备参数，如果为 null 或空，则传递 'null' 字符串
      String phoneParam =
          (phoneNumber?.isNotEmpty ?? false) ? "'$phoneNumber'" : 'null';
      String nationalParam =
          (nationalNumber?.isNotEmpty ?? false) ? "'$nationalNumber'" : 'null';
      String e164Param =
          (e164Number?.isNotEmpty ?? false) ? "'$e164Number'" : 'null';

      await _webViewController!.evaluateJavascript(
        source: '''
        (function(pluginId, requestId) {
          if (window.plugin && window.plugin[pluginId] && window.plugin[pluginId].generateOutput) {
            console.log(`Calling plugin[pluginId].generateOutput with params: ${phoneParam}, ${nationalParam}, ${e164Param}, ${requestId}`);
            window.plugin[pluginId].generateOutput($phoneParam, $nationalParam, $e164Param, requestId);
          } else {
            console.error('Plugin or generateOutput function not found for pluginId:', pluginId);
            window.flutter_inappwebview.callHandler('PluginResultChannel', JSON.stringify({ 
              requestId: requestId,
              success: false, 
              error: 'Plugin or generateOutput function not found for pluginId: ' + pluginId 
            }));
          }
        })('$_loadedPluginId', '$requestId');
      ''',
      );

      final result = await completer.future.timeout(
        const Duration(seconds: 30),
        onTimeout: () {
    // ▼▼▼ 在这里添加清理逻辑 ▼▼▼
    _sessionOrigins.remove(requestId);
    _addLog('Session cleaned for TIMEOUT requestId: $requestId.');
    // ▲▲▲ 清理逻辑结束 ▲▲▲

          _requestCompleters.remove(requestId);
          _addLog('Query timeout for requestId: $requestId');
          return {'error': 'Query timeout', 'requestId': requestId};
        },
      );

      if (mounted) {
        setState(() {
          _queryResult = jsonEncode(result);
        });
      }
      _addLog('Query completed for requestId: $requestId');
    } catch (e) {
      _addLog('Query error: $e');
      if (mounted) {
        setState(() {
          _queryResult = 'Error: $e';
        });
      }
    }
  }
}
