import 'dart:core';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../new_set_icons.dart';
import '../../screens/appstate_provider.dart';
import '../../services/allowed_blocked_service.dart';
import '../../services/blacklist_whitelist_service.dart';
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

class BlacklistPageView extends StatelessWidget {
  const BlacklistPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return buildPageWithCollapsibleContent(
      context,
      S.of(context).blacklistPage, // 页面标题
     // 'BlacklistPageView', // 卡片标题=点击卡片导航到的页面
      const BlacklistPageView(), // 点击卡片导航到的页面
      const BlacklistPage(), // 当前页面主要内容
      exportPage: const ExportBlacklistsPageView(), // 导出页面
      exportLabel: S.of(context).export, // 自定义导出按钮文字
      addPage: const AddBlacklistPageView(), // 添加页面
      addLabel: S.of(context).add, // 自定义 add 按钮文字
      importPage: const ImportBlacklistsPageView(), // 导入页面
      importLabel: S.of(context).import, // 自定义导入按钮文字
    );
  }
}

class BlacklistPage extends StatefulWidget {
  const BlacklistPage({super.key});

  @override
  BlacklistPageState createState() => BlacklistPageState();
}

class BlacklistPageState extends State<BlacklistPage>
    with WidgetsBindingObserver {
  // final BlacklistService _subscriptionService =
  //     BlacklistService(database as Database);
  late BlacklistService _blacklistService;
  //late WhitelistService _whitelistService;
  late AllowedService _allowedService;
  late BlockedService _blockedService;
  Map<String, bool> _expandedItems = {};
  List<BlacklistEntry> _entries = [];
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
    _blacklistService = appState.blacklistService;
    _loadEntries();
  }

  Future<void> _loadEntries() async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });
    try {
      final entries = await _blacklistService.getEntries(
          orderBy: 'phoneNumber',
          ascending: true); // 这里传入 phoneNumber 作为 orderBy 参数
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

  bool _isAllowed = false;
  bool _isBlocked = false;

  void _onSwitchChanged(bool newValue) {
    setState(() {
      if (_isAllowed == _isBlocked) {
        // 当两个开关状态相同时（都为 false，因为它们不能同时为 true）
        if (newValue) {
          // 如果新值为 true，我们需要确定哪个开关被点击
          if (_isAllowed != newValue) {
            _isAllowed = true;
            _isBlocked = false;
          } else {
            _isBlocked = true;
            _isAllowed = false;
          }
        }
        // 如果新值为 false，不需要做任何改变，因为两个开关已经是 false
      } else {
        // 当两个开关状态不同时（一个为 true，一个为 false）
        if (newValue) {
          // 如果新值为 true，我们需要切换状态
          _isAllowed = !_isAllowed;
          _isBlocked = !_isBlocked;
        } else {
          // 如果新值为 false，我们只需要将当前为 true 的开关设为 false
          _isAllowed = false;
          _isBlocked = false;
        }
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
            : AdvancedSelfManagedSearchBar<BlacklistEntry>(
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

  Widget _buildEntryItem(BlacklistEntry entry, double entryWidth) {
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

  Widget _buildExpandedContent(BuildContext context, BlacklistEntry entry) {
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
            isAllowed: _isAllowed,
            isBlocked: _isBlocked,
            onSwitchChanged: _onSwitchChanged,
            allowedType: "Allowed", // 传入 "Whitelist"
            blockedType: "Blocked", // 传入 "Blacklist"
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
                Provider.of<AppState>(context, listen: false).blacklistService),
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
                    avatarController.text, _isAllowed, _isBlocked),
              ),
            ],
          ),
        ],
      ),
    );
  }

// BlacklistPage
  void _showDeleteConfirmation(BuildContext context, BlacklistEntry entry) {
    showDeleteConfirmationDialog<BlacklistEntry>(
      context,
      entry,
      _blacklistService.remove,
      displayText: entry.phoneNumber, // 传递 phoneNumber 参数 代表删除的时候展示的关键词
    );
  }

  void _saveEntry(BlacklistEntry entry, String name, String avatar,
      bool isAllowed, bool isBlocked) async {
    // 添加 isAllowed 和 isBlocked 参数
    final updatedEntry = BlacklistEntry(
      phoneNumber: entry.phoneNumber,
      label: entry.label,
      name: name,
      avatar: avatar,
      isSubscribed: entry.isSubscribed,
      count: entry.count,
      url: entry.url,
    );

    final allowedEntry = AllowedEntry(
      phoneNumber: updatedEntry.phoneNumber,
      label: updatedEntry.label,
      name: updatedEntry.name,
      avatar: updatedEntry.avatar,
    );

    final blockedEntry = BlockedEntry(
      phoneNumber: updatedEntry.phoneNumber,
      label: updatedEntry.label,
      name: updatedEntry.name,
      avatar: updatedEntry.avatar,
    );

    await _blacklistService.addOrUpdate(updatedEntry);
    if (isAllowed) {
      // 使用传递的 isAllowed
      await _allowedService.addOrUpdate(allowedEntry);
      await _blockedService.remove(blockedEntry);
    } else if (isBlocked) {
      // 使用传递的 isBlocked
      await _blockedService.addOrUpdate(blockedEntry);
      await _allowedService.remove(allowedEntry);
    }
    await _loadEntries();
    setState(() {
      _expandedItems[entry.phoneNumber] = false;
    });
  }
//结束
}
