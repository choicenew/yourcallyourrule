const { google } = require('googleapis');
const fs = require('fs');
const path = require('path');

// ⚠️ 请替换为你的真实包名
const packageName = 'com.yours.yourcallyourrule';

async function main() {
  try {
    // 读取同目录下的 json 文件
    const jsonPath = path.join(__dirname, 'translations.json');
    const translations = JSON.parse(fs.readFileSync(jsonPath, 'utf8'));

    const auth = new google.auth.GoogleAuth({
      // 凭证文件由 GitHub Actions 生成在上一级根目录
      keyFile: path.join(__dirname, '../play_config.json'),
      scopes: ['https://www.googleapis.com/auth/androidpublisher']
    });
    const publisher = google.androidpublisher({ version: 'v3', auth });

    console.log('1. 开启 Google Play API 事务...');
    const editRes = await publisher.edits.insert({ packageName });
    const editId = editRes.data.id;

    console.log('2. 循环更新多国语言 Store Listing...');
    for (const [lang, data] of Object.entries(translations)) {
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
      console.log(`✅ 已更新语言: ${lang}`);
    }

    console.log('3. 提交修改并生效...');
    await publisher.edits.commit({ packageName, editId });
    console.log('🎉 所有 Store List 更新成功！');

  } catch (error) {
    console.error('❌ 更新失败:', error.message);
    process.exit(1);
  }
}

main();