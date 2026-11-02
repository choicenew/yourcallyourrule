# CallShield 外部订阅目录全量数据源与官方链接 (CallShield External List Catalog)

本文档整理自 `CallShield` 源码中 `ref/CallShield/data/list_catalog.json` 的官方外部订阅目录，包含截图中展示的 4 个国家社区订阅源及其精确主页与下载 URL。

---

## 一、 CallShield 外部订阅目录清单 (`list_catalog.json`)

| 列表名称与国家 (Country) | 授权协议 (License) | 官方仓库/主页 (Homepage) | 物理下载/API 链接 (URL) | 数据格式 (Format) |
| :--- | :--- | :--- | :--- | :--- |
| **1. OpenCallShield** (Colombia, CO) | MIT | `https://github.com/jhonsu01/OpenCallShield` | `https://raw.githubusercontent.com/jhonsu01/OpenCallShield/main/spam_numbers.json` | JSON |
| **2. SpamChile** (Chile, CL) | GPL-2.0 | `https://github.com/racuna/SpamChile` | `https://raw.githubusercontent.com/racuna/SpamChile/main/ChileSpam.csv` | CSV |
| **3. Turkish Spam Numbers** (Türkiye, TR) | GPL-3.0 | `https://github.com/symbuzzer/Turkish-Spam-Numbers` | `https://raw.githubusercontent.com/symbuzzer/Turkish-Spam-Numbers/main/numbers` | TXT |
| **4. Lista Hũ** (Paraguay, PY) | CC BY-NC-SA 4.0 | `https://listahu.org` | `https://listahu.org/api/v1/lista/?added_from=2025-01-01` | JSON API |

---

## 二、 完整开源数据源下载链接清单 (全量汇总)

| 数据源名称 | 授权协议 | 官方物理下载 / API 链接 |
| :--- | :--- | :--- |
| **1. OpenCallShield (哥伦比亚)** | MIT | `https://raw.githubusercontent.com/jhonsu01/OpenCallShield/main/spam_numbers.json` |
| **2. SpamChile (智利)** | GPL-2.0 | `https://raw.githubusercontent.com/racuna/SpamChile/main/ChileSpam.csv` |
| **3. Turkish Spam Numbers (土耳其)** | GPL-3.0 | `https://raw.githubusercontent.com/symbuzzer/Turkish-Spam-Numbers/main/numbers` |
| **4. Lista Hũ (巴拉圭)** | CC BY-NC-SA 4.0 | `https://listahu.org/api/v1/lista/?added_from=2025-01-01` |
| **5. CallShield 分桶数据包 (`00.json`~`ff.json`)** | MIT | `https://raw.githubusercontent.com/SysAdminDoc/CallShield/main/data/spam_number_shards/00.json` ~ `ff.json` |
| **6. CallShield 审核通过单表** | MIT | `https://raw.githubusercontent.com/SysAdminDoc/CallShield/main/data/spam_numbers_approved.json` |
| **7. US FTC Do Not Call 数据库 API** | US Gov | API: `https://api.ftc.gov/v0/dnc-complaints` |
| **8. US FCC Unwanted Calls 开放数据集** | US Gov | Socrata API: `https://opendata.fcc.gov/resource/392k-2534.json` |
| **9. OpenPhish 实时钓鱼域名 Feed** | Open Feed | `https://raw.githubusercontent.com/openphish/public_feed/refs/heads/main/feed.txt` |
| **10. PhishTank 官方 API 数据源** | PhishTank | API: `https://checkurl.phishtank.com/checkurl/` |
| **11. Saracroche 法国 ARCEP 营销号段库** | CC BY-NC-SA | API: `https://saracroche.org/api/v1/lists/french-list-arcep-operators` |
| **12. SkipCalls 实时查号 API** | SkipCalls | API: `https://spam.skipcalls.app/check/{digits}` |
| **13. PhoneBlock 欧洲社区 Bulk 库** | PhoneBlock | Bulk API: `https://phoneblock.net/phoneblock/api/blocklist` |
| **14. 20 维 GBT 机器学习模型权重包** | MIT | `https://raw.githubusercontent.com/SysAdminDoc/CallShield/main/data/spam_model_weights.json` |
| **15. 北美 NANP 区号与风险得分表** | Public CSV | `https://raw.githubusercontent.com/SysAdminDoc/CallShield/main/data/nanp-area-codes.csv` |
| **16. 北美城市归属地映射表** | Public CSV | `https://raw.githubusercontent.com/SysAdminDoc/CallShield/main/data/area-code-city-labels.csv` |
