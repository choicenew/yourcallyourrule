import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'dart:core';

import '../../generated/l10n.dart';
import '../../screens/appstate_provider.dart';
import '../../services/allowed_blocked_service.dart';
import '../../utils/ad_manager.dart';
import '../../utils/ad_state.dart';
import '../../widgets/google_ad.dart';
import '../../widgets/self_managed_search_bar.dart';
import '../public/build_page_switch.dart';
import '../public/isolated_widgets.dart';
import '../public/public_select_label.dart';
import '../public/responsive_grid_list.dart';
import 'add_blacklist.dart';
import 'export_blacklists.dart';
import 'import_blacklists.dart';





import '../../services/sms_blacklist_whitelist_service.dart';

import '../../new_set_icons.dart';


class SmsBlacklistPageView extends StatelessWidget {
  const SmsBlacklistPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return buildPageWithCollapsibleContent(
      context,
      S.of(context).whitelistPage, // 页面标题
     // 'SmsBlacklistPageView', // 卡片标题=点击卡片导航到的页面
      const SmsBlacklistPageView(), // 点击卡片导航到的页面
      const SmsBlacklistPage(), // 当前页面主要内容
      exportPage: const ExportSmsBlacklistsPageView(), // 导出页面
      exportLabel: S.of(context).export, // 自定义导出按钮文字
      addPage: const AddSmsBlacklistPageView(), // 添加页面
      addLabel: S.of(context).add, // 自定义 add 按钮文字
      importPage: const ImportSmsBlacklistsPageView(), // 导入页面
      importLabel: S.of(context).import, // 自定义导入按钮文字
    );
  }
}

class SmsBlacklistPage extends StatefulWidget {
  const SmsBlacklistPage({super.key});

  @override
  SmsBlacklistPageState createState() => SmsBlacklistPageState();
}

class SmsBlacklistPageState extends State<SmsBlacklistPage>
    with WidgetsBindingObserver {
  // final SmsBlacklistService _subscriptionService =
  //     SmsBlacklistService(database as Database);
  late SmsBlacklistService _smsBlacklistService;
  late SmsWhitelistService _smsWhitelistService;
  late AllowedService _allowedService;
  late BlockedService _blockedService;
  Map<String, bool> _expandedItems = {};
  List<SmsBlacklistEntry> _entries = [];
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
    _allowedService = appState.allowedService;
    _blockedService = appState.blockedService;
    _smsBlacklistService = appState.smsBlacklistService;
        _smsWhitelistService = appState.smsWhitelistService;
    _loadEntries();
  }

  Future<void> _loadEntries() async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });
    try {
      final entries = await _smsBlacklistService.getEntries(orderBy: 'phoneNumber', ascending: true); // 这里传入 phoneNumber 作为 orderBy 参数
      setState(() {
        _entries = entries;
        _isLoading = false;
      });
    } catch (e) {
      //print('Error loading entries: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

bool _isWhitelist = false;
bool _isBlacklist = true;  // 默认设置为 true

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
            : AdvancedSelfManagedSearchBar<SmsBlacklistEntry>(
                items: _entries,
                itemBuilder: (context, entry, width) =>
                    _buildEntryItem(entry, width),
                getSearchString: (entry) =>
                    '${entry.label} ${entry.phoneNumber} ${entry.name}',
                getSortFields: (entry) => ['Label', 'Phone Number', 'Name'],
                getSortFieldValues: (entry) =>
                    [entry.label, entry.phoneNumber, entry.name],
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

  Widget _buildEntryItem(SmsBlacklistEntry entry, double entryWidth) {
    return Card(
      color: Colors.grey[100],
      margin: const EdgeInsets.all(10.0),
      child: ExpansionTile(
        key: ValueKey(entry.phoneNumber),
        initiallyExpanded: _expandedItems[entry.phoneNumber] ?? false,
        onExpansionChanged: (isExpanded) {
          setState(() {
            _expandedItems[entry.phoneNumber] = isExpanded;
          });
        },
        leading: AvatarWidget(avatar: entry.avatar, label: entry.label),
        title: PhoneNumberWidget(phoneNumber: entry.phoneNumber),
        subtitle: LabelAndNameWidget(label: entry.label, name: entry.name),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            StatusIconWidget(isSubscribed: entry.isSubscribed),
            const SizedBox(width: 8),
            DeleteButtonWidget(
                onPressed: () => _showDeleteConfirmation(context, entry)),
            ExpansionIconWidget(
                isExpanded: _expandedItems[entry.phoneNumber] ?? false),
          ],
        ),
        children: [_buildExpandedContent(context, entry)],
      ),
    );
  }

  Widget _buildExpandedContent(BuildContext context, SmsBlacklistEntry entry) {
    final TextEditingController nameController =
        TextEditingController(text: entry.name);
    final TextEditingController avatarController =
        TextEditingController(text: entry.avatar);

    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
      children: [
        const Divider(height: 1),
        const SizedBox(height: 10),
        AvatarEditSectionWidget(
          avatar: entry.avatar,
          label: entry.label,
          onAvatarChanged: (newAvatarPath) {
            setState(() {
              entry.avatar = newAvatarPath;
            });
          },
        ),
        const SizedBox(height: 10),
        const Divider(height: 1),
        SwitchRowWidget(
          isAllowed: _isWhitelist,
          isBlocked: _isBlacklist,
          onSwitchChanged: _onSwitchChanged,
            allowedType: "Whitelist", // 传入 "Whitelist"
  blockedType: "Blacklist", // 传入 "Blacklist"
        ),
        const Divider(),
        Labels(
          initialLabel: entry.label,
          phoneNumber: entry.phoneNumber,
          onLabelChanged: (newLabel) {
            setState(() {
              entry.label = newLabel;
            });
          },
          selectLabelService: ListServiceAdapter(
              Provider.of<AppState>(context, listen: false).smsBlacklistService),
        ),
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
            Expanded(child: NameInputWidget(nameController: nameController)),
            ActionButtonWidget(
              icon: NewSet.check,
              label: S.of(context).save,
              onPressed: () => _saveEntry(entry, nameController.text,
                  avatarController.text, _isWhitelist, _isBlacklist),
            ),
          ],
        ),
      ],
    ),
    );
  }


