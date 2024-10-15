// JS脚本，插件信息
const pluginInfo = {
  // 插件信息
  info: {
  id: 'your-plugin-id', // 插件ID，必须唯一
  name: 'Your Plugin Name', // 插件名称
  version: '1.0.0', // 插件版本
  description: 'This is a plugin template.', // 插件描述
  author: 'Your Name', // 插件作者
  },

  // 预设标签列表
  predefinedLabels: [
  {'label': 'Fraud Scam Likely'},
  {'label': 'Spam Likely'},
  {'label': 'Telemarketing'},
  // ... 省略其他预设标签
  {'label': 'Risk'},
  ],

  // 手动映射表，将 source label 映射到预设标签
  manualMapping: {
  '标签1': 'Fraud Scam Likely', // 对应预设标签 "Fraud Scam Likely"
  '标签2': 'Spam Likely', // 对应预设标签 "Spam Likely"
  // ... 省略其他手动映射
  '标签22': 'Risk', // 对应预设标签 "Risk"
  },

  // 手机号查询函数 - 360搜索
  async queryPhoneInfo(phoneNumber) {
    const jsonObject = { count: 0 };
    try {
      const response = await fetch(`https://www.so.com/s?q=${phoneNumber}`, {
        headers: {
          "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8",
          "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36"
        },
        mode: 'no-cors'  // 添加 no-cors 模式
      });
      if (response.ok) {
        const text = await response.text();
        const parser = new DOMParser();
        const doc = parser.parseFromString(text, 'text/html');
  
        // 更新后的 DOM 查询语句
        const countElement = doc.querySelector(".mohe-tips-zp b"); 
        const addressElement = doc.querySelector(".mh-detail span:nth-child(2)"); // 地址在第二个 span 中
        const sourceLabelElement = doc.querySelector(".mohe-tips-zp"); // 标签包含在 .mohe-tips-zp 中
        const sourceNameElement = doc.querySelector(".mohe-tips-zp .mohe-sjws"); // 来源包含在 .mohe-tips-zp 中
  
        if (countElement) {
          jsonObject.count = countElement.textContent;
          jsonObject.address = addressElement?.textContent?.trim(); // 去除空格
          jsonObject.sourceLabel = sourceLabelElement?.textContent?.trim(); // 去除空格
          jsonObject.sourceName = sourceNameElement?.textContent?.trim(); // 去除空格
          jsonObject.date = new Date().toISOString().split('T')[0];
        }
      }
    } catch (e) {
      console.error('Error querying phone info:', e);
    }
    return jsonObject;
  },

  // 生成输出对象
  async generateOutput(phoneNumber, nationalNumber, e164Number) {
  // 使用所有提供的号码格式进行查询，但跳过空值
  const queryResults = await Promise.all([
    //this.queryPhoneInfo(phoneNumber),
    phoneNumber ? this.queryPhoneInfo(phoneNumber) : Promise.resolve({}), // 过滤 phoneNumber 为空的情况
    nationalNumber ? this.queryPhoneInfo(nationalNumber) : Promise.resolve({}),
    e164Number ? this.queryPhoneInfo(e164Number) : Promise.resolve({})
  ]);

  const [phoneInfo, nationalInfo, e164Info] = queryResults;

  // 合并查询结果，优先使用非空值
  const info = {
    count: phoneInfo.count || nationalInfo.count || e164Info.count,
    sourceLabel: phoneInfo.sourceLabel || nationalInfo.sourceLabel || e164Info.sourceLabel,
    sourceName: phoneInfo.sourceName || nationalInfo.sourceName || e164Info.sourceName,
  };
    // 使用原有的逻辑匹配预定义标签
    let matchedLabel = null;
    for (const label of this.predefinedLabels) {
      if (label.label === info.sourceLabel) {
        matchedLabel = label.label;
        break;
      }
    }
    // 如果没有匹配到预定义标签，尝试使用手动映射
    if (!matchedLabel) {
      matchedLabel = this.manualMapping[info.sourceLabel] || null;
    }
    // 返回所需的数据对象
    return {
      phoneNumber: phoneNumber,
      sourceLabel: info.sourceLabel,
      count: info.count,
      predefinedLabel: matchedLabel,
      source: info.sourceName || this.info.name,
    };
  }
};




async function queryPhoneInfo(phoneNumber) { // 函数名改为 queryPhoneInfo
  const jsonObject = { count: 0 };

  try {
    const response = await fetch(`https://www.baidu.com/s?wd=${phoneNumber}`, {
      headers: {
        "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8",
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36"
      }
    });

    if (response.ok) {
      const text = await response.text();
      const parser = new DOMParser();
      const doc = parser.parseFromString(text, 'text/html');

      const sourceElement = doc.querySelector(".op_fraudphone_word a");
      jsonObject.sourceName = sourceElement ? sourceElement.textContent : null;

      const descElement = doc.querySelector(".op_fraudphone_word");
      const desc = descElement ? descElement.textContent : null;

      if (desc) {
        const countMatch = desc.match(/被(\d+)个/); 
        jsonObject.count = countMatch ? parseInt(countMatch[1], 10) : 0;
      }

      jsonObject.address = doc.querySelector(".op_fraudphone_addr")?.textContent || ""; //地址
      jsonObject.sourceLabel = doc.querySelector(".op_fraudphone_label")?.textContent || ""; //标签
      jsonObject.date = new Date().toISOString().split('T')[0];
    }
  } catch (e) {
    console.error('Error querying phone info from Baidu:', e);
  }

  return jsonObject;
}