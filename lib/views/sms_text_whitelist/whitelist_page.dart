import 'dart:core';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../new_set_icons.dart';
import '../../screens/appstate_provider.dart';
import '../../services/sms_text_service.dart';
import '../../utils/ad_manager.dart';
import '../../utils/ad_state.dart';
import '../../widgets/google_ad.dart';
import '../../widgets/self_managed_search_bar.dart';
import '../public/build_page_switch.dart';
import '../public/isolated_widgets.dart';
import '../public/responsive_grid_list.dart';
import 'add_whitelist.dart';
import 'export_whitelists.dart';
import 'import_whitelists.dart';



class SmsTextWhitelistPageView extends StatelessWidget {
  const SmsTextWhitelistPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return buildPageWithCollapsibleContent(
      context,
      S.of(context).smsTextWhitelistPage, // 页面标题
     // 'SmsTextWhitelistPageView', // 卡片标题=点击卡片导航到的页面
      const SmsTextWhitelistPageView(), // 点击卡片导航到的页面
      const SmsTextWhitelistPage(), // 当前页面主要内容
      exportPage: const ExportSmsTextWhitelistsPageView(), // 导出页面
      exportLabel: S.of(context).export, // 自定义导出按钮文字
      addPage: const AddSmsTextWhitelistPageView(), // 添加页面
      addLabel: S.of(context).add, // 自定义 add 按钮文字
      importPage: const ImportSmsTextWhitelistsPageView(), // 导入页面
      importLabel: S.of(context).import, // 自定义导入按钮文字
    );
  }
}

class SmsTextWhitelistPage extends StatefulWidget {
  const SmsTextWhitelistPage({super.key});

  @override
  SmsTextWhitelistPageState createState() => SmsTextWhitelistPageState();
}

class SmsTextWhitelistPageState extends State<SmsTextWhitelistPage>
    with WidgetsBindingObserver {
  // final SmsTextWhitelistService _subscriptionService =
  //     SmsTextWhitelistService(database as Database);
  late SmsTextWhitelistService _smsTextWhitelistService;
late SmsTextBlacklistService _smsTextBlacklistService;

  Map<String, bool> _expandedItems = {};
  List<SmsTextWhitelistEntry> _entries = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeServices();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _loadEntries();
    }
  }

  void _initializeServices() {
    final appState = Provider.of<AppState>(context, listen: false);
    _smsTextWhitelistService = appState.smsTextWhitelistService;
    _smsTextWhitelistService = appState.smsTextWhitelistService;
    _loadEntries();
  }

  Future<void> _loadEntries() async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });
    try {
      final entries = await _smsTextWhitelistService.getEntries(orderBy: 'keyword', ascending: true); // 这里传入 keyword 作为 orderBy 参数
      setState(() {
        _entries = entries;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

bool _isWhitelist = true;
bool _isBlacklist = false;  // 默认设置为 true

void _onSwitchChanged(bool newValue) {
  setState(() {
    if (_isWhitelist == _isBlacklist) {
      // 这种情况现在只会发生在两个都为 false 时
      if (newValue) {
        // 如果新值为 true，我们需要确定哪个开关被点击
        if (_isWhitelist != newValue) {
          _isWhitelist = true;
          _isBlacklist = false;
        } else {
          _isBlacklist = true;
          _isWhitelist = false;
        }
      }
      // 如果新值为 false，不需要做任何改变，因为两个开关已经是 false
    } else {
      // 当两个开关状态不同时（一个为 true，一个为 false）
      _isWhitelist = !_isWhitelist;
      _isBlacklist = !_isBlacklist;
    }
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _loadEntries,
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : AdvancedSelfManagedSearchBar<SmsTextWhitelistEntry>(
                items: _entries,
                itemBuilder: (context, entry, width) =>
                    _buildEntryItem(entry, width),
                getSearchString: (entry) =>
                    '${entry.keyword} ${entry.name}',
                getSortFields: (entry) => ['Keyword', 'Name'],
                getSortFieldValues: (entry) =>
                    [entry.keyword, entry.name],
                originalBuilder: (context, items) => _build(context),
                //adBuilder: (width, height) => nativeAdWidgetSmall(adWidth: width, adHeight: height),
                // 添加回调函数
              ),
      ),
    );
  }

// 私有的构建订阅列表方法
  Widget _build(BuildContext context) {
    final adState = Provider.of<AdState>(context);
    return buildResponsiveGridList(
        _entries, _buildEntryItem, adState.isAdEnabled);
  }

  Widget _buildEntryItem(SmsTextWhitelistEntry entry, double entryWidth) {
    return Card(
      color: Colors.grey[100],
      margin: const EdgeInsets.all(10.0),
      child: ExpansionTile(
        key: ValueKey(entry.keyword),
        initiallyExpanded: _expandedItems[entry.keyword] ?? false,
        onExpansionChanged: (isExpanded) {
          setState(() {
            _expandedItems[entry.keyword] = isExpanded;
          });
        },

        title: KeywordWidget(keyword: entry.keyword),
        subtitle: LabelAndNameWidget(name: entry.name),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            StatusIconWidget(isSubscribed: entry.isSubscribed),
            const SizedBox(width: 8),
            DeleteButtonWidget(
                onPressed: () => _showDeleteConfirmation(context, entry)),
            ExpansionIconWidget(
                isExpanded: _expandedItems[entry.keyword] ?? false),
          ],
        ),
        children: [_buildExpandedContent(context, entry)],
      ),
    );
  }

  Widget _buildExpandedContent(BuildContext context, SmsTextWhitelistEntry entry) {
    final TextEditingController nameController =
        TextEditingController(text: entry.name);
    final TextEditingController keywordController =
        TextEditingController(text: entry.keyword);

    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
      children: [
        const Divider(height: 1),
        const SizedBox(height: 10),
          NameInputWidget(
            nameController: nameController,
          ),
          const SizedBox(height: 10.0),
        SwitchRowWidget(
          isAllowed: _isWhitelist,
          isBlocked: _isBlacklist,
          onSwitchChanged: _onSwitchChanged,
            allowedType: "Whitelist", // 传入 "Whitelist"
  blockedType: "Blacklist", // 传入 "Blacklist"
        ),
        const Divider(),
          
         //   Expanded(child: KeywordInputWidget(keywordController: keywordController)),
        const GoogleAdWidget(adInfo: AdManager.bannerAd),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ActionButtonWidget(
              icon: NewSet.delete,
              label: S.of(context).delete,
              onPressed: () => _showDeleteConfirmation(context, entry),
              pressedColor: Colors.red,
            ),
         //   Expanded(child: NameInputWidget(nameController: nameController)),
            ActionButtonWidget(
              icon: NewSet.check,
              label: S.of(context).save,
              onPressed: () => _saveEntry(entry, nameController.text,
                   _isWhitelist, _isBlacklist),
            ),
          ],
        ),
      ],
    ),
    );
  }


