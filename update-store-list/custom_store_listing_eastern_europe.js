/**
 * Custom Store Listing 自动化创建 - 东欧大区 (Poland, Czechia)
 * 用法：在 Google Play Console 控制台中粘贴并运行。
 */
(async () => {
  const CONFIG = {
    listingName: "Eastern Europe - Spam Blocker",
    countries: ["Poland", "Czechia"],
    keywords: `Blokowanie połączeń
Niechciane połączenia
Spam telefoniczny
Oszustwo telefoniczne
Czarna lista numerów
Kto dzwonił
Odebrać telefon
Blokování hovorů
Nevyžádané hovory
Podvodné volání
Kdo mi volal
Můžu to zvednout
Truecaller
Spam call blocker`,
    contents: {
      "pl-PL": {
        name: "Blokowanie połączeń & Antyspam",
        short: "Skutecznie blokuj telemarketing i oszustwa. 100% prywatności: brak konta.",
        full: "Masz dość nachalnych ofert fotowoltaiki, fałszywych konsultantów bankowych i uciążliwego telemarketingu?\n\nOto nowoczesny bloker połączeń stworzony z myślą o pełnej ochronie prywatności polskich użytkowników.\n\n🛡️ Pełna Prywatność i Bezpieczeństwo\n- Aplikacja nie wymaga rejestracji, logowania ani tworzenia konta.\n- Twoje kontakty i rejestr połączeń nigdy nie są przesyłane do chmury.\n\n🚫 Niezawodne Filtrowanie Połączeń\n- Automatycznie wyciszaj i odrzucaj natrętne numery call center oraz próby oszustw.\n- Blokuj całe serie numerów za pomocą elastycznych reguł prefiksów.\n- Niezwykle lekki silnik działający offline, oszczędzający baterię.\n\nZainstaluj teraz i ciesz się ciszą oraz bezpiecznym telefonem."
      },
      "cs-CZ": {
        name: "Blokování nechtěných hovorů",
        short: "Zastavte telemarketing a podvodné hovory. 100% soukromí bez registrace.",
        full: "Otravují vás neustálé nabídky investic, průzkumy trhu a podezřelé prozvánění?\n\nTento pokročilý blokátor hovorů funguje zcela lokálně na vašem zařízení a spolehlivě filtruje obtěžující hovory.\n\n🛡️ 100% Ochrana Soukromí\n- Žádné vytváření účtů, přihlašování ani sledování.\n- Vaše kontakty a historie hovorů zůstávají výhradně ve vašem telefonu.\n\n🚫 Konec Otravného Telemarketingu\n- Okamžité ticho před podvodníky, automaty i prodejci po telefonu.\n- Jednoduché nastavení vlastních pravidel a blokování celých číselných řad.\n- Minimální spotřeba baterie a blesková odezva offline.\n\nStáhněte si aplikaci a mějte svůj telefon opět plně pod kontrolą."
      }
    }
  };

  const wait = (ms) => new Promise(r => setTimeout(r, ms));
  const waitFor = (predicate, timeout = 12000, interval = 100) => {
    return new Promise((resolve, reject) => {
      const startTime = Date.now();
      const timer = setInterval(() => {
        const el = predicate();
        if (el) { clearInterval(timer); resolve(el); }
        else if (Date.now() - startTime > timeout) { clearInterval(timer); reject(new Error(`等待元素超时 (${timeout}ms)`)); }
      }, interval);
    });
  };

  const forceClick = (el) => {
    if (!el) return;
    el.scrollIntoView({ behavior: 'instant', block: 'center' });
    el.focus();
    ['pointerdown', 'mousedown', 'pointerup', 'mouseup', 'click'].forEach(t => {
      el.dispatchEvent(new MouseEvent(t, { bubbles: true, cancelable: true, view: window, composed: true }));
    });
    el.dispatchEvent(new KeyboardEvent('keydown', { key: 'Enter', keyCode: 13, bubbles: true }));
    el.dispatchEvent(new KeyboardEvent('keyup', { key: 'Enter', keyCode: 13, bubbles: true }));
  };

  const fillInput = (el, val) => {
    if (!el) return;
    el.focus();
    const proto = el instanceof HTMLInputElement ? window.HTMLInputElement.prototype : window.HTMLTextAreaElement.prototype;
    const setter = Object.getOwnPropertyDescriptor(proto, 'value')?.set;
    if (setter) setter.call(el, val); else el.value = val;
    ['input', 'change', 'blur'].forEach(t => el.dispatchEvent(new Event(t, { bubbles: true })));
  };

  try {
    console.log("🚀 [1/6] Setup 复刻...");
    const createBtn = Array.from(document.querySelectorAll('button, material-button')).find(b =>
      /Create custom store listing|Create custom listing|创建自定义商品详情/i.test(b.innerText) && b.offsetParent !== null
    );
    if (createBtn) { forceClick(createBtn); await wait(2000); }

    const radio = document.querySelector('[debug-id="duplicate-listing-radio"]');
    if (radio) {
      forceClick(radio); await wait(800);
      const drpBtn = document.querySelector('console-button-menu[debug-id="duplicate-listing-dropdown"] div[buttondecorator]');
      if (drpBtn && !drpBtn.textContent.includes('Default store listing')) {
        forceClick(drpBtn); await wait(1000);
        const defaultOpt = await waitFor(() => Array.from(document.querySelectorAll('material-select-item, [role="option"], .menu-popup *')).find(el =>
          el.textContent?.trim() === 'Default store listing' && el.offsetParent !== null
        ));
        forceClick(defaultOpt); await wait(1000);
      }
      const nextBtn1 = Array.from(document.querySelectorAll('button')).find(b => b.innerText.trim() === 'Next' && !b.disabled && b.offsetParent !== null);
      if (nextBtn1) { forceClick(nextBtn1); await wait(2500); }
    }

    console.log("🚀 [2/6] Details 覆写名称与 Search keyword...");
    const nameInput = await waitFor(() => document.querySelector('material-input[debug-id="name-input"] input') || document.querySelector('input[aria-label*="Name of the custom store listing"]') || document.querySelector('input.mdc-text-field__input'));
    fillInput(nameInput, CONFIG.listingName); await wait(600);

    const audField = await waitFor(() => document.querySelector('[debug-id="select-audience-field"] div[buttondecorator]') || Array.from(document.querySelectorAll('div[buttondecorator]')).find(el => el.textContent.includes('Select an audience')));
    if (!audField.textContent.includes('Search keyword')) {
      forceClick(audField); await wait(1000);
      const kwOption = await waitFor(() => Array.from(document.querySelectorAll('material-select-item, [role="menuitem"], [role="option"], .item')).find(el => {
        const t = el.innerText?.trim() || '';
        return t.startsWith('Search keyword') && !el.querySelector('i.material-icons-extended') && el.offsetParent !== null;
      }), 8000);
      kwOption.scrollIntoView({ block: 'center' }); kwOption.click(); await wait(1500);
    }

    console.log("🚀 [3/6] 关键词录入与国家搜索勾选...");
    const chooseBtn = Array.from(document.querySelectorAll('button, material-button')).find(b => b.innerText.includes('Choose keywords') && b.offsetParent !== null);
    if (chooseBtn) { forceClick(chooseBtn); await wait(2000); }

    const kwTextarea = document.querySelector('.popup textarea.mdc-text-field__input, textarea.mdc-text-field__input, textarea');
    if (kwTextarea && !kwTextarea.value) {
      fillInput(kwTextarea, CONFIG.keywords); await wait(600);
      const addKwBtn = Array.from(document.querySelectorAll('material-button, button')).find(b => b.textContent.includes('Add keywords') && b.offsetParent !== null);
      if (addKwBtn) { forceClick(addKwBtn); await wait(1200); }
    }

    const countryTrigger = Array.from(document.querySelectorAll('span, div, material-chip')).find(el => el.textContent?.trim() === 'Country / region' && el.offsetParent !== null);
    if (countryTrigger) { forceClick(countryTrigger); await wait(1500); }

    const dialog = Array.from(document.querySelectorAll('.popup, div[role="dialog"], mat-dialog-container, div')).find(el => el.innerText?.includes('countries / regions selected') && el.offsetParent !== null);
    if (dialog) {
      const searchInput = Array.from(dialog.querySelectorAll('input')).find(inp => inp.placeholder?.toLowerCase().includes('search') || inp.getAttribute('aria-label')?.toLowerCase().includes('search') || inp.offsetParent !== null);
      for (const country of CONFIG.countries) {
        fillInput(searchInput, country); await wait(1200);
        const rows = Array.from(dialog.querySelectorAll('material-picker-item'));
        let targetRow = rows.find(r => r.textContent?.trim()?.toLowerCase().includes(country.toLowerCase()) && !r.textContent?.toLowerCase().includes('select all')) || rows.find(r => !r.textContent?.toLowerCase()?.includes('select all'));
        if (targetRow) { const checkbox = targetRow.querySelector('material-checkbox') || targetRow; forceClick(checkbox); await wait(800); }
        fillInput(searchInput, ''); await wait(500);
      }
      const applyCountryBtn = Array.from(dialog.querySelectorAll('button, material-button')).find(b => b.innerText.trim() === 'Apply' && b.offsetParent !== null);
      if (applyCountryBtn) { forceClick(applyCountryBtn); await wait(1500); }
    }

    const createAudBtn = await waitFor(() => document.querySelector('button.yes-button') || Array.from(document.querySelectorAll('button')).find(b => b.innerText.includes('Create audience') && b.offsetParent !== null));
    forceClick(createAudBtn); await wait(3000);

    const nextBtn2 = await waitFor(() => Array.from(document.querySelectorAll('button')).find(b => b.innerText.trim() === 'Next' && !b.disabled && b.offsetParent !== null), 8000);
    forceClick(nextBtn2); await wait(3500);

    console.log("🚀 [4/6] 语言管理与 Apply...");
    const openLangMenu = () => {
      const langBtn = Array.from(document.querySelectorAll('button, div[role="button"], div[buttondecorator]')).find(b => b.offsetParent !== null && (b.innerText.includes('–') || b.querySelector('i.material-icons-extended')?.innerText?.includes('arrow_drop_down')));
      if (langBtn) forceClick(langBtn);
    };

    const isLangPopupOpen = Array.from(document.querySelectorAll('div, h2, span')).some(el => el.innerText?.trim() === 'Manage languages' && el.offsetParent !== null);
    if (!isLangPopupOpen) {
      openLangMenu(); await wait(1000);
      const manageLangBtn = await waitFor(() => Array.from(document.querySelectorAll('material-select-item, [role="menuitem"]')).find(el => el.textContent?.includes('Manage languages') && el.offsetParent !== null));
      forceClick(manageLangBtn); await wait(2000);
      const clearBtn = await waitFor(() => document.querySelector('material-button.clear-button') || Array.from(document.querySelectorAll('material-button, button')).find(b => b.innerText.trim() === 'Clear all' && b.offsetParent !== null));
      forceClick(clearBtn); await wait(1000);

      for (const code of Object.keys(CONFIG.contents)) {
        const langRow = Array.from(document.querySelectorAll('material-picker-item, material-select-dropdown-item, .item-group-list *')).find(row => {
          const text = row.textContent || ''; const aria = row.getAttribute('aria-label') || '';
          return (text.includes(`– ${code}`) || aria.includes(`– ${code}`)) && row.offsetParent !== null;
        });
        if (langRow) {
          const checkbox = langRow.querySelector('material-checkbox') || langRow;
          const isChecked = checkbox.getAttribute('aria-checked') === 'true' || checkbox.classList?.contains('material-checkbox-checked');
          if (!isChecked) { forceClick(checkbox); await wait(500); }
        }
      }
    }

    const applyLangBtn = await waitFor(() => Array.from(document.querySelectorAll('button.mdc-button, button, material-button')).find(b => {
      const label = b.querySelector('.mdc-button__label')?.innerText?.trim() || b.innerText?.trim();
      return label === 'Apply' && b.offsetParent !== null;
    }));
    forceClick(applyLangBtn); await wait(2500);

    console.log("🚀 [5/6] 逐一切换语言并注入文案...");
    for (const [langCode, content] of Object.entries(CONFIG.contents)) {
      openLangMenu(); await wait(1000);
      const allLangItems = Array.from(document.querySelectorAll('material-select-item[aria-label]'));
      const targetOption = allLangItems.find(el => {
        const label = el.getAttribute('aria-label') || '';
        return label.endsWith(langCode) || label.includes(`– ${langCode}`);
      });

      if (targetOption) {
        forceClick(targetOption); await wait(2000);
        if (content.name) {
          const titleInput = document.querySelector('input[maxLength="30"]');
          if (titleInput) fillInput(titleInput, content.name.slice(0, 30));
        }
        const shortInput = document.querySelector('input[aria-labelledby*="short-description"], input[maxLength="80"]') || Array.from(document.querySelectorAll('input[type="text"]')).find(el => el.maxLength === 80);
        if (shortInput) fillInput(shortInput, content.short.slice(0, 80));
        const fullTextarea = document.querySelector('textarea[aria-labelledby*="full-description"]') || document.querySelector('textarea');
        if (fullTextarea) fillInput(fullTextarea, content.full.slice(0, 4000));
        await wait(1000);
      } else { document.body.click(); await wait(500); }
    }

    console.log("🚀 [6/6] 点击 Next 并在下一页保存...");
    const nextBtn3 = await waitFor(() => Array.from(document.querySelectorAll('button')).find(b => b.innerText.trim() === 'Next' && !b.disabled && b.offsetParent !== null), 8000);
    forceClick(nextBtn3); await wait(3500);

    const moreBtn = await waitFor(() => document.querySelector('button[aria-label="More options"]') || document.querySelector('button[debug-id="icon-button"]') || Array.from(document.querySelectorAll('button')).find(b => b.querySelector('i')?.innerText === 'more_vert' && b.offsetParent !== null));
    forceClick(moreBtn); await wait(1000);

    const saveOption = await waitFor(() => Array.from(document.querySelectorAll('material-select-item[aria-label]')).find(el => el.getAttribute('aria-label')?.trim() === 'Save' && el.getAttribute('aria-disabled') !== 'true' && !el.classList.contains('disabled') && el.offsetParent !== null));
    forceClick(saveOption);
    console.log("🎉 东欧大区创建与保存成功！");
  } catch (err) { console.error("❌ 执行中断:", err.message); }
})();
