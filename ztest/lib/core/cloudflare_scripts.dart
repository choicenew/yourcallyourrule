class CloudflareScripts {
  /// 影子劫持 + 自动点击的原子脚本
  /// 必须在 AT_DOCUMENT_START 注入
  static String get bypassUniversal => '''
    (function() {
      if (window._cf_bypass_active) return;
      window._cf_bypass_active = true;

      console.log("[Bypass] 🛡️ Shadow Hijacker Active");

      // 1. 准备赃物存放点和状态锁
      window._capturedShadowRoots = [];
      window._capturedIframes = [];
      window._clickLockoutTime = 0; 
      
      // 2. 【核心魔法】劫持 attachShadow
      const originalAttachShadow = Element.prototype.attachShadow;
      Element.prototype.attachShadow = function(init) {
        const root = originalAttachShadow.call(this, init);
        window._capturedShadowRoots.push(root);
        if (window.flutter_inappwebview) {
          window.flutter_inappwebview.callHandler('TestPageChannel', "[Bypass] 🥷 Stole ShadowRoot from <" + this.tagName + "> mode=" + init.mode);
        }
        return root;
      };

      // 3. 劫持 iframe 创建
      const originalCreateElement = document.createElement;
      document.createElement = function(tagName) {
        const element = originalCreateElement.call(document, tagName);
        if (tagName.toLowerCase() === 'iframe') {
          window._capturedIframes.push(element);
          if (window.flutter_inappwebview) {
            window.flutter_inappwebview.callHandler('TestPageChannel', "[Bypass] 📦 Captured iframe");
          }
        }
        return element;
      };

      // 4. 【反指纹】干扰检测 API
      try {
          // 伪造 Webdriver 属性
          Object.defineProperty(navigator, 'webdriver', { get: () => false });
          // 伪造语言
          Object.defineProperty(navigator, 'languages', { get: () => ['en-US', 'en'] });
          // 伪造插件列表
          const pluginData = [
              { name: 'Chrome PDF Plugin', description: 'Portable Document Format' },
              { name: 'Chrome PDF Viewer', description: 'Portable Document Format' },
          ];
          const mockPlugins = {
              length: pluginData.length,
              item: (index) => pluginData[index] || null,
              namedItem: (name) => pluginData.find(p => p.name === name) || null,
          };
          Object.defineProperty(navigator, 'plugins', { get: () => mockPlugins });
          
          if (window.flutter_inappwebview) {
             window.flutter_inappwebview.callHandler('TestPageChannel', "[Bypass] 👻 Anti-Fingerprint Evasion Loaded.");
          }
      } catch (e) { /* Evasion failed */ }
      
      // 5. 【核心增强】模拟鼠标移动轨迹
      function simulatedMousePath(startElement, endElement) {
          const startRect = startElement ? startElement.getBoundingClientRect() : { left: 100, top: 100, width: 0, height: 0 };
          const endRect = endElement.getBoundingClientRect();
          
          let currentX = startRect.left + startRect.width / 2;
          let currentY = startRect.top + startRect.height / 2;
          
          const targetX = endRect.left + endRect.width / 2;
          const targetY = endRect.top + endRect.height / 2;
          
          const steps = 10 + Math.floor(Math.random() * 10); // 10-19 个步骤
          
          if (window.flutter_inappwebview) {
             // ⭐ 最终修正：使用 JS 字符串拼接，避免 Dart/JS 模板字符串冲突
             window.flutter_inappwebview.callHandler(
                'TestPageChannel', 
                "[Bypass] 🐭 Generating " + steps + " steps mouse path from (" + startRect.left + "," + startRect.top + ") to (" + targetX + "," + targetY + ")"
             );
          }
          for (let i = 1; i <= steps; i++) {
              const ratio = i / steps;
              const nextX = currentX + (targetX - currentX) * ratio;
              const nextY = currentY + (targetY - currentY) * ratio;

              const jitterX = (Math.random() - 0.5) * 5; // 1-5 像素的随机抖动
              const jitterY = (Math.random() - 0.5) * 5;
              
              currentX = nextX + jitterX;
              currentY = nextY + jitterY;

              const event = new MouseEvent('mousemove', {
                  bubbles: true, cancelable: true, view: window, isTrusted: true,
                  clientX: currentX, 
                  clientY: currentY
              });
              document.dispatchEvent(event);
              
              const delay = 20 + Math.random() * 30; // 20ms - 50ms 延迟
              
              // 模拟人眼的感知速度（同步延迟）
              const start = Date.now();
              while (Date.now() < start + delay);
          }
      }

      // 6. 模拟真实点击 (加入点击锁)
      function simulatedClick(element) {
        // 检查点击锁：如果在锁定时间内，则跳过
        if (Date.now() < window._clickLockoutTime) {
            return false;
        }

        // 设置点击锁：锁定 15 秒，等待 Cloudflare 验证结果
        window._clickLockoutTime = Date.now() + 15000; 

        if (!element || element.getAttribute('data-bypass-clicked') === 'true') return false;
        element.setAttribute('data-bypass-clicked', 'true');
        
        if (window.flutter_inappwebview) {
          window.flutter_inappwebview.callHandler('TestPageChannel', "[Bypass] 🎯 Clicking element: " + element.tagName + (element.id ? ('#' + element.id) : ''));
        }

        // 模拟点击的中心点
        const rect = element.getBoundingClientRect();
        const randX = rect.left + rect.width * (0.45 + Math.random() * 0.1); 
        const randY = rect.top + rect.height * (0.45 + Math.random() * 0.1);
        const baseOptions = { bubbles: true, cancelable: true, view: window, isTrusted: true, clientX: randX, clientY: randY };
        
        const events = [
          { name: 'pointerover', delay: 0 },
          { name: 'pointerenter', delay: 50 },
          { name: 'pointerdown', delay: 100 + Math.random() * 50 },
          { name: 'mousedown', delay: 150 + Math.random() * 50 },
          { name: 'mouseup', delay: 200 + Math.random() * 50 },
          { name: 'pointerup', delay: 250 + Math.random() * 50 },
          { name: 'click', delay: 350 + Math.random() * 100 },
        ];

        events.forEach(event => {
          setTimeout(() => {
            element.dispatchEvent(new MouseEvent(event.name, baseOptions));
          }, event.delay);
        });
        
        return true;
      }

      // 7. 扫描器
      function scan() {
        // A. 最终成功检测（放在最前面，一成功就退出）
        const currentUrl = window.location.href;
        const successMarker = new URLSearchParams(currentUrl).get('successMarker');
        
        const isChallengePage = document.title.includes('Just a moment') || 
                                 document.title.includes('Checking your Browser') || 
                                 document.title.includes('ListaSpam security'); 
                                 
        const hasChallengeContent = document.body.innerHTML.includes('Verifying') ||
                                    document.body.innerHTML.includes('captcha');
                                    
        // 判定成功的标准：页面标题和内容都不是 Challenge 页面特征，且 URL 包含我们的标记
        const isSuccess = !isChallengePage && !hasChallengeContent && currentUrl.includes(successMarker);

        if (isSuccess) {
          if (window.flutter_inappwebview) {
            setTimeout(() => {
              window.flutter_inappwebview.callHandler('BypassSuccess', {
                success: true,
                cookies: document.cookie,
                url: currentUrl
              });
            }, 500); 
            // 成功后，不再执行后续代码
            return; 
          }
        }
        
        // --- 如果未成功，则执行点击逻辑 ---
        if (Date.now() < window._clickLockoutTime) return;

        let clickedThisRun = false;

        // B. 扫描所有偷来的 Shadow Root (Turnstile)
        window._capturedShadowRoots.forEach((root, index) => {
          if (clickedThisRun) return; 
          try {
            const cb = root.querySelector('input[type="checkbox"]');
            if (cb && !cb.checked) {
              if (window.flutter_inappwebview) {
                 window.flutter_inappwebview.callHandler('TestPageChannel', "[Bypass] ✅ Found fresh checkbox in shadow #" + index);
              }
              // 重置点击标记
              cb.removeAttribute('data-bypass-clicked');
              
              // ⭐ 关键：在点击前模拟鼠标轨迹
              simulatedMousePath(document.body, cb); 
              
              clickedThisRun = simulatedClick(cb);
            }
          } catch (e) { /* Ignore */ }
        });
        
        // C. 兜底逻辑：扫描 iframe 内部
        window._capturedIframes.forEach((iframe) => {
           if (clickedThisRun) return;
           try {
              if (iframe.contentDocument) {
                 const cb = iframe.contentDocument.querySelector('input[type="checkbox"]');
                 if (cb && !cb.checked) {
                      if (window.flutter_inappwebview) {
                          window.flutter_inappwebview.callHandler('TestPageChannel', "[Bypass] ✅ Found fresh checkbox in iframe (Fallback)");
                      }
                      cb.removeAttribute('data-bypass-clicked');
                      simulatedMousePath(document.body, cb);
                      clickedThisRun = simulatedClick(cb);
                 }
              }
           } catch(e) { /* Cross-origin iframe */ }
        });
      }

      // 8. 启动循环
      setInterval(scan, 2000); 
      
      if (window.flutter_inappwebview) {
        window.flutter_inappwebview.callHandler('TestPageChannel', "[Bypass] 🛡️ Injection Complete. Hunting for targets...");
      }
    })();
  ''';
}
