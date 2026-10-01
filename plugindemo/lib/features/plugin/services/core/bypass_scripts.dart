class BypassScripts {
  static String get bypassUniversal => '''
    (function() {
      if (window._cf_bypass_active) return;
      window._cf_bypass_active = true;

      console.log("[Bypass] 🛡️ Mobile Interaction Engine V3 Active");

      window._capturedShadowRoots = []; 
      window._capturedIframes = [];     
      window._cf_manual_mode = window._cf_manual_mode || false;
      window._hasClickedGlobal = false; 

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

      try { Object.defineProperty(navigator, 'webdriver', { get: () => false }); } catch (e) {}

      function random(min, max) {
        return Math.random() * (max - min) + min;
      }

      async function humanScroll(targetElement) {
          if (window._cf_manual_mode) return;

          const rect = targetElement.getBoundingClientRect();
          const centerY = window.innerHeight / 2;
          const distance = rect.top - centerY;

          const scrollAmount = (distance > 0 ? 1 : -1) * random(20, 80) + random(-10, 10);
          
          if (window.flutter_inappwebview) {
             window.flutter_inappwebview.callHandler('TestPageChannel', "[Bypass] 📜 Human Scroll: " + Math.round(scrollAmount) + "px");
          }

          window.scrollBy({
              top: scrollAmount,
              behavior: 'smooth'
          });

          await new Promise(r => setTimeout(r, random(300, 600)));
      }

      function createTouch(target, identifier, x, y) {
          return new Touch({
              identifier: identifier,
              target: target,
              clientX: x,
              clientY: y,
              screenX: x,
              screenY: y,
              pageX: x + window.scrollX,
              pageY: y + window.scrollY,
              radiusX: random(10, 25),
              radiusY: random(10, 25),
              rotationAngle: random(0, 360),
              force: random(0.3, 0.9)
          });
      }

      async function performMobileTap(element) {
        if (window._cf_manual_mode || !element) return;
        
        let count = parseInt(sessionStorage.getItem('_cf_tap_count') || '0');
        sessionStorage.setItem('_cf_tap_count', count + 1);

        if (window.flutter_inappwebview) window.flutter_inappwebview.callHandler('TestPageChannel', "[Bypass] 👆 Finger approaching...");

        await humanScroll(element);

        const rect = element.getBoundingClientRect();
        const touchX = rect.left + rect.width / 2 + random(-15, 15);
        const touchY = rect.top + rect.height / 2 + random(-15, 15);

        const touchId = Math.floor(Math.random() * 9999);
        const touchObj = createTouch(element, touchId, touchX, touchY);
        const touchList = [touchObj];
        
        const commonOpts = { 
            bubbles: true, cancelable: true, view: window, isTrusted: true,
            touches: touchList, targetTouches: touchList, changedTouches: touchList
        };

        element.dispatchEvent(new TouchEvent('touchstart', commonOpts));
        await new Promise(r => setTimeout(r, random(60, 180)));

        touchObj.clientX += random(-2, 2);
        touchObj.clientY += random(-2, 2);
        element.dispatchEvent(new TouchEvent('touchmove', {
            ...commonOpts, 
            touches: [touchObj], targetTouches: [touchObj], changedTouches: [touchObj]
        }));

        await new Promise(r => setTimeout(r, random(10, 30)));

        element.dispatchEvent(new TouchEvent('touchend', {
            ...commonOpts, touches: [], targetTouches: [], changedTouches: [touchObj]
        }));

        if (window.flutter_inappwebview) window.flutter_inappwebview.callHandler('TestPageChannel', "[Bypass] 👆 Finger lifted.");

        const mouseOpts = {
            bubbles: true, cancelable: true, view: window, isTrusted: true,
            clientX: touchX, clientY: touchY, screenX: touchX, screenY: touchY
        };

        await new Promise(r => setTimeout(r, 10));
        
        element.dispatchEvent(new MouseEvent('mousemove', mouseOpts));
        element.dispatchEvent(new MouseEvent('mousedown', mouseOpts));
        element.focus();
        element.dispatchEvent(new MouseEvent('mouseup', mouseOpts));
        element.dispatchEvent(new MouseEvent('click', mouseOpts));

        if (window.flutter_inappwebview) window.flutter_inappwebview.callHandler('TestPageChannel', "[Bypass] 🎯 TAP Completed.");
      }

      async function scan() {
        if (window._cf_bypass_success_reported) return;

        const currentUrl = window.location.href;
        const marker = window._cf_success_marker || new URLSearchParams(currentUrl).get('successMarker');
        
        const title = document.title;
        const html = document.body.innerHTML;
        const isCloudflare = title.includes("Just a moment") || 
                             title.includes("Attention Required") || 
                             title.includes("Cloudflare") ||
                             html.includes("challenge-platform") ||
                             html.includes("cf-turnstile") ||
                             html.includes("verifying-text");
        
        if (!isCloudflare && marker && html.includes(marker)) {
             window._cf_bypass_success_reported = true;
             if (window.flutter_inappwebview && !window._cf_manual_mode) {
                window.flutter_inappwebview.callHandler('BypassSuccess', { 
                  success: true, 
                  cookies: document.cookie, 
                  content: document.documentElement.outerHTML, 
                  url: currentUrl 
                });
             }
             return;
        }

        if (window._cf_manual_mode || window._hasClickedGlobal) return;

        let count = parseInt(sessionStorage.getItem('_cf_tap_count') || '0');
        if (count > 0) {
             console.log("[Bypass] Loop Detected. Already tapped " + count + " times.");
             if (window.flutter_inappwebview) {
                 window.flutter_inappwebview.callHandler('BypassFailed', 'Loop Detected (Tap Count: ' + count + ')');
             }
             window._cf_bypass_success_reported = true;
             return;
        }

        let target = null;
        
        for (let i = 0; i < window._capturedShadowRoots.length; i++) {
          try {
            const root = window._capturedShadowRoots[i];
            const cb = root.querySelector('input[type="checkbox"]');
            if (cb && !cb.checked) { target = cb; break; }
          } catch (e) {}
        }
        
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

        if (target) {
            if (window.flutter_inappwebview) {
                window.flutter_inappwebview.callHandler('TestPageChannel', "[Bypass] 🛑 Interactive Challenge Detected. Signaling Dart for Manual Popup...");
                window.flutter_inappwebview.callHandler('ManualChallengeRequired', window.location.href);
            }
            window._cf_bypass_success_reported = true;
            return;
        }
      }

      setInterval(scan, 1000);
    })();
  ''';
}
