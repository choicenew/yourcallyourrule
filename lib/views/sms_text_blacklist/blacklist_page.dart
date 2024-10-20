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
import 'add_blacklist.dart';
import 'export_blacklists.dart';
import 'import_blacklists.dart';

class SmsTextBlacklistPageView extends StatelessWidget {
  const SmsTextBlacklistPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return buildPageWithCollapsibleContent(
      context,
      S.of(context).smsBlacklistPage, // 页面标题
    //  'SmsTextBlacklistPageView', // 卡片标题=点击卡片导航到的页面
      const SmsTextBlacklistPageView(), // 点击卡片导航到的页面
      const SmsTextBlacklistPage(), // 当前页面主要内容
      exportPage: const ExportSmsTextBlacklistsPageView(), // 导出页面
      exportLabel: S.of(context).export, // 自定义导出按钮文字
      addPage: const AddSmsTextBlacklistPageView(), // 添加页面
      addLabel: S.of(context).add, // 自定义 add 按钮文字
      importPage: const ImportSmsTextBlacklistsPageView(), // 导入页面
      importLabel: S.of(context).import, // 自定义导入按钮文字
    );
  }
}

class SmsTextBlacklistPage extends StatefulWidget {
  const SmsTextBlacklistPage({super.key});

  @override
  SmsTextBlacklistPageState createState() => SmsTextBlacklistPageState();
}

class SmsTextBlacklistPageState extends State<SmsTextBlacklistPage>
    with WidgetsBindingObserver {
  // final SmsTextBlacklistService _subscriptionService =
  //     SmsTextBlacklistService(database as Database);
  late SmsTextBlacklistService _smsTextBlacklistService;
  late SmsTextWhitelistService _smsTextWhitelistService;

  Map<String, bool> _expandedItems = {};
  List<SmsTextBlacklistEntry> _entries = [];
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
    _smsTextBlacklistService = appState.smsTextBlacklistService;
    _loadEntries();
  }

  Future<void> _loadEntries() async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });
    try {
      final entries = await _smsTextBlacklistService.getEntries(
          orderBy: 'keyword', ascending: true); // 这里传入 keyword 作为 orderBy 参数
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

  bool _isWhitelist = false;
  bool _isBlacklist = true; // 默认设置为 true

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
            : AdvancedSelfManagedSearchBar<SmsTextBlacklistEntry>(
                items: _entries,
                itemBuilder: (context, entry, width) =>
                    _buildEntryItem(entry, width),
                getSearchString: (entry) => '${entry.keyword} ${entry.name}',
                getSortFields: (entry) => ['Keyword', 'Name'],
                getSortFieldValues: (entry) => [entry.keyword, entry.name],
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

  Widget _buildEntryItem(SmsTextBlacklistEntry entry, double entryWidth) {
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

  Widget _buildExpandedContent(
      BuildContext context, SmsTextBlacklistEntry entry) {
    final TextEditingController nameController =
        TextEditingController(text: entry.name);

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

          //  Expanded(child: KeywordInputWidget(keywordController: keywordController)),
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
              ActionButtonWidget(
                icon: NewSet.check,
                label: S.of(context).save,
                onPressed: () => _saveEntry(
                    entry, nameController.text, _isWhitelist, _isBlacklist),
              ),
            ],
          ),
        ],
      ),
    );
  }

// SmsTextBlacklistPage
  void _showDeleteConfirmation(
      BuildContext context, SmsTextBlacklistEntry entry) {
    showDeleteConfirmationDialog<SmsTextBlacklistEntry>(
      context,
      entry,
      _smsTextBlacklistService.remove,
      displayText: entry.keyword, // 传递 keyword 参数 代表删除的时候展示的关键词
    );
  }

  void _saveEntry(SmsTextBlacklistEntry entry, String name, bool isWhitelist,
      bool isBlacklist) async {
    // 添加 isWhitelist 和 isBlacklist 参数
    final updatedEntry = SmsTextBlacklistEntry(
      keyword: entry.keyword,
      name: name,
      isSubscribed: entry.isSubscribed,
      url: entry.url,
    );

    final smsTextBlacklistEntry = SmsTextBlacklistEntry(
      keyword: updatedEntry.keyword,
      name: updatedEntry.name,
      url: updatedEntry.url,
    );

    final smsTextWhitelistEntry = SmsTextWhitelistEntry(
      keyword: updatedEntry.keyword,
      name: updatedEntry.name,
      url: updatedEntry.url,
    );

    if (isBlacklist) {
      // 使用传递的 isWhitelist
      await _smsTextBlacklistService.addOrUpdate(updatedEntry);

      await _smsTextWhitelistService.remove(smsTextWhitelistEntry);
    } else if (isWhitelist) {
      // 使用传递的 isBlacklist
      await _smsTextWhitelistService.addOrUpdate(smsTextWhitelistEntry);
      await _smsTextBlacklistService.remove(smsTextBlacklistEntry);
    }
    await _loadEntries();
    setState(() {
      _expandedItems[entry.keyword] = false;
    });
  }
//结束
}
