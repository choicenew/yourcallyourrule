const html = `
<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <title>0970569095 Query</title>
</head>
<body>
    <div class="container">
        <!-- Summary Section -->
        <div class="summary-keywords">
            <div class="summary">
                <span class="summary-result suspicious">可疑</span>
            </div>
            <div class="keywords">
                <span>Fraud</span>, <span>Scam</span>
            </div>
        </div>

        <!-- Comments Section -->
        <div class="comments">
            <div class="section-title">註釋 (5)</div>
            
            <article class="comment">
                <div class="content">
                    <p>0970569095 詐騙</p>
                </div>
            </article>

            <article class="comment">
                <div class="content">
                    <p>Be careful, this is a scam call.</p>
                </div>
            </article>
        </div>
    </div>
</body>
</html>
`;

function parseSlicklyHTML(html) {
    const result = {
        summaryLabel: '',
        keywordsText: '',
        count: 0,
        commentsText: ''
    };

    if (!html) return result;

    // 1. Extract Summary
    // Matches: <span class="summary-result ...">Text</span>
    const summaryRegex = /<span class=["']summary-result[^"']*["']>([^<]+)<\/span>/i;
    const summaryMatch = html.match(summaryRegex);
    if (summaryMatch) {
        result.summaryLabel = summaryMatch[1].trim();
    }

    // 2. Extract Keywords
    // Matches: <div class="keywords">...<span>Text</span>...</div>
    const keywordsRegex = /<div class=["']keywords["']>[\s\S]*?<span>([^<]+)<\/span>/i;
    const keywordsMatch = html.match(keywordsRegex);
    if (keywordsMatch) {
        result.keywordsText = keywordsMatch[1].trim();
    }

    // 3. Extract Count
    // Matches "註釋 (123)"
    const countRegex = /註釋\s*\((\d+)\)/i;
    const countMatch = html.match(countRegex);
    if (countMatch) {
        result.count = parseInt(countMatch[1], 10);
    }

    // 4. Extract Comments (Crucial for context)
    // Matches <div class="content"><p>...</p></div> patterns
    const commentContentRegex = /<div class=["']content["']>\s*<p>([\s\S]*?)<\/p>/gi;
    let commentMatch;
    let commentsList = [];
    while ((commentMatch = commentContentRegex.exec(html)) !== null) {
        if (commentMatch[1]) {
            commentsList.push(commentMatch[1].trim());
        }
    }
    result.commentsText = commentsList.join(' ');

    return result;
}

const result = parseSlicklyHTML(html);
console.log('Parsed Result:', JSON.stringify(result, null, 2));

// Test Assertions
let failures = [];
if (result.summaryLabel !== '可疑') failures.push('Summary mismatch');
if (result.count !== 5) failures.push('Count mismatch');
if (!result.commentsText.includes('詐騙')) failures.push('Comments text missing 詐騙');
if (!result.commentsText.includes('scam call')) failures.push('Comments text missing scam call');

if (failures.length > 0) {
    console.error('FAILURES:', failures);
    process.exit(1);
} else {
    console.log('SUCCESS: All assertions passed.');
}
