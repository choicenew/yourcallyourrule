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
        
        var oldIframes = document.querySelectorAll('iframe[id^="proxy_iframe_"]');
        for (var i = 0; i < oldIframes.length; i++) {
          var f = oldIframes[i];
          log('Removing zombie iframe: ' + f.id);
          f.src = 'about:blank';
          if (f.parentNode) f.parentNode.removeChild(f);
        }

        var iframe = document.createElement('iframe');
        iframe.id = 'proxy_iframe_' + requestId;
        iframe.style.width = '100%';
        iframe.style.height = '100%';
        iframe.style.border = 'none';
        iframe.style.visibility = 'visible';
        
        var proxyUrl = 'https://flutter-webview-proxy.internal/fetch?targetUrl=' + 
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

        window.removeEventListener('message', window._messageHandler);
        window._messageHandler = function(event) {
          if (event.data && event.data.type === 'phoneQueryResult') {
            log('Result received from Iframe [' + event.data.data.requestId + '], relaying to Flutter.');
            window.flutter_inappwebview.callHandler('PluginResultChannel', JSON.stringify(event.data.data));
          }
        };
        window.addEventListener('message', window._messageHandler, false);
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

      var originalAttachShadow = Element.prototype.attachShadow;
      Element.prototype.attachShadow = function(init) {
        console.log('🛡️ [Shadow-Hijack] 🌑 New ShadowRoot attached to <' + this.tagName + '>');
        var shadowRoot = originalAttachShadow.call(this, { mode: 'open' });
        window._discoveredShadowRoots.push(shadowRoot);
        return shadowRoot;
      };
      
      function findExistingShadowRoots(root) {
        var walkers = document.createTreeWalker(root, NodeFilter.SHOW_ELEMENT);
        while(walkers.nextNode()) {
          var el = walkers.currentNode;
          if (el.shadowRoot) {
             window._discoveredShadowRoots.push(el.shadowRoot);
          }
        }
      }
      setTimeout(function() { findExistingShadowRoots(document.body); }, 1000);
    })();
  ''';

  /// 域名拦截器：防止页面跳出代理域
  static String get domainBlockerJs => '''
    (function() {
      if (window._domainBlockerInjected) return;
      window._domainBlockerInjected = true;
      console.log('🛡️ [System-Pulse] Domain-Blocker Injected.');
      
      var PROXY_HOST = "flutter-webview-proxy.internal";
      console.log('🛡️ [Domain-Blocker] Active.');

      function wrapUrl(url) {
        try {
          if (!url) return url;
          var u = new URL(url, document.baseURI);
          
          if (u.host === PROXY_HOST) return url;

          if (u.pathname.indexOf('/fetch') !== -1 || (typeof url === 'string' && url.indexOf('/fetch') !== -1)) {
             var corrected = "https://" + PROXY_HOST + "/fetch" + u.search + u.hash;
             console.log('🛡️ [History-Interception] Correction (Matches /fetch): ' + corrected);
             return corrected;
          }

          var currentParams = new URL(window.location.href).searchParams;
          var reqId = currentParams.get('requestId');
          var marker = currentParams.get('successMarker');
          
          var proxyBase = "https://" + PROXY_HOST + "/fetch";
          var newUrl = proxyBase + "?targetUrl=" + encodeURIComponent(u.href);
          if (reqId) newUrl += "&requestId=" + reqId;
          if (marker) newUrl += "&successMarker=" + marker;
          
          console.log('🛡️ [History-Interception] Rewrote ' + url + ' to ' + newUrl);
          return newUrl; 
        } catch (e) {
          console.error('[Debug-Wrap] Error: ', e);
          return url;
        }
      }

      var originalReplaceState = history.replaceState;
      var originalPushState = history.pushState;

      history.replaceState = function(state, title, url) {
        try {
          if (url) {
            var u = new URL(url, document.baseURI);
            if (u.host && u.host !== PROXY_HOST && u.host !== location.host) {
               url = wrapUrl(url);
            }
          }
          return originalReplaceState.call(history, state, title, url);
        } catch(e) { 
          console.error('🛡️ [History-Interception] replaceState failed: ', e);
          try { return originalReplaceState.call(history, state, title); } catch(_) {}
        }
      };

      history.pushState = function(state, title, url) {
        try {
          if (url) {
            var u = new URL(url, document.baseURI);
            if (u.host && u.host !== PROXY_HOST && u.host !== location.host) {
               url = wrapUrl(url);
            }
          }
          return originalPushState.call(history, state, title, url);
        } catch(e) {
          try { return originalPushState.call(history, state, title); } catch(_) {}
        }
      };

      try {
        if (Object.defineProperty) {
          Object.defineProperty(navigator, 'webdriver', { get: function() { return false; } });
          Object.defineProperty(navigator, 'platform', { get: function() { return 'Win32'; } });
          Object.defineProperty(navigator, 'languages', { get: function() { return ['en-US', 'en']; } });
        }
      } catch(e) {}
    })();
  ''';

  /// 通用网络拦截器：由 Interceptor 注入所有 HTML
  /// 移植自 Legacy WebViewRequestInterceptor.dart
  static String get networkInterceptorJs => '''
    (function() {
      if (window.universalNetworkInterceptorInjected) return;
      window.universalNetworkInterceptorInjected = true;
      
      var PROXY_HOST = "flutter-webview-proxy.internal";  
      var PROXY_URL = "https://" + PROXY_HOST + "/fetch?targetUrl=";
      
      var _resolver = document.createElement('a');
      function toAbs(url) {
        _resolver.href = url;
        return _resolver.href;
      }

      var currentRequestId = "";
      var currentMarker = "";
      try {
        var params = window.location.search.substring(1).split('&');
        for (var i = 0; i < params.length; i++) {
          var pair = params[i].split('=');
          if (pair[0] === 'requestId') currentRequestId = pair[1];
          if (pair[0] === 'successMarker') currentMarker = pair[1];
        }
      } catch(e) {}

      function isCF(url) {
        if (!url || typeof url !== 'string') return false;
        if (url.indexOf(PROXY_HOST) !== -1) return false;
        var lower = url.toLowerCase();
        return lower.indexOf('cloudflare') !== -1 || lower.indexOf('listaspam.com') !== -1;
      }

      // ⭐ 深度伪装：让 CF 脚本以为自己在正确的域名下运行
      try {
        var originHost = "www.listaspam.com";
        var cfHost = "challenges.cloudflare.com";
        var fakeHost = window.location.href.indexOf('challenges.cloudflare.com') !== -1 ? cfHost : originHost;
        
        var _loc = {
          protocol: 'https:',
          host: fakeHost,
          hostname: fakeHost,
          port: '',
          pathname: window.location.pathname,
          search: window.location.search,
          hash: window.location.hash,
          href: window.location.href.replace(PROXY_HOST, fakeHost),
          origin: 'https://' + fakeHost,
          toString: function() { return this.href; }
        };

        // 尝试 Hook location (注意：location 很难直接 redefine，我们先尝试 defineProperty)
        try {
          Object.defineProperty(window, '_cf_location', { get: function() { return _loc; } });
          // 许多脚本使用 document.domain
          Object.defineProperty(document, 'domain', { get: function() { return fakeHost; } });
        } catch(e) {}
      } catch(e) {}

      function wrap(url) {
        if (!isCF(url)) return url;
        var abs = toAbs(url);
        var res = PROXY_URL + encodeURIComponent(abs);
        if (currentRequestId) res += "&requestId=" + currentRequestId;
        if (currentMarker) res += "&successMarker=" + currentMarker;
        console.log('🛡️ [Network-Audit] Proxying: ' + abs);
        return res;
      }

      // Hook Fetch
      if (window.fetch) {
        var _fetch = window.fetch;
        window.fetch = function(input, init) {
          var url = (typeof input === 'string') ? input : (input && input.url);
          if (isCF(url)) {
            var newUrl = wrap(url);
            if (typeof input === 'object' && input.url) {
               // Roughly clone request if needed, but keeping it simple
               return _fetch.call(this, newUrl, init);
            }
            return _fetch.call(this, newUrl, init);
          }
          return _fetch.apply(this, arguments);
        };
      }

      // Hook XHR
      var _XHR = window.XMLHttpRequest;
      window.XMLHttpRequest = function() {
        var xhr = new _XHR();
        var _open = xhr.open;
        xhr.open = function(method, url) {
          if (isCF(url)) url = wrap(url);
          return _open.apply(this, arguments);
        };
        return xhr;
      };

      // Hook Props
      function hookProp(proto, prop, type) {
        try {
          var desc = Object.getOwnPropertyDescriptor(proto, prop);
          if (!desc) return;
          Object.defineProperty(proto, prop, {
            get: function() { return desc.get.call(this); },
            set: function(val) {
              if (isCF(val)) val = wrap(val);
              desc.set.call(this, val);
            }
          });
        } catch(e) {}
      }
      hookProp(HTMLScriptElement.prototype, 'src', 'src');
      hookProp(HTMLIFrameElement.prototype, 'src', 'src');
      hookProp(HTMLLinkElement.prototype, 'href', 'href');

      // Hook setAttribute
      var _setAttr = Element.prototype.setAttribute;
      Element.prototype.setAttribute = function(n, v) {
        if ((n === 'src' || n === 'href') && isCF(v)) v = wrap(v);
        return _setAttr.call(this, n, v);
      };

      // ⭐ 核心增强：Hook createElement，拦截所有动态脚本
      var _create = document.createElement;
      document.createElement = function(tag) {
        var el = _create.call(document, tag);
        if (tag.toLowerCase() === 'script' || tag.toLowerCase() === 'iframe') {
          var _s = "";
          Object.defineProperty(el, 'src', {
            get: function() { return _s; },
            set: function(v) {
              if (isCF(v)) v = wrap(v);
              _s = v;
              el.setAttribute('src', v);
            }
          });
        }
        return el;
      };

      // ⭐ 核心增强：Hook document.write
      var _write = document.write;
      var _writeln = document.writeln;
      function patchHTML(h) {
        if (typeof h !== 'string') return h;
        if (h.indexOf('challenges.cloudflare.com') !== -1) {
           console.log('🛡️ [Write-Hook] Intercepting write-content.');
           return h.replace(/https:\/\/challenges\.cloudflare\.com/g, function(m) { return wrap(m); });
        }
        return h;
      }
      document.write = function(h) { return _write.call(document, patchHTML(h)); };
      document.writeln = function(h) { return _writeln.call(document, patchHTML(h)); };

      console.log('🛡️ [Network-Audit] Hardened Interceptor Active.');
    })();
  ''';

  /// 自动点击脚本：由 InteractionEmitter 调用或在 Iframe 中自动运行
  static String get clickerJs => '''
    (function() {
        if (window._clickerInjected) return;
        window._clickerInjected = true;
        console.log('🛡️ [System-Pulse] Clicker Injected.');
        
        console.log("🛡️ [Clicker] Active. Scanning for Turnstile...");
        
        var SEARCH_TARGETS = ['input[type="checkbox"]', '.ctp-checkbox-label', '.cb-i', '#challenge-stage', 'button', 'a[href*="verify"]', 'iframe', '.cf-turnstile', '.cf-challenge'];
        var _scanCount = 0;

        function performClick(found) {
            console.log("🛡️ [Clicker] 🎯 Target found, executing click: ", found);
            var rect = found.getBoundingClientRect();
            var x = rect.left + rect.width / 2;
            var y = rect.top + rect.height / 2;
            
            var options = { bubbles: true, cancelable: true, view: window, clientX: x, clientY: y };
            try {
              found.dispatchEvent(new PointerEvent('pointerover', options));
              found.dispatchEvent(new PointerEvent('pointerdown', { bubbles: options.bubbles, cancelable: options.cancelable, view: options.view, clientX: options.clientX, clientY: options.clientY, button: 0 }));
              found.dispatchEvent(new PointerEvent('pointerup', { bubbles: options.bubbles, cancelable: options.cancelable, view: options.view, clientX: options.clientX, clientY: options.clientY, button: 0 }));
            } catch(e) {}
            found.dispatchEvent(new MouseEvent('click', { bubbles: options.bubbles, cancelable: options.cancelable, view: options.view, clientX: options.clientX, clientY: options.clientY, detail: 1 }));
            return true;
        }

        function attemptClick() {
            var found = null;
            
            function scanContext(ctx, name) {
                if (!ctx) return null;
                try {
                  for (var i = 0; i < SEARCH_TARGETS.length; i++) {
                      var selector = SEARCH_TARGETS[i];
                      var els = ctx.querySelectorAll(selector);
                      if (els && els.length > 0) {
                        for (var j = 0; j < els.length; j++) {
                          var el = els[j];
                          var rect = el.getBoundingClientRect();
                          if (rect.width > 0 && rect.height > 0) {
                             console.log("🛡️ [Clicker] Found target in " + name + " via " + selector);
                             return el;
                          }
                        }
                      }
                  }
                } catch(e) {}
                return null;
            }

            _scanCount++;
            if (_scanCount % 5 === 0) {
               var bodyText = document.body ? document.body.innerText.substring(0, 50).replace(/\\n/g, ' ') : 'N/A';
               console.log("🛡️ [Clicker] Pulse (" + _scanCount + ") | Frames: " + window.frames.length + " | Shadows: " + (window._discoveredShadowRoots ? window._discoveredShadowRoots.length : 0) + " | Content: [" + bodyText + "...]");
            }

            // 1. 主文档扫描
            found = scanContext(document, "Main Document");
            if (found) {
                if (found.tagName === 'IFRAME') {
                   console.log("🛡️ [Clicker] Found an iframe: " + found.src);
                } else {
                   return performClick(found);
                }
            }

            // 2. 已发现的 Shadow DOM 扫描
            var shadows = window._discoveredShadowRoots || [];
            for (var k = 0; k < shadows.length; k++) {
                found = scanContext(shadows[k], "ShadowRoot-" + k);
                if (found) return performClick(found);
            }

            // 3. 递归扫描 Iframe
            try {
                for (var fidx = 0; fidx < window.frames.length; fidx++) {
                    var f = window.frames[fidx];
                    try {
                        var frameDoc = f.document;
                        found = scanContext(frameDoc, "Iframe-" + fidx);
                        if (found) return performClick(found);
                        
                        if (f._discoveredShadowRoots) {
                           for (var sidx = 0; sidx < f._discoveredShadowRoots.length; sidx++) {
                               found = scanContext(f._discoveredShadowRoots[sidx], "Iframe-" + fidx + "-Shadow-" + sidx);
                               if (found) return performClick(found);
                           }
                        }
                    } catch(e) { }
                }
            } catch(e) {}

            return false;
        }

        var interval = setInterval(function() {
            if (attemptClick()) {
                console.log("🛡️ [Clicker] Click successful, stopping poll.");
                clearInterval(interval);
            }
        }, 1000);
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
        const marker = params.get('successMarker');
        if (!marker) return false;

        function findInContext(ctx) {
            if (!ctx) return null;
            try {
                const found = ctx.getElementById(marker) || 
                              (ctx.getElementsByClassName && ctx.getElementsByClassName(marker).length > 0) ||
                              (ctx.querySelector && ctx.querySelector(marker));
                if (found) {
                    const rect = found.getBoundingClientRect();
                    if (rect.width > 0 && rect.height > 0) return found;
                    if (found.innerText && found.innerText.trim().length > 0) return found;
                }
            } catch(e) {}
            return null;
        }

        // 1. 扫描当前文档
        let target = findInContext(document);
        
        // 2. 扫描子 Iframe
        if (!target) {
            try {
                for (let i = 0; i < window.frames.length; i++) {
                    try {
                        target = findInContext(window.frames[i].document);
                        if (target) break;
                    } catch(e) {}
                }
            } catch(e) {}
        }

        if (target) {
            console.log("🛡️ [Result-Monitor] ✅ Success Marker Found: " + marker);
            
            window.parent.postMessage({
                type: 'phoneQueryResult',
                data: {
                    success: true,
                    content: target.ownerDocument.documentElement.outerHTML, // 返回包含目标的那个文档
                    cookies: document.cookie,
                    requestId: params.get('requestId')
                }
            }, '*');
            return true;
        }
        return false;
    }

    let resultInterval = setInterval(() => {
        if (checkSuccess()) {
            console.log("🛡️ [Result-Monitor] Result delivered, stopping monitor.");
            clearInterval(resultInterval);
        }
    }, 3000);
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
