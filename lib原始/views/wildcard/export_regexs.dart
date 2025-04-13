import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../generated/l10n.dart';

import '../../screens/appstate_provider.dart';

import '../../services/regex_service.dart';

import '../public/build_page_switch.dart';
import '../public/export_item.dart';
import '../public/select_items.dart';

import 'add_regex.dart';
import 'import_regexs.dart';

import 'regex_page.dart';

class ExportRegexPageView extends StatelessWidget {
  const ExportRegexPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return buildPageWithCollapsibleContent(
      context,
      S.of(context).exportRegexPage, // 页面标题
      // 'RegexPageView', // 卡片标题=点击卡片导航到的页面
      const RegexPageView(), // 点击卡片导航到的页面
      const ExportRegexPage(), // 当前页面主要内容
      exportPage: const ExportRegexPageView(), // 导出页面
      exportLabel: S.of(context).export, // 自定义导出按钮文字
      addPage: const AddRegexPageView(), // 添加页面
      addLabel: S.of(context).add, // 自定义 add 按钮文字
      importPage: const ImportRegexPageView(), // 导入页面
      importLabel: S.of(context).import, // 自定义导入按钮文字
    );
  }
}

class ExportRegexPage extends StatefulWidget {
  const ExportRegexPage({super.key});

  @override
  ExportRegexPageState createState() => ExportRegexPageState();
}

class ExportRegexPageState extends State<ExportRegexPage> {
  @override
  void initState() {
    super.initState();
    final appState = Provider.of<AppState>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);
    return _build(context, appState); // 直接调用 _build(context)
  }

  Widget _build(BuildContext context, AppState appState) {
    return ExportScreenWidget<RegexPattern>(
      // 使用泛型指定类型
      getEntries: appState.regexService.getAllPatterns,
      buildSelectDialog:
          (BuildContext context, List<RegexPattern> rexPatterns) {
        return SelectEntriesDialog<RegexPattern>(
          entries: rexPatterns,
          hasBlacklistWhitelistTabs: true,
          // searchKey: 'pattern',
          getSearchString: (entry) => entry.pattern, //  提供 Getter 函数
        );
      },
      exportToCsv: appState.regexService.exportToCsv,
      exportToJson: appState.regexService.exportToJson,
    );
  }
}
