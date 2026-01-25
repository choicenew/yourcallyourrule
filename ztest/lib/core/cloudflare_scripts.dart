class CloudflareScripts {
  static String get bypassUniversal => '''
    (function() {
      if (window._cf_bypass_active) return;
      window._cf_bypass_active = true;

      console.log("[Bypass] 🛡️ Mobile Touch Simulation Active");

      window._capturedShadowRoots = []; 
      window._capturedIframes = [];     
      window._cf_manual_mode = window._cf_manual_mode || false;
      window._hasClickedGlobal = false; 
      
      // 初始化手指位置
      window._lastTouchX = Math.random() * window.innerWidth;
      window._lastTouchY = Math.random() * window.innerHeight;

      // --- 1. 劫持逻辑 (保持一致，确保 Manual/Auto 环境相同) ---
      const originalAttachShadow = Element.prototype.attachShadow;
      Element.prototype.attachShadow = function(init) {
        const root = originalAttachShadow.call(this, init);
        window._capturedShadowRoots.push(root);
        return root;
      };

      const originalCreateElement = document.createElement;
      document.createElement = function(tagName) {
        const element = originalCreateElement.call(document, tagName);
        if (tagName.toLowerCase() === 'iframe') {
          window._capturedIframes.push(element);
        }
        return element;
      };

      // 隐藏 webdriver，确保 Manual 模式也有这个特征
      try { Object.defineProperty(navigator, 'webdriver', { get: () => false }); } catch (e) {}

      // --- 2. 核心：手指触摸模拟引擎 ---

      function createTouch(target, identifier, x, y) {
          return new Touch({
              identifier: identifier,
              target: target,
              clientX: x,
              clientY: y,
              screenX: x, // 简化处理
              screenY: y,
              pageX: x,
              pageY: y,
              radiusX: 10 + Math.random() * 5, // 模拟手指接触面积
              radiusY: 10 + Math.random() * 5,
              rotationAngle: Math.random() * 10,
              force: 0.5 + Math.random() * 0.5, // 模拟压力
          });
      }

      function sendTouchEvent(type, element, touchList) {
          const event = new TouchEvent(type, {
              cancelable: true,
              bubbles: true,
              touches: touchList,
              targetTouches: touchList,
              changedTouches: touchList,
              view: window,
              isTrusted: true 
          });
          element.dispatchEvent(event);
      }

      // 贝塞尔曲线 (保持不变)
      function cubicBezier(t, p0, p1, p2, p3) {
        const cX = 3 * (p1.x - p0.x), bX = 3 * (p2.x - p1.x) - cX, aX = p3.x - p0.x - cX - bX;
        const cY = 3 * (p1.y - p0.y), bY = 3 * (p2.y - p1.y) - cY, aY = p3.y - p0.y - cY - bY;
        return { 
            x: (aX * Math.pow(t, 3)) + (bX * Math.pow(t, 2)) + (cX * t) + p0.x,
            y: (aY * Math.pow(t, 3)) + (bY * Math.pow(t, 2)) + (cY * t) + p0.y
        };
      }

      // 模拟手指滑动 (Touch Move)
      async function humanTouchMove(targetX, targetY, duration) {
          if (window._cf_manual_mode) return;

          const startX = window._lastTouchX;
          const startY = window._lastTouchY;
          
          // 随机控制点
          const cp1 = { x: startX + (targetX - startX) * 0.5 + (Math.random()-0.5)*50, y: startY + (targetY - startY) * 0.1 };
          const cp2 = { x: startX + (targetX - startX) * 0.5, y: startY + (targetY - startY) * 0.9 + (Math.random()-0.5)*50 };

          const steps = 20;
          const stepTime = duration / steps;
          const touchId = Math.floor(Math.random() * 1000);

          for (let i = 0; i <= steps; i++) {
              let t = i / steps;
              let easeT = t * (2 - t); 
              
              const pos = cubicBezier(easeT, {x:startX, y:startY}, cp1, cp2, {x: targetX, y: targetY});
              
              // 模拟手指抖动
              pos.x += (Math.random() - 0.5) * 3;
              pos.y += (Math.random() - 0.5) * 3;

              // 构造 Touch 对象列表
              // 注意：TouchMove 依然需要 target 元素，这里简化为 document.body 或当前目标
              const touch = createTouch(document.body, touchId, pos.x, pos.y);
              sendTouchEvent('touchmove', document.body, [touch]);
              
              window._lastTouchX = pos.x;
              window._lastTouchY = pos.y;
              await new Promise(r => setTimeout(r, stepTime));
          }
      }

      // 执行手指点击 (Touch Sequence)
      async function performHumanTap(element) {
        if (window._cf_manual_mode || window._hasClickedGlobal || !element) return;
        window._hasClickedGlobal = true;

        const rect = element.getBoundingClientRect();
        // 目标偏离中心点
        const targetX = rect.left + rect.width / 2 + (Math.random() - 0.5) * 10;
        const targetY = rect.top + rect.height / 2 + (Math.random() - 0.5) * 10;

        if (window.flutter_inappwebview) window.flutter_inappwebview.callHandler('TestPageChannel', "[Bypass] 👆 Finger moving to target...");

        // 1. 手指移动过去 (悬浮状态，虽然手机没有hover，但模拟手指接近屏幕的过程)
        await humanTouchMove(targetX, targetY, 500 + Math.random() * 300);

        // 2. 准备点击数据
        const touchId = Math.floor(Math.random() * 9999);
        const touchObj = createTouch(element, touchId, targetX, targetY);
        const touchList = [touchObj];

        // 3. 触发 TouchStart
        sendTouchEvent('touchstart', element, touchList);
        await new Promise(r => setTimeout(r, 50 + Math.random() * 50));

        // 4. 触发 TouchEnd
        sendTouchEvent('touchend', element, touchList);
        
        // 5. 触发兼容性 Mouse Events (手机浏览器通常会产生这些)
        // 顺序：touchstart -> touchend -> mousemove -> mousedown -> mouseup -> click
        const mouseOpts = { 
            bubbles: true, cancelable: true, view: window, isTrusted: true, 
            clientX: targetX, clientY: targetY, 
            screenX: targetX, screenY: targetY
        };
        
        element.dispatchEvent(new MouseEvent('mousemove', mouseOpts));
        element.dispatchEvent(new MouseEvent('mousedown', mouseOpts));
        element.focus();
        await new Promise(r => setTimeout(r, 10 + Math.random() * 20));
        element.dispatchEvent(new MouseEvent('mouseup', mouseOpts));
        element.dispatchEvent(new MouseEvent('click', mouseOpts));
        
        if (window.flutter_inappwebview) window.flutter_inappwebview.callHandler('TestPageChannel', "[Bypass] 👆 TAP executed!");
      }

      // --- 3. 扫描逻辑 ---
      async function scan() {
        const currentUrl = window.location.href;
        const marker = new URLSearchParams(currentUrl).get('successMarker');
        
        // 成功判定 (ListSpam 特征：标题变化或内容包含)
        if (marker && document.body.innerHTML.includes(marker)) {
             if (window.flutter_inappwebview && !window._cf_manual_mode) {
                window.flutter_inappwebview.callHandler('BypassSuccess', { success: true, cookies: document.cookie, url: currentUrl });
             }
             return;
        }

        if (window._cf_manual_mode || window._hasClickedGlobal) return;

        let target = null;
        
        // 1. Shadow DOM
        for (let i = 0; i < window._capturedShadowRoots.length; i++) {
          try {
            const cb = window._capturedShadowRoots[i].querySelector('input[type="checkbox"]');
            if (cb && !cb.checked) { target = cb; break; }
          } catch (e) {}
        }
        
        // 2. Iframe
        if (!target) {
            for (let i = 0; i < window._capturedIframes.length; i++) {
               try {
                  const cb = window._capturedIframes[i].contentDocument.querySelector('input[type="checkbox"]');
                  if (cb && !cb.checked) { target = cb; break; }
               } catch(e) {}
            }
        }

        if (target) {
            if (window.flutter_inappwebview) window.flutter_inappwebview.callHandler('TestPageChannel', "[Bypass] 👀 Target acquired. Waiting human reaction time...");
            
            const reactionTime = 800 + Math.random() * 800; // 反应慢一点，像玩手机
            window._hasClickedGlobal = true; 
            
            setTimeout(async () => {
                window._hasClickedGlobal = false;
                await performHumanTap(target);
            }, reactionTime);
        }
      }

      setInterval(scan, 1000);
    })();
  ''';
}
