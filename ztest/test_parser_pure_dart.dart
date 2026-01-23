import 'dart:io';

void main() async {
  final logFilePath =
      r'c:\Users\Ngokel\Desktop\en\test\github\yourcallyourrulemixhistory\错误日志2';
  final logFile = File(logFilePath);
  if (!await logFile.exists()) {
    print('Error: 错误日志2 not found at $logFilePath');
    return;
  }

  final lines = await logFile.readAsLines();
  bool isCapturing = false;
  StringBuffer htmlBuffer = StringBuffer();

  for (var line in lines) {
    if (line.contains('[NATIVE HTML DUMP START]')) {
      isCapturing = true;
      continue;
    }
    if (line.contains('[NATIVE HTML DUMP END]')) {
      isCapturing = false;
      break;
    }
    if (isCapturing) {
      final cleanedLine = line.replaceFirst(
        RegExp(r'I/flutter \( \d+\): '),
        '',
      );
      htmlBuffer.writeln(cleanedLine);
    }
  }

  final html = htmlBuffer.toString();
  if (html.isEmpty) {
    print('Error: No HTML content found between markers.');
    return;
  }
  print('--- HTML Extracted (${html.length} chars) ---');

  // Regex definitions using triple quotes for safety
  final reSummary = RegExp(
    r"""<span class=["']summary-result[^"']*["']>([^<]+)</span>""",
    caseSensitive: false,
  );
  final reFallbackSummary = RegExp(
    r"""摘要:\s*\s*<span[^>]*>([^<]+)</span>""",
    caseSensitive: false,
  );
  final reKeywords = RegExp(
    r"""<div class=["']keywords["']>[\s\S]*?<span>([^<]+)</span>""",
    caseSensitive: false,
    multiLine: true,
  );
  final reCount = RegExp(r"""註釋\s*\((\d+)\)""", caseSensitive: false);
  final reNeg = RegExp(
    r"""<span class=["']negative-count["']>\s*(\d+)\s*</span>""",
    caseSensitive: false,
  );
  final rePos = RegExp(
    r"""<span class=["']positive-count["']>\s*(\d+)\s*</span>""",
    caseSensitive: false,
  );
  final reCommentContent = RegExp(
    r"""<div class=["']content["']>\s*<p>([\s\S]*?)</p>""",
    caseSensitive: false,
    multiLine: true,
  );

  print('\n--- Extraction Results ---');

  String resSummaryLabel = '';
  final matchSum = reSummary.firstMatch(html);
  if (matchSum != null) {
    resSummaryLabel = matchSum.group(1)!.trim();
  } else {
    final matchFSum = reFallbackSummary.firstMatch(html);
    if (matchFSum != null) resSummaryLabel = matchFSum.group(1)!.trim();
  }
  print('Summary Label: "$resSummaryLabel"');

  String resKeywordsText = '';
  final matchKey = reKeywords.firstMatch(html);
  if (matchKey != null) {
    resKeywordsText = matchKey.group(1)!.trim();
  }
  print('Keywords: "$resKeywordsText"');

  int resCommentCount = 0;
  final matchCount = reCount.firstMatch(html);
  if (matchCount != null) {
    resCommentCount = int.parse(matchCount.group(1)!);
  }
  print('Comment Count: $resCommentCount');

  int resNegVotes = 0;
  final matchNeg = reNeg.firstMatch(html);
  if (matchNeg != null) resNegVotes = int.parse(matchNeg.group(1)!);

  int resPosVotes = 0;
  final matchPos = rePos.firstMatch(html);
  if (matchPos != null) resPosVotes = int.parse(matchPos.group(1)!);

  print('Votes: -$resNegVotes, +$resPosVotes');

  List<String> resCommentsList = [];
  final matchesComment = reCommentContent.allMatches(html);
  for (var m in matchesComment) {
    resCommentsList.add(
      m.group(1)!.trim().replaceAll('\n', ' ').replaceAll('\r', ''),
    );
  }
  print('Comments Content: ${resCommentsList.join(" | ")}');

  // Decision Logic
  const manualMapping = {
    '危險': 'Risk',
    '安全': 'Other',
    '詐騙': 'Fraud Scam Likely',
    '騙局': 'Fraud Scam Likely',
    '垃圾郵件': 'Spam Likely',
    '騷扰': 'Spam Likely',
    '騷擾': 'Spam Likely',
    '電話行銷': 'Telemarketing',
    '自动拨号': 'Robocall',
    '送貨': 'Delivery',
    '外卖': 'Takeaway',
    '外賣': 'Takeaway',
    '保險': 'Insurance',
    '貸款': 'Loan',
    '金融': 'Financial',
    '銀行': 'Bank',
    '補習': 'Education',
    '滋擾': 'Spam Likely',
    '補習班': 'Education',
    '假扮': 'Fraud Scam Likely',
    '掛斷': 'Other',
    '無聲': 'Silent Call Voice Clone',
    '理財': 'Financial',
    '融資': 'Loan',
    '賣飞骗子': 'Fraud Scam Likely',
    '騙錢勿上當': 'Fraud Scam Likely',
    '上當': 'Fraud Scam Likely',
    '活性': 'Other',
    '待用': 'Other',
    '可疑': 'Spam Likely',
  };

  const blockKeywords = [
    '推銷',
    '廣告',
    '違规',
    '詐騙',
    '騙子',
    '滋擾',
    '騷擾',
    '危險',
    '风险',
    'Risk',
    'Scam',
    '假扮',
    '賣飞',
    '上當',
    '騙钱',
    '贷款',
    '融資',
  ];

  String sourceLabel = resKeywordsText.isNotEmpty
      ? resKeywordsText
      : resSummaryLabel;
  String predefinedLabel = 'Unknown';
  String action = 'none';

  final mappingSource =
      "$resKeywordsText $resSummaryLabel ${resCommentsList.join(' ')}";
  for (var key in manualMapping.keys) {
    if (mappingSource.contains(key)) {
      predefinedLabel = manualMapping[key]!;
      break;
    }
  }

  final checkStr = "$sourceLabel $predefinedLabel $mappingSource".toLowerCase();
  if (blockKeywords.any((k) => checkStr.contains(k.toLowerCase()))) {
    action = 'block';
  }

  if (action == 'none') {
    if (['危險', '可疑'].contains(resSummaryLabel)) {
      action = 'block';
    } else if (resSummaryLabel == '安全') {
      action = 'allow';
    }
  }

  print('\n--- Final Decision (Mocking JS) ---');
  print('Action: $action');
  print('Predefined Label: $predefinedLabel');
  print('Source Label: $sourceLabel');
  print('Success Marker Detected: ${html.contains("summary-result")}');
}
