const fs = require('fs');
const path = require('path');

const jsonPath = path.join(__dirname, 'translations.json');
const listingsDir = path.join(__dirname, 'listings');

const LIMITS = {
  title: 30,
  shortDescription: 80,
  fullDescription: 4000,
};

function main() {
  const translations = JSON.parse(fs.readFileSync(jsonPath, 'utf8'));
  const errors = [];

  console.log('📋 开始检查并由 translations.json 生成 Fastlane 规范 listings/ 目录...');
  console.log('-'.repeat(65));

  for (const [lang, data] of Object.entries(translations)) {
    const title = (data.title || '').trim();
    const shortDesc = (data.shortDescription || '').trim();
    const fullDesc = (data.fullDescription || '').trim();

    if (title.length > LIMITS.title) {
      errors.push(`❌ [${lang}] title 超长: ${title.length}/${LIMITS.title}`);
    }
    if (shortDesc.length > LIMITS.shortDescription) {
      errors.push(`❌ [${lang}] shortDescription 超长: ${shortDesc.length}/${LIMITS.shortDescription}`);
    }
    if (fullDesc.length > LIMITS.fullDescription) {
      errors.push(`❌ [${lang}] fullDescription 超长: ${fullDesc.length}/${LIMITS.fullDescription}`);
    }

    const langFolder = path.join(listingsDir, lang);
    if (!fs.existsSync(langFolder)) {
      fs.mkdirSync(langFolder, { recursive: true });
    }

    fs.writeFileSync(path.join(langFolder, 'title.txt'), title + '\n', 'utf8');
    fs.writeFileSync(path.join(langFolder, 'short_description.txt'), shortDesc + '\n', 'utf8');
    fs.writeFileSync(path.join(langFolder, 'full_description.txt'), fullDesc + '\n', 'utf8');

    console.log(` [OK] ${lang.padEnd(6)} | 标题: ${title.length.toString().padStart(2)}/30 | 简短: ${shortDesc.length.toString().padStart(2)}/80 | 完整: ${fullDesc.length.toString().padStart(4)}/4000`);
  }

  console.log('-'.repeat(65));
  if (errors.length > 0) {
    console.error('⚠️ 警告：发现以下语言字数超限：');
    console.error(errors.join('\n'));
  } else {
    console.log('🎉 全部 listings 目录文件已成功导出且校验无误！');
  }
}

main();
