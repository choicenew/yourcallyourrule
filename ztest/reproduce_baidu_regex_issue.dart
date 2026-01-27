import 'dart:io';

void main() async {
  final logFilePath =
      r'c:\Users\Ngokel\Desktop\en\test\github\yourcallyourrulemixhistory\错误日志';
  final logFile = File(logFilePath);
  if (!await logFile.exists()) {
    print('Error: Log file not found at $logFilePath');
    return;
  }

  // 1. Extract HTML using markers like in the original parser test
  final lines = await logFile.readAsLines();
  bool isCapturing = false;
  StringBuffer htmlBuffer = StringBuffer();

  // Find the LAST occurrence of the dump to get the relevant failure
  // (We could parse them all, but typically the last one is what the user is looking at in the logs)
  int startIndex = -1;
  int endIndex = -1;

  for (int i = 0; i < lines.length; i++) {
    if (lines[i].contains('[NATIVE HTML DUMP START]')) {
      startIndex = i;
      // Reset if we find a new start, effectively getting the last one
      htmlBuffer.clear();
    }
  }

  if (startIndex != -1) {
    for (int i = startIndex; i < lines.length; i++) {
      if (lines[i].contains('[NATIVE HTML DUMP END]')) {
        break;
      }
      final cleanedLine = lines[i].replaceFirst(
        RegExp(r'I/flutter \(\s*\d+\s*\): '),
        '',
      );
      htmlBuffer.writeln(cleanedLine);
    }
  } else {
    // Fallback: If no markers, maybe the file IS html? Or specific range requested?
    // Just attempting raw read if extract fails is dangerous on a log file.
    print('Error: No [NATIVE HTML DUMP START] marker found in the log.');
    return;
  }

  final html = htmlBuffer.toString();
  print('--- Extracted HTML (${html.length} chars) ---');
  // print(html); // Uncomment to see raw HTML

  // --- REPRODUCING THE REGEX LOGIC FROM `bd action copy.js` ---
  print('\n--- Testing Regex Logic ---');

  // 1. data-tools Extraction (JSON) - Fix HTML Entity Logic
  final dataToolsRegex = RegExp(
    r"data-tools=['\u0022]({.*?})['\u0022]",
    caseSensitive: false,
  );
  final dataToolsMatch = dataToolsRegex.firstMatch(html);

  String dataToolsName = "";
  if (dataToolsMatch != null) {
    String jsonStr = dataToolsMatch.group(1)!;
    print('[MATCH] data-tools found: $jsonStr');

    // Simulate the FIX: Replace HTML entities ('&quot;' and '&#39;')
    jsonStr = jsonStr.replaceAll('&quot;', '"').replaceAll('&#39;', '"');
    print('[DEBUG] Cleaned JSON (Fixed): $jsonStr');

    final titleRegex = RegExp(r'"title"\s*:\s*"([^"]+)"'); // Simple extraction
    final titleMatch = titleRegex.firstMatch(jsonStr);
    if (titleMatch != null) {
      dataToolsName = titleMatch.group(1)!;
      // JS: .split(',')[0].trim();
      dataToolsName = dataToolsName.split(',')[0].trim();
      print('[RESULT] Extracted dataToolsName: $dataToolsName');
    } else {
      print('[WARN] Could not regex-extract "title" from JSON string.');
    }
  } else {
    print('[FAIL] data-tools Regex did NOT match.');
  }

  // 1b. s-data Extraction (Comment JSON)
  // Pattern: <!--s-data:{...}-->
  print('[TEST] Testing s-data regex...');
  final sDataRegex = RegExp(r"<!--s-data:([\s\S]*?)-->", caseSensitive: false);
  final sDataMatches = sDataRegex.allMatches(html);

  if (sDataMatches.isNotEmpty) {
    print('[MATCH] Found ${sDataMatches.length} s-data blocks.');
    for (var match in sDataMatches) {
      String jsonStr = match.group(1)!;

      // Extract specific fields the user wants
      final markerRegex = RegExp(r'"marker"\s*:\s*"([^"]+)"');
      final provRegex = RegExp(r'"prov"\s*:\s*"([^"]+)"');
      final cityRegex = RegExp(r'"city"\s*:\s*"([^"]+)"');

      final markerMatch = markerRegex.firstMatch(jsonStr);
      final provMatch = provRegex.firstMatch(jsonStr);
      final cityMatch = cityRegex.firstMatch(jsonStr);

      if (markerMatch != null || provMatch != null || cityMatch != null) {
        print('[RESULT] s-data Content Found:');
        if (markerMatch != null) print('  Marker: ${markerMatch.group(1)}');
        if (provMatch != null) print('  Prov: ${provMatch.group(1)}');
        if (cityMatch != null) print('  City: ${cityMatch.group(1)}');
      }

      // Check for success marker
      if (jsonStr.contains("百度安全号码认证平台")) {
        print('[SUCCESS] Found s-data block with Success Marker!');
      }
    }
  } else {
    print('[FAIL] s-data Regex did NOT match.');
  }

  // 2. Official Card Title
  final officialTitleRegex = RegExp(
    r'<h3[^>]*class=["\u0027].*?c-title.*?["\u0027][^>]*>[\s\S]*?<a[^>]*>([\s\S]*?)<\/a>',
    caseSensitive: false,
  );
  final officialMatch = officialTitleRegex.firstMatch(html);
  if (officialMatch != null) {
    String rawName = officialMatch.group(1)!;
    rawName = rawName.replaceAll(RegExp(r'<[^>]+>'), '').trim();
    print('[RESULT] Official Title Found: $rawName');
  }

  // 2b. New-PMD HTML Structure (cc-title, cc-row)
  print('[TEST] Testing New-PMD HTML Regex...');
  final pmdTitleRegex = RegExp(
    r'class=["\u0027][^"\u0027]*cc-title_[^"\u0027]*["\u0027][^>]*>([\s\S]*?)<',
    caseSensitive: false,
  );
  final pmdRowRegex = RegExp(
    r'class=["\u0027][^"\u0027]*cc-row_[^"\u0027]*["\u0027][^>]*>([\s\S]*?)<',
    caseSensitive: false,
  );

  final pmdTitleMatch = pmdTitleRegex.firstMatch(html);
  final pmdRowMatch = pmdRowRegex.firstMatch(html);

  if (pmdTitleMatch != null) {
    String content = pmdTitleMatch.group(1)!.trim();
    print('[RESULT] PMD Title Content: $content');
  }
  if (pmdRowMatch != null) {
    String content = pmdRowMatch.group(1)!.trim();
    print('[RESULT] PMD Row Content: $content');
  }

  // 4. Location (Legacy)
  final locationRegex = RegExp(r'归属地：(.*?)(<|$)', caseSensitive: false);
  final locationMatch = locationRegex.firstMatch(html);
  if (locationMatch != null) {
    print('[RESULT] Location Found (Legacy): ${locationMatch.group(1)}');
  }
}