// SmsBlacklistPage
void _showDeleteConfirmation(BuildContext context, SmsBlacklistEntry entry) {
  showDeleteConfirmationDialog<SmsBlacklistEntry>(
    context,
    entry,
    _smsBlacklistService.remove,
    displayText: entry.phoneNumber, // 传递 phoneNumber 参数 代表删除的时候展示的关键词
  );
}



  void _saveEntry(SmsBlacklistEntry entry, String name, String avatar,
      bool isWhitelist, bool isBlacklist) async {
    // 添加 isAllowed 和 isBlocked 参数
    final updatedEntry = SmsBlacklistEntry(
      phoneNumber: entry.phoneNumber,
      label: entry.label,
      name: name,
      avatar: avatar,
      isSubscribed: entry.isSubscribed,

      url: entry.url,
    );

    final smsWhitelistEntry = SmsWhitelistEntry(
      phoneNumber: updatedEntry.phoneNumber,
      label: updatedEntry.label,
      name: updatedEntry.name,
      avatar: updatedEntry.avatar,
    );

    final smsBlacklistEntry = SmsBlacklistEntry(
      phoneNumber: updatedEntry.phoneNumber,
      label: updatedEntry.label,
      name: updatedEntry.name,
      avatar: updatedEntry.avatar,
    );


    if (isBlacklist) {
      // 使用传递的 isWhitelist
 await _smsBlacklistService.addOrUpdate(updatedEntry);

   await _smsWhitelistService.remove(smsWhitelistEntry);

    } else if (isWhitelist) {
      // 使用传递的 isBlacklist
 await _smsWhitelistService.addOrUpdate(smsWhitelistEntry);
      await _smsBlacklistService.remove(smsBlacklistEntry);
    }





    await _loadEntries();
    setState(() {
      _expandedItems[entry.phoneNumber] = false;
    });
  }
//结束
}


