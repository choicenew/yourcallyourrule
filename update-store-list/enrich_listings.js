const fs = require('fs');
const path = require('path');

const updateStoreListDir = __dirname;
const listingsDir = path.join(updateStoreListDir, 'listings');

const LIMITS = {
  title: 30,
  shortDescription: 80,
  fullDescription: 4000
};

/**
 * 遍历 update-store-list/ 目录下的 custom_store_listing_*.js 脚本，
 * 提取其中的 contents 字典并更新/丰富 listings/ 目录。
 */
function extractContentsFromScripts() {
  const files = fs.readdirSync(updateStoreListDir);
  const customScripts = files.filter(f => f.startsWith('custom_store_listing_') && f.endsWith('.js'));

  console.log(`🔍 找到 ${customScripts.length} 个区域自动化脚本，准备提取精化文案...`);
  console.log('-'.repeat(70));

  const extracted = {};

  for (const scriptFile of customScripts) {
    const filePath = path.join(updateStoreListDir, scriptFile);
    const content = fs.readFileSync(filePath, 'utf8');

    // 使用正则匹配 contents: { ... } 对象文本
    const match = content.match(/contents:\s*(\{[\s\S]*?\n\s*\}\s*\n\s*\}\);)/) ||
                  content.match(/contents:\s*(\{[\s\S]*?\n\s*\}\n\s*\};)/) ||
                  content.match(/contents:\s*(\{[\s\S]*?\n\s*\}\n\s*\}\);)/);

    if (!match) {
      // 备用匹配: 提取 contents 对象代码段
      const contentsStart = content.indexOf('contents:');
      if (contentsStart === -1) continue;

      try {
        const sub = content.substring(contentsStart);
        const objStr = sub.substring('contents:'.length, sub.indexOf('};\n\n  const wait') > -1 ? sub.indexOf('};\n\n  const wait') : sub.indexOf('};\n\n  try')).trim();
        const contentsObj = eval('(' + objStr + ')');
        for (const [lang, item] of Object.entries(contentsObj)) {
          extracted[lang] = item;
        }
      } catch (e) {
        console.warn(`⚠️ 无法解析 ${scriptFile} 中的 contents: ${e.message}`);
      }
      continue;
    }

    try {
      const objStr = match[1].replace(/;\s*$/, '');
      const contentsObj = eval('(' + objStr + ')');
      for (const [lang, item] of Object.entries(contentsObj)) {
        extracted[lang] = item;
      }
    } catch (e) {
      console.warn(`⚠️ 解析 ${scriptFile} 失败: ${e.message}`);
    }
  }

  return extracted;
}

function main() {
  const extractedContents = extractContentsFromScripts();
  const langs = Object.keys(extractedContents);

  console.log(`✨ 成功提取到 ${langs.length} 个不同语言/地区的高质量本地化文案：`);
  console.log(langs.join(', '));
  console.log('-'.repeat(70));

  const errors = [];
  let updatedCount = 0;

  for (const [lang, data] of Object.entries(extractedContents)) {
    const title = (data.name || data.title || '').trim();
    const shortDesc = (data.short || data.shortDescription || '').trim();
    const fullDesc = (data.full || data.fullDescription || '').trim();

    if (title.length > LIMITS.title) {
      errors.push(`❌ [${lang}] title 超长: ${title.length}/${LIMITS.title}`);
    }
    if (shortDesc.length > LIMITS.shortDescription) {
      errors.push(`❌ [${lang}] short 超长: ${shortDesc.length}/${LIMITS.shortDescription}`);
    }
    if (fullDesc.length > LIMITS.fullDescription) {
      errors.push(`❌ [${lang}] full 超长: ${fullDesc.length}/${LIMITS.fullDescription}`);
    }

    const langFolder = path.join(listingsDir, lang);
    if (!fs.existsSync(langFolder)) {
      fs.mkdirSync(langFolder, { recursive: true });
    }

    fs.writeFileSync(path.join(langFolder, 'title.txt'), title + '\n', 'utf8');
    fs.writeFileSync(path.join(langFolder, 'short_description.txt'), shortDesc + '\n', 'utf8');
    fs.writeFileSync(path.join(langFolder, 'full_description.txt'), fullDesc + '\n', 'utf8');

    updatedCount++;
    console.log(`  [OK] 丰富语言: ${lang.padEnd(6)} | 标题: ${title.length.toString().padStart(2)}/30 | 简短: ${shortDesc.length.toString().padStart(2)}/80 | 完整: ${fullDesc.length.toString().padStart(4)}/4000`);
  }

  console.log('-'.repeat(70));
  if (errors.length > 0) {
    console.error('⚠️ 警告：存在字数超限字段：');
    console.error(errors.join('\n'));
  } else {
    console.log(`🎉 成功将 ${updatedCount} 种语言的高质量本地化文案同步写入到 listings/ 目录！`);
  }
}

main();
