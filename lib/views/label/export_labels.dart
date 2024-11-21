
import 'dart:core';


import 'package:flutter/material.dart';



import 'package:provider/provider.dart';


import '../../generated/l10n.dart';


import '../../screens/appstate_provider.dart';
import '../../services/label_service.dart';



import '../public/build_page_switch.dart';
import '../public/export_item.dart';
import '../public/select_items.dart';

import 'add_label.dart';

import 'import_labels.dart';
import 'label_page.dart';


class ExportLabelsPageView extends StatelessWidget {
  const ExportLabelsPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return buildPageWithCollapsibleContent(
      context,
      S.of(context).exportLabelPage, // 当前页面标题
     // 'LabelPageView', // 卡片标题=点击卡片导航到的页面
      const LabelPageView(), // create card卡片导航到的页面
      const ExportLabelsPage(), // 当前页面主要内容
      exportPage: const ExportLabelsPageView(), // 导出页面
      exportLabel: S.of(context).export, // 自定义导出按钮文字
      addPage: const AddLabelPageView(), // 添加页面
      addLabel: S.of(context).add, // 自定义 add 按钮文字
      importPage: const ImportLabelsPageView(), // 导入页面
      importLabel: S.of(context).import, // 自定义导入按钮文字
    );
  }
}


class ExportLabelsPage extends StatefulWidget {
  const ExportLabelsPage({super.key});

  @override
  ExportLabelsPageState createState() => ExportLabelsPageState();
}

class ExportLabelsPageState extends State<ExportLabelsPage> {


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
    return ExportScreenWidget<LabeledEntry>( // 使用泛型指定类型
      getEntries: appState.labelService.getEntries,
      buildSelectDialog: (BuildContext context, List<LabeledEntry> entries) {
        //return SelectBlacklistEntriesDialog(entries: entries);
        return SelectEntriesDialog<LabeledEntry>(
  entries: entries,
  hasSubscriptionTabs: false,
  //searchKey: 'phoneNumber',
   getSearchString: (entry) => entry.phoneNumber, //  提供 Getter 函数
);
      },
      exportToCsv: appState.labelService.exportToCsv,
      exportToJson: appState.labelService.exportToJson,
    );
  }
}