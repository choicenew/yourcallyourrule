// ztest/lib/core/cloudflare_scripts.dart

/// Cloudflare 相关脚本注册表
/// 模块化存放所有注入 WebView 的 JS 逻辑。
class CloudflareScripts {
  /// Iframe 桥接模板：运行在 about:blank，负责开启代理 Iframe
  static String get bridgeTemplateJs => '''
    (function() {
      if (window._legacyBridgeInjected) return;
      window._legacyBridgeInjected = true;
      
      function log(msg) {
        console.log('[Tiny-Legacy-Bridge] ' + msg);
        if (window.flutter_inappwebview) {
          window.flutter_inappwebview.callHandler('TestPageChannel', '[Bridge] ' + msg);
        }
      }

      log('Active in ' + window.location.href);

      window.startLegacyBypass = function(targetUrl, requestId) {
        log('Starting bypass for: ' + targetUrl);
        
        // 创建 Iframe
        const iframe = document.createElement('iframe');
        iframe.id = 'proxy_iframe_' + requestId;
        iframe.style.width = '100%';
        iframe.style.height = '100%';
        iframe.style.border = 'none';
        
        // 构造代理入口 URL
        const proxyUrl = 'https://flutter-webview-proxy.internal/fetch?targetUrl=' + 
                        encodeURIComponent(targetUrl) + 
                        '&requestId=' + requestId;
        
        iframe.src = proxyUrl;
        
        iframe.onload = function() {
          log('Iframe loaded: ' + proxyUrl);
        };
        
        iframe.onerror = function() {
          log('Iframe failed to load: ' + proxyUrl);
        };

        document.body.appendChild(iframe);

        // 转发来自 Iframe 的结果
        window.addEventListener('message', function(event) {
          if (event.data && event.data.type === 'phoneQueryResult') {
            log('Result received from Iframe, relaying to Flutter.');
            window.flutter_inappwebview.callHandler('PluginResultChannel', JSON.stringify(event.data.data));
          }
        }, false);
      };
    })();
  ''';

  /// 影子劫持：强制暴露封闭的 Shadow DOM
  static String get shadowHijackJs => '''
    (function() {
      if (window._shadowHijackInjected) return;
      window._shadowHijackInjected = true;
      
      window._discoveredShadowRoots = window._discoveredShadowRoots || [];
      
      console.log('🛡️ [Shadow-Hijack] Activating...');

      const originalAttachShadow = Element.prototype.attachShadow;
      Element.prototype.attachShadow = function(init) {
        const shadowRoot = originalAttachShadow.call(this, { ...init, mode: 'open' });
        window._discoveredShadowRoots.push(shadowRoot);
        return shadowRoot;
      };
      
      function findExistingShadowRoots(root) {
        const walkers = document.createTreeWalker(root, NodeFilter.SHOW_ELEMENT);
        while(walkers.nextNode()) {
          const el = walkers.currentNode;
          if (el.shadowRoot) {
             window._discoveredShadowRoots.push(el.shadowRoot);
          }
        }
      }
      setTimeout(() => findExistingShadowRoots(document.body), 1000);
    })();
  ''';

  /// 域名拦截器：防止页面跳出代理域
  static String get domainBlockerJs => '''
    (function() {
      if (window._domainBlockerInjected) return;
      window._domainBlockerInjected = true;
      
      const PROXY_HOST = "flutter-webview-proxy.internal";
      console.log('🛡️ [Domain-Blocker] Active.');

      window.addEventListener('beforeunload', (e) => {
        console.log('🛡️ [Domain-Blocker] Prevented navigation/unload.');
        e.preventDefault();
        e.returnValue = '';
      });
    })();
  ''';

