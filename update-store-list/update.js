const { google } = require('googleapis');
const fs = require('fs');
const path = require('path');

// ⚠️ 请确认或替换为你的真实包名
const packageName = 'com.yours.yourcallyourrule';

const listingsDir = path.join(__dirname, 'listings');

const LIMITS = {
  title: 30,
  short_description: 80,
  full_description: 4000
};

// 命令行参数支持: node update.js --validate / --dry-run
const args = process.argv.slice(2);
const isDryRun = args.includes('--validate') || args.includes('--dry-run');

/**
 * 读取并校验 listings/ 目录下的所有语言文件
 */
function loadAndValidateListings() {
  if (!fs.existsSync(listingsDir)) {
    throw new Error(`未找到 listings 目录: ${listingsDir}。请确保已创建 listings 语言文件夹。`);
  }

  const entries = fs.readdirSync(listingsDir, { withFileTypes: true });
  const languages = entries.filter(e => e.isDirectory()).map(e => e.name);

  if (languages.length === 0) {
    throw new Error('listings 目录下没有找到任何语言子文件夹！');
  }

  const listingsData = {};
  const errors = [];

  console.log('🔍 [1/3] 本地校验 Listings 文本与字数限制...');
  console.log('-'.repeat(70));

  for (const lang of languages) {
    const langFolder = path.join(listingsDir, lang);
    const titlePath = path.join(langFolder, 'title.txt');
    const shortPath = path.join(langFolder, 'short_description.txt');
    const fullPath = path.join(langFolder, 'full_description.txt');

    if (!fs.existsSync(titlePath)) errors.push(`❌ [${lang}] 缺少 title.txt`);
    if (!fs.existsSync(shortPath)) errors.push(`❌ [${lang}] 缺少 short_description.txt`);
    if (!fs.existsSync(fullPath)) errors.push(`❌ [${lang}] 缺少 full_description.txt`);

    if (errors.length > 0) continue;

    const title = fs.readFileSync(titlePath, 'utf8').trim();
    const shortDesc = fs.readFileSync(shortPath, 'utf8').trim();
    const fullDesc = fs.readFileSync(fullPath, 'utf8').trim();

    if (title.length > LIMITS.title) {
      errors.push(`❌ [${lang}] title 超长: ${title.length}/${LIMITS.title} 字 (超出 ${title.length - LIMITS.title} 字)`);
    }
    if (shortDesc.length > LIMITS.short_description) {
      errors.push(`❌ [${lang}] short_description 超长: ${shortDesc.length}/${LIMITS.short_description} 字 (超出 ${shortDesc.length - LIMITS.short_description} 字)`);
    }
    if (fullDesc.length > LIMITS.full_description) {
      errors.push(`❌ [${lang}] full_description 超长: ${fullDesc.length}/${LIMITS.full_description} 字 (超出 ${fullDesc.length - LIMITS.full_description} 字)`);
    }

    listingsData[lang] = {
      title,
      shortDescription: shortDesc,
      fullDescription: fullDesc
    };

    console.log(`  ✅ [OK] ${lang.padEnd(6)} | 标题: ${title.length.toString().padStart(2)}/30 | 简短: ${shortDesc.length.toString().padStart(2)}/80 | 完整: ${fullDesc.length.toString().padStart(4)}/4000`);
  }

  console.log('-'.repeat(70));

  if (errors.length > 0) {
    console.error('💥 校验未通过，发现以下问题：');
    console.error(errors.join('\n'));
    throw new Error('本地 Listings 字数或文件校验失败，终止 API 提交。');
  }

  console.log(`✨ 本地校验成功！共通过 ${Object.keys(listingsData).length} 种语言。`);
  return listingsData;
}

async function main() {
  try {
    // 1. 读取并校验本地 listings/ 文本
    const listings = loadAndValidateListings();

    if (isDryRun) {
      console.log('💡 启用了 --validate (Dry-run) 模式：已完成预检，不进行实际 API 提交。');
      return;
    }

    // 2. 认证 Google Play API
    const keyFilePath = path.join(__dirname, '../play_config.json');
    if (!fs.existsSync(keyFilePath)) {
      throw new Error(`未找到凭证文件: ${keyFilePath}。请确保 Play Store 凭证配置正确。`);
    }

    const auth = new google.auth.GoogleAuth({
      keyFile: keyFilePath,
      scopes: ['https://www.googleapis.com/auth/androidpublisher']
    });
    const publisher = google.androidpublisher({ version: 'v3', auth });

    console.log('\n🚀 [2/3] 开启 Google Play API 事务...');
    const editRes = await publisher.edits.insert({ packageName });
    const editId = editRes.data.id;
    console.log(`  已建立 Edit ID: ${editId}`);

    console.log('\n📝 [3/3] 循环更新多语言 Store Listing (不影响在线图片/截图)...');
    for (const [lang, data] of Object.entries(listings)) {
      await publisher.edits.listings.update({
        packageName,
        editId,
        language: lang,
        requestBody: {
          title: data.title,
          shortDescription: data.shortDescription,
          fullDescription: data.fullDescription
        }
      });
      console.log(`  ✅ 成功同步语言: ${lang}`);
    }

    console.log('\n💾 提交事务生效到 Google Play Console...');
    await publisher.edits.commit({ packageName, editId });
    console.log('🎉 所有 Store List 更新成功！');

  } catch (error) {
    console.error('\n❌ 更新失败:', error.message);
    process.exit(1);
  }
}

main();
