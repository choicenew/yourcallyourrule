class CloudflareScripts {
  /// 终极脚本：修复了变量初始化逻辑，防止覆盖 Manual 设置
  static String get bypassUniversal => '''
    (function() {
      // 0. 防止脚本重复运行
      if (window._cf_bypass_active) return;
      window._cf_bypass_active = true;

      console.log("[Bypass] 🛡️ Shadow Hijacker Active");

      // 1. 初始化变量 (关键修正：使用 || 运算符，保留外部注入的值)
      window._capturedShadowRoots = []; 
      window._capturedIframes = [];     
      
      // ⭐ 核心修复：如果外部(main.dart)注入了 true，这里不要覆盖为 false
      window._cf_manual_mode = window._cf_manual_mode || false;
      
      window._hasClickedGlobal = false; 

      console.log("[Bypass] Mode Configured: " + (window._cf_manual_mode ? "MANUAL (No Click)" : "AUTO (Will Click)"));

      // 2. 劫持 attachShadow
      const originalAttachShadow = Element.prototype.attachShadow;
      Element.prototype.attachShadow = function(init) {
        const root = originalAttachShadow.call(this, init);
        window._capturedShadowRoots.push(root);
        if (window.flutter_inappwebview) {
          window.flutter_inappwebview.callHandler('TestPageChannel', "[Bypass] 🥷 Stole ShadowRoot mode=" + init.mode);
        }
        return root;
      };

      // 3. 劫持 iframe 创建
      const originalCreateElement = document.createElement;
      document.createElement = function(tagName) {
        const element = originalCreateElement.call(document, tagName);
        if (tagName.toLowerCase() === 'iframe') {
          window._capturedIframes.push(element);
        }
        return element;
      };

      // 4. 反指纹
      try { Object.defineProperty(navigator, 'webdriver', { get: () => false }); } catch (e) {}

      // 5. 模拟轨迹
      function simulatedMousePath(startElement, endElement) {
          if (window._cf_manual_mode) return; // 手动模式不画轨迹

          const startRect = startElement.getBoundingClientRect();
          const endRect = endElement.getBoundingClientRect();
          let currentX = startRect.left;
          let currentY = startRect.top;
          const targetX = endRect.left + endRect.width / 2;
          const targetY = endRect.top + endRect.height / 2;
          const steps = 10;
          
          if (window.flutter_inappwebview) {
             window.flutter_inappwebview.callHandler('TestPageChannel', "[Bypass] 🐭 Moving mouse...");
          }

          for (let i = 1; i <= steps; i++) {
              const ratio = i / steps;
              const nextX = currentX + (targetX - currentX) * ratio + (Math.random() - 0.5) * 2;
              const nextY = currentY + (targetY - currentY) * ratio + (Math.random() - 0.5) * 2;
              document.dispatchEvent(new MouseEvent('mousemove', {
                  bubbles: true, cancelable: true, view: window, isTrusted: true, clientX: nextX, clientY: nextY
              }));
          }
      }

      // 6. 执行点击
      function simulatedClick(element) {
        // ⭐ 手动模式双重保险
        if (window._cf_manual_mode) {
            console.log("[Bypass] Blocked click due to Manual Mode");
            return false;
        }
        if (window._hasClickedGlobal) return false;

        if (!element) return false;
        
        window._hasClickedGlobal = true;

        if (window.flutter_inappwebview) {
          window.flutter_inappwebview.callHandler('TestPageChannel', "[Bypass] 🎯 CLICKING " + element.tagName);
        }

        const rect = element.getBoundingClientRect();
        const x = rect.left + rect.width / 2;
        const y = rect.top + rect.height / 2;
        const opts = { bubbles: true, cancelable: true, view: window, isTrusted: true, clientX: x, clientY: y };
        
        element.dispatchEvent(new MouseEvent('pointerover', opts));
        element.dispatchEvent(new MouseEvent('mousedown', opts));
        element.focus();
        element.dispatchEvent(new MouseEvent('mouseup', opts));
        element.dispatchEvent(new MouseEvent('click', opts));
        return true;
      }

      // 7. 扫描循环
      function scan() {
        const currentUrl = window.location.href;
        const marker = new URLSearchParams(currentUrl).get('successMarker');
        
        // 成功检测
        if (marker && document.body.innerHTML.includes(marker)) {
             if (window.flutter_inappwebview && !window._cf_manual_mode) {
                window.flutter_inappwebview.callHandler('BypassSuccess', {
                  success: true, cookies: document.cookie, url: currentUrl
                });
             }
             return;
        }

        // ⭐ 手动模式：在这里就返回，不进入下面的查找逻辑
        if (window._cf_manual_mode === true) {
            // console.log("[Bypass] Manual Mode: Scanning paused.");
            return;
        }

        if (window._hasClickedGlobal) return;

        // 扫描 Shadow DOM
        for (let i = 0; i < window._capturedShadowRoots.length; i++) {
          try {
            const root = window._capturedShadowRoots[i];
            const cb = root.querySelector('input[type="checkbox"]');
            if (cb && !cb.checked) {
              if (window.flutter_inappwebview) window.flutter_inappwebview.callHandler('TestPageChannel', "[Bypass] ✅ Found checkbox in shadow");
              simulatedMousePath(document.body, cb);
              if (simulatedClick(cb)) return; 
            }
          } catch (e) {}
        }
        
        // 扫描 Iframe
        for (let i = 0; i < window._capturedIframes.length; i++) {
           try {
              const iframe = window._capturedIframes[i];
              if (iframe.contentDocument) {
                 const cb = iframe.contentDocument.querySelector('input[type="checkbox"]');
                 if (cb && !cb.checked) {
                      simulatedMousePath(document.body, cb);
                      if (simulatedClick(cb)) return;
                 }
              }
           } catch(e) {}
        }
      }

      setInterval(scan, 1000);
    })();
  ''';
}