  /// 通用网络拦截器：由 Interceptor 注入所有 HTML
  /// 移植自 Legacy WebViewRequestInterceptor.dart
  static String get networkInterceptorJs => '''
    (function() {
      if (window.universalNetworkInterceptorInjected) return;
      window.universalNetworkInterceptorInjected = true;
      
      console.log('[Universal-Network-Interceptor] Activating...');
      
      const PROXY_SCHEME = "https";
      const PROXY_HOST = "flutter-webview-proxy.internal";  
      const PROXY_PATH_FETCH = "/fetch";
      const PROXY_TEMPLATE = PROXY_SCHEME + "://" + PROXY_HOST + PROXY_PATH_FETCH + "?targetUrl=";
      
      let originalDomain = '';
      try {
        const urlParams = new URLSearchParams(window.location.search);
        const targetUrl = decodeURIComponent(urlParams.get('targetUrl') || '');
        if (targetUrl) {
          originalDomain = new URL(targetUrl).origin;
        }
        
        if (!originalDomain && document.referrer) {
           const refMatch = document.referrer.match(/targetUrl=([^&]+)/);
           if (refMatch) originalDomain = new URL(decodeURIComponent(refMatch[1])).origin;
        }
        console.log('[Universal-Network-Interceptor] Original Domain:', originalDomain);
      } catch (e) {}

      if (originalDomain && !document.querySelector('base[href]')) {
        const base = document.createElement('base');
        base.href = originalDomain + '/';
        document.head ? document.head.insertBefore(base, document.head.firstChild) : null;
      }

      function shouldProxyUrl(url) {
        try {
          const u = new URL(url, originalDomain || window.location.href);
          return (originalDomain && u.origin === originalDomain) || u.hostname.includes('cloudflare.com');
        } catch(e) { return false; }
      }

      function toProxy(url) {
        try {
          const abs = new URL(url, originalDomain || window.location.href).href;
          const urlParams = new URLSearchParams(window.location.search);
          let pUrl = PROXY_TEMPLATE + encodeURIComponent(abs);
          // 继承 requestId 和 successMarker
          if (urlParams.has('requestId')) pUrl += '&requestId=' + urlParams.get('requestId');
          if (urlParams.has('successMarker')) pUrl += '&successMarker=' + urlParams.get('successMarker');
          return pUrl;
        } catch(e) { return url; }
      }

      // XHR
      const XHR = window.XMLHttpRequest;
      window.XMLHttpRequest = function() {
        const xhr = new XHR();
        const open = xhr.open;
        xhr.open = function(m, u, ...args) {
          if (shouldProxyUrl(u)) u = toProxy(u);
          return open.call(this, m, u, ...args);
        };
        return xhr;
      };
      Object.setPrototypeOf(window.XMLHttpRequest, XHR);
      Object.defineProperties(window.XMLHttpRequest, Object.getOwnPropertyDescriptors(XHR));

      // Fetch
      const _fetch = window.fetch;
      window.fetch = function(res, opt = {}) {
        let u = res instanceof Request ? res.url : res;
        if (shouldProxyUrl(u)) {
          const pu = toProxy(u);
          if (res instanceof Request) return _fetch.call(this, new Request(pu, res), opt);
          return _fetch.call(this, pu, { mode: 'cors', ...opt });
        }
        return _fetch.apply(this, arguments);
      };
    })();
  ''';

  /// 自动点击脚本：由 InteractionEmitter 调用或在 Iframe 中自动运行
  static String get clickerJs => '''
    (function() {
        if (window._clickerInjected) return;
        window._clickerInjected = true;
        
        console.log("🛡️ [Clicker] Active. Scanning for Turnstile...");

        const SEARCH_TARGETS = ['input[type="checkbox"]', '.ctp-checkbox-label', '.cb-i', '#challenge-stage'];

        function attemptClick() {
            let found = null;
            const contexts = [document, ...(window._discoveredShadowRoots || [])];
            
            for (let ctx of contexts) {
                for (let selector of SEARCH_TARGETS) {
                    const el = ctx.querySelector(selector);
                    if (el) {
                        const rect = el.getBoundingClientRect();
                        if (rect.width > 0 && rect.height > 0) {
                            found = el;
                            break;
                        }
                    }
                }
                if (found) break;
            }

            if (found) {
                console.log("🛡️ [Clicker] 🎯 Target found: ", found);
                const rect = found.getBoundingClientRect();
                const x = rect.left + rect.width / 2;
                const y = rect.top + rect.height / 2;
                
                const options = { bubbles: true, cancelable: true, view: window, clientX: x, clientY: y };
                found.dispatchEvent(new PointerEvent('pointerover', options));
                found.dispatchEvent(new PointerEvent('pointerdown', { ...options, button: 0 }));
                found.dispatchEvent(new PointerEvent('pointerup', { ...options, button: 0 }));
                found.dispatchEvent(new MouseEvent('click', { ...options, detail: 1 }));
                return true;
            }
            return false;
        }

        let interval = setInterval(() => {
            if (attemptClick()) {
                console.log("🛡️ [Clicker] Click successful, stopping poll.");
                clearInterval(interval);
            }
        }, 2000);
    })();
  ''';

  /// 结果监控脚本：运行在 Iframe 中，寻找 successMarker 并通知宿主
  static String get resultMonitorJs => '''
    (function() {
        if (window._resultMonitorInjected) return;
        window._resultMonitorInjected = true;
        
        console.log("🛡️ [Result-Monitor] Active.");

        function checkSuccess() {
            const params = new URLSearchParams(window.location.search);
            const marker = params.get('successMarker') || 'number_data_box';

            if (document.body && document.body.innerHTML.includes(marker)) {
                console.log("🛡️ [Result-Monitor] ✅ Success Marker Found: " + marker);
                
                window.parent.postMessage({
                    type: 'phoneQueryResult',
                    data: {
                        success: true,
                        content: document.documentElement.outerHTML,
                        cookies: document.cookie,
                        requestId: params.get('requestId')
                    }
                }, '*');
                return true;
            }
            return false;
        }

        setInterval(checkSuccess, 3000);
    })();
  ''';

  /// 接收器脚本：处理来自父窗口的消息（例如 executeScript）
  static String get receiverJs => '''
    (function() {
      console.log('[Injected-Receiver] Active.');
      function handleMessage(event) {
        if (event.data && event.data.type === 'executeScript') {
          try {
            eval(event.data.script);
          } catch (e) {
            console.error('[Injected-Receiver] Error:', e);
            window.parent.postMessage({ type: 'phoneQueryResult', data: { success: false, error: 'Eval execution failed: ' + e.toString() } }, '*');
          }
        }
      }
      window.removeEventListener('message', handleMessage);
      window.addEventListener('message', handleMessage, false);
    })();
  ''';
}
