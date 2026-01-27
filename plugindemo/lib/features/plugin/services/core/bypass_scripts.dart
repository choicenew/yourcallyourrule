class BypassScripts {
  static String get bypassUniversal => '''
    (function() {
      // 0. 防止脚本重复运行
      if (window._cf_bypass_active) return;
      window._cf_bypass_active = true;

      console.log("[Bypass] 🛡️ Mobile Interaction Engine V3 Active");

      // 1. 初始化变量
      window._capturedShadowRoots = []; 
      window._capturedIframes = [];     
      // 保留外部注入的手动模式设置
      window._cf_manual_mode = window._cf_manual_mode || false;
      window._hasClickedGlobal = false; 

      // 2. 劫持 Shadow DOM (核心：开天眼)
      const originalAttachShadow = Element.prototype.attachShadow;
      Element.prototype.attachShadow = function(init) {
        const root = originalAttachShadow.call(this, init);
        window._capturedShadowRoots.push(root);
        return root;
      };

      // 3. 劫持 Iframe (兜底)
      const originalCreateElement = document.createElement;
      document.createElement = function(tagName) {
        const element = originalCreateElement.call(document, tagName);
        if (tagName.toLowerCase() === 'iframe') {
          window._capturedIframes.push(element);
        }
        return element;
      };

      // 4. 反指纹 (Webdriver)
      try { Object.defineProperty(navigator, 'webdriver', { get: () => false }); } catch (e) {}

      // --- 📱 核心：移动端拟人化引擎 V3 ---

      // 辅助：生成范围随机数
      function random(min, max) {
        return Math.random() * (max - min) + min;
      }

      // A. 模拟无意识的屏幕微调 (Human Scroll)
      // 真人在点击前，如果不舒服，会下意识滚动一点点
      async function humanScroll(targetElement) {
          if (window._cf_manual_mode) return;

          // 1. 检查元素位置
          const rect = targetElement.getBoundingClientRect();
          const centerY = window.innerHeight / 2;
          const distance = rect.top - centerY;

          // 2. 如果偏移较大，或者仅仅是为了活跃度，随机滚动一下
          // 向上或向下滚动 20px - 100px
          const scrollAmount = (distance > 0 ? 1 : -1) * random(20, 80) + random(-10, 10);
          
          if (window.flutter_inappwebview) {
             window.flutter_inappwebview.callHandler('TestPageChannel', "[Bypass] 📜 Human Scroll: " + Math.round(scrollAmount) + "px");
          }

          // 平滑滚动
          window.scrollBy({
              top: scrollAmount,
              behavior: 'smooth'
          });

          // 等待滚动惯性结束 (300ms - 600ms)
          await new Promise(r => setTimeout(r, random(300, 600)));
      }

      // B. 构造真实的 Touch 对象 (模拟手指接触面)
      function createTouch(target, identifier, x, y) {
          return new Touch({
              identifier: identifier,
              target: target,
              clientX: x,
              clientY: y,
              screenX: x, // 移动端通常全屏，简化处理
              screenY: y,
              pageX: x + window.scrollX,
              pageY: y + window.scrollY,
              // ⭐ 关键：手指不是针尖，有半径 (10px - 25px)
              radiusX: random(10, 25),
              radiusY: random(10, 25),
              rotationAngle: random(0, 360),
              force: random(0.3, 0.9) // 压力
          });
      }

      // C. 执行移动端点击 (Touch Sequence)
      async function performMobileTap(element) {
        // 检查锁
        if (window._cf_manual_mode || window._hasClickedGlobal || !element) return;
        window._hasClickedGlobal = true; // 上锁

        if (window.flutter_inappwebview) window.flutter_inappwebview.callHandler('TestPageChannel', "[Bypass] 👆 Finger approaching...");

        // 1. 先进行一次人性化滚动
        await humanScroll(element);

        // 2. 计算落点 (中心点 + 随机偏差)
        const rect = element.getBoundingClientRect();
        // 手指点击精度低，偏差可以大一点 (+- 15px)
        const touchX = rect.left + rect.width / 2 + random(-15, 15);
        const touchY = rect.top + rect.height / 2 + random(-15, 15);

        // 3. 准备数据
        const touchId = Math.floor(Math.random() * 9999);
        const touchObj = createTouch(element, touchId, touchX, touchY);
        const touchList = [touchObj];
        
        const commonOpts = { 
            bubbles: true, cancelable: true, view: window, isTrusted: true,
            touches: touchList, targetTouches: touchList, changedTouches: touchList
        };

        // --- 动作序列开始 ---

        // Step 1: Touch Start (手指接触屏幕)
        element.dispatchEvent(new TouchEvent('touchstart', commonOpts));
        
        // 按压持续时间 (Hold): 60ms - 180ms
        await new Promise(r => setTimeout(r, random(60, 180)));

        // Step 2: Touch Move (微颤 - 手指按在玻璃上会有微小位移)
        // 移动 1-3 像素
        touchObj.clientX += random(-2, 2);
        touchObj.clientY += random(-2, 2);
        element.dispatchEvent(new TouchEvent('touchmove', {
            ...commonOpts, 
            touches: [touchObj], targetTouches: [touchObj], changedTouches: [touchObj]
        }));

        await new Promise(r => setTimeout(r, random(10, 30)));

        // Step 3: Touch End (手指离开)
        element.dispatchEvent(new TouchEvent('touchend', {
            ...commonOpts, touches: [], targetTouches: [], changedTouches: [touchObj]
        }));

        if (window.flutter_inappwebview) window.flutter_inappwebview.callHandler('TestPageChannel', "[Bypass] 👆 Finger lifted.");

        // Step 4: 兼容性 Mouse Events (浏览器内核自动生成)
        // 顺序: mousemove -> mousedown -> mouseup -> click
        // 注意：不生成 path，直接在该点触发
        const mouseOpts = {
            bubbles: true, cancelable: true, view: window, isTrusted: true,
            clientX: touchX, clientY: touchY, screenX: touchX, screenY: touchY
        };

        // 极短延迟
        await new Promise(r => setTimeout(r, 10));
        
        element.dispatchEvent(new MouseEvent('mousemove', mouseOpts));
        element.dispatchEvent(new MouseEvent('mousedown', mouseOpts));
        element.focus();
        // Click 触发
        element.dispatchEvent(new MouseEvent('mouseup', mouseOpts));
        element.dispatchEvent(new MouseEvent('click', mouseOpts));

        if (window.flutter_inappwebview) window.flutter_inappwebview.callHandler('TestPageChannel', "[Bypass] 🎯 TAP Completed.");
      }

      // --- 扫描循环 ---
      async function scan() {
        const currentUrl = window.location.href;
        const marker = new URLSearchParams(currentUrl).get('successMarker');
        
        // 成功判定
        if (marker && document.body.innerHTML.includes(marker)) {
             if (window.flutter_inappwebview && !window._cf_manual_mode) {
                window.flutter_inappwebview.callHandler('BypassSuccess', { success: true, cookies: document.cookie, url: currentUrl });
             }
             return;
        }

        // 手动模式或已点击则跳过
        if (window._cf_manual_mode || window._hasClickedGlobal) return;

        let target = null;
        
        // 1. 扫描 Shadow DOM
        for (let i = 0; i < window._capturedShadowRoots.length; i++) {
          try {
            const root = window._capturedShadowRoots[i];
            const cb = root.querySelector('input[type="checkbox"]');
            if (cb && !cb.checked) { target = cb; break; }
          } catch (e) {}
        }
        
        // 2. 扫描 Iframe
        if (!target) {
            for (let i = 0; i < window._capturedIframes.length; i++) {
               try {
                  const iframe = window._capturedIframes[i];
                  if (iframe.contentDocument) {
                     const cb = iframe.contentDocument.querySelector('input[type="checkbox"]');
                     if (cb && !cb.checked) { target = cb; break; }
                  }
               } catch(e) {}
            }
        }

        // 3. 发现目标
        if (target) {
            if (window.flutter_inappwebview) window.flutter_inappwebview.callHandler('TestPageChannel', "[Bypass] 👀 Visual confirmed. Waiting reaction time...");
            
            // 人类视觉反应时间 (800ms - 1500ms)
            // 看到验证码后，人会愣一下，然后再操作
            const reactionTime = random(800, 1500);
            
            window._hasClickedGlobal = true; // 占位
            
            setTimeout(async () => {
                // window._hasClickedGlobal = false; // [FIX] Do NOT unlock. Try once only.
                await performMobileTap(target);
            }, reactionTime);
        }
      }

      setInterval(scan, 1000);
    })();
  ''';
}
