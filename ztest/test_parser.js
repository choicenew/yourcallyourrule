
const html = `
I/flutter ( 4475): <html lang="zh-TW"><head>
I/flutter ( 4475):     		<!-- Slickly Page Level -->
I/flutter ( 4475): <script async="" src="https://www.clarity.ms/tag/t23a6io192"></script><script src="https://pagead2.googlesyndication.com/pagead/managed/js/adsense/m202601200101/show_ads_impl_fy2021.js"></script><script async="" src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
I/flutter ( 4475): <script>
I/flutter ( 4475): (adsbygoogle = window.adsbygoogle || []).push({
I/flutter ( 4475):   google_ad_client: "ca-pub-1048159442139674",
I/flutter ( 4475):   enable_page_level_ads: false
I/flutter ( 4475): });
I/flutter ( 4475): </script>
I/flutter ( 4475):     <title>0970569095 / 0970-569-095 | Slickly - 台灣 (+886)</title>
I/flutter ( 4475): 		<meta http-equiv="content-type" content="text/html; charset=utf-8">
I/flutter ( 4475): <script>window.NREUM||(NREUM={});NREUM.info={"beacon":"bam.nr-data.net","errorBeacon":"bam.nr-data.net","licenseKey":"f20a22d7dc","applicationID":"520954883","transactionName":"c19dQBRdCVkEFBpBX19eVkdJQQ1aFg==","queueTime":4,"applicationTime":105,"agent":""}</script>
I/flutter ( 4475): <script>(window.NREUM||(NREUM={})).init={ajax:{deny_list:["bam.nr-data.net"]},feature_flags:["soft_nav"]};(window.NREUM||(NREUM={})).loader_config={licenseKey:"f20a22d7dc",applicationID:"520954883",browserID:"594570006"};;/*! For license information please see nr-loader-rum-1.308.0.min.js.LICENSE.txt */
I/flutter ( 4475): <h1 class="title-number ui dividing header">
I/flutter ( 4475):   <span class="title-national-number">
I/flutter ( 4475):     0970569095 / 0970-569-095
I/flutter ( 4475):   </span>
I/flutter ( 4475): </h1>
I/flutter ( 4475): 
I/flutter ( 4475): <div class="summary-keywords">
I/flutter ( 4475): 	<div class="summary">
I/flutter ( 4475): 		<label>摘要: </label>
I/flutter ( 4475): 		<span class="summary-result suspicious">可疑</span><span>(46個搜索·1條評論·0個負面·0個正面·2026-01-21個更新)</span>
I/flutter ( 4475): 	</div>
I/flutter ( 4475): </div>
I/flutter ( 4475): 	<div class="comments">
I/flutter ( 4475):     <div class="comments-count">
I/flutter ( 4475):       註釋 (1)
I/flutter ( 4475):     </div>
I/flutter ( 4475): 			<article class="comment">
I/flutter ( 4475): 				<div class="content">
I/flutter ( 4475):           <p>
I/flutter ( 4475): 	          	0970569095 詐騙
I/flutter ( 4475):           </p>
I/flutter ( 4475): 				</div>
I/flutter ( 4475): 			</article>
I/flutter ( 4475): 	</div>
`.replace(/I\/flutter \( \d+\): /g, '');

const manualMapping = {
    '危險': 'Risk', '安全': 'Other', '詐騙': 'Fraud Scam Likely', '騙局': 'Fraud Scam Likely',
    '垃圾郵件': 'Spam Likely', '騷扰': 'Spam Likely', '騷擾': 'Spam Likely', '電話行銷': 'Telemarketing',
    '自动拨号': 'Robocall', '送貨': 'Delivery', '外卖': 'Takeaway',
    '外賣': 'Takeaway', '保險': 'Insurance', '貸款': 'Loan', '金融': 'Financial',
    '銀行': 'Bank', '補習': 'Education', '滋擾': 'Spam Likely', '補習班': 'Education',
    '假扮': 'Fraud Scam Likely', '掛斷': 'Other', '無聲': 'Silent Call Voice Clone',
    '理財': 'Financial', '融資': 'Loan', '賣飞骗子': 'Fraud Scam Likely', '騙錢勿上當': 'Fraud Scam Likely',
    '上當': 'Fraud Scam Likely', '活性': 'Other', '待用': 'Other', '可疑': 'Spam Likely'
};

const blockKeywords = [
    '推銷', '廣告', '違规', '詐騙', '騙子', '滋擾', '騷擾', '危險', '风险', 'Risk', 'Scam', 
    '假扮', '賣飞', '上當', '騙钱', '贷款', '融資'
];

const allowKeywords = [
    '外賣', '送貨', '快遞', '叫車', '安全', 'Safe', '快件'
];

function parseHTML(html) {
    const result = {
        summaryLabel: '', keywordsText: '', count: 0, commentsText: '', negVotes: 0, posVotes: 0
    };

    if (!html) return result;

    const summaryRegex = /<span class=["']summary-result[^"']*["']>([^<]+)<\/span>/i;
    const summaryMatch = html.match(summaryRegex);
    if (summaryMatch) result.summaryLabel = summaryMatch[1].trim();

    const keywordsRegex = /<div class=["']keywords["']>[\s\S]*?<span>([^<]+)<\/span>/i;
    const keywordsMatch = html.match(keywordsRegex);
    if (keywordsMatch) result.keywordsText = keywordsMatch[1].trim();

    const countRegex = /註釋\s*\((\d+)\)/i;
    const countMatch = html.match(countRegex);
    if (countMatch) result.count = parseInt(countMatch[1], 10);

    const commentContentRegex = /<div class=["']content["']>\s*<p>([\s\S]*?)<\/p>/gi;
    let commentMatch;
    let commentsList = [];
    while ((commentMatch = commentContentRegex.exec(html)) !== null) {
        if (commentMatch[1]) commentsList.push(commentMatch[1].trim().replace(/\s+/g, ' '));
    }
    result.commentsText = commentsList.join(' ');

    return result;
}

const parsed = parseHTML(html);
console.log('--- Parsed Results ---');
console.log(JSON.stringify(parsed, null, 2));

let predefinedLabel = 'Unknown';
let action = 'none';
const sourceLabel = parsed.keywordsText || parsed.summaryLabel || '';
const mappingSourceString = `${parsed.keywordsText} ${parsed.summaryLabel} ${parsed.commentsText}`;

// Ported legacy matching logic
for (let key in manualMapping) {
    if (mappingSourceString.includes(key)) {
        predefinedLabel = manualMapping[key];
        break;
    }
}

const checkStr = (sourceLabel + " " + predefinedLabel + " " + mappingSourceString).toLowerCase();
if (blockKeywords.some(k => checkStr.includes(k.toLowerCase()))) {
    action = 'block';
} else if (allowKeywords.some(k => checkStr.includes(k.toLowerCase()))) {
    action = 'allow';
}

if (action === 'none') {
    if (['危險', '可疑'].includes(parsed.summaryLabel)) {
        action = 'block';
    } else if (parsed.summaryLabel === '安全') {
        action = 'allow';
    }
}

console.log('--- Final Logic ---');
console.log({ action, predefinedLabel, sourceLabel });