// SmsTextWhitelistPage
void _showDeleteConfirmation(BuildContext context, SmsTextWhitelistEntry entry) {
  showDeleteConfirmationDialog<SmsTextWhitelistEntry>(
    context,
    entry,
    _smsTextWhitelistService.remove,
    displayText: entry.keyword, // 传递 keyword 参数 代表删除的时候展示的关键词
  );
}



  void _saveEntry(SmsTextWhitelistEntry entry, String name,
      bool isWhitelist, bool isBlacklist) async {
    // 添加 isWhitelist 和 isBlacklist 参数
    final updatedEntry = SmsTextWhitelistEntry(
      keyword: entry.keyword,

      name: name,

      isSubscribed: entry.isSubscribed,

      url: entry.url,
    );

    final smsTextWhitelistEntry = SmsTextWhitelistEntry(
      keyword: updatedEntry.keyword,

      name: updatedEntry.name,
     isSubscribed: updatedEntry.isSubscribed,    
url: updatedEntry.url,
    );

    final smsTextBlacklistEntry = SmsTextBlacklistEntry(
      keyword: updatedEntry.keyword,
  
      name: updatedEntry.name,
      isSubscribed: updatedEntry.isSubscribed,
url: updatedEntry.url,
    );

   
    if (isWhitelist) {
      // 使用传递的 isWhitelist
 await _smsTextWhitelistService.addOrUpdate(updatedEntry);

   await _smsTextBlacklistService.remove(smsTextBlacklistEntry);

    } else if (isBlacklist) {
      // 使用传递的 isBlacklist
 await _smsTextBlacklistService.addOrUpdate(smsTextBlacklistEntry);
      await _smsTextWhitelistService.remove(smsTextWhitelistEntry);
    }
    await _loadEntries();
    setState(() {
      _expandedItems[entry.keyword] = false;
    });
  }
//结束
}