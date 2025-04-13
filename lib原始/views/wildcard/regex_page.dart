import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



import '../../generated/l10n.dart';
import '../../new_set_icons.dart';
import '../../screens/appstate_provider.dart';
import '../../services/regex_service.dart';

import '../../utils/ad_manager.dart';
import '../../utils/ad_state.dart';


import '../../widgets/google_ad.dart';

import '../../widgets/self_managed_search_bar.dart';

import '../public/build_page_switch.dart';
import '../public/isolated_widgets.dart';
import '../public/responsive_grid_list.dart';



import 'add_regex.dart';
import 'export_regexs.dart';
import 'import_regexs.dart';

class RegexPageView extends StatelessWidget {
  const RegexPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return buildPageWithCollapsibleContent(
      context,
      S.of(context).regexPage, // 页面标题
     // 'RegexPageView', // 卡片标题=点击卡片导航到的页面
      const RegexPageView(), // 点击卡片导航到的页面
      const RegexPage(), // 当前页面主要内容
      exportPage: const ExportRegexPageView(), // 导出页面
      exportLabel: S.of(context).export, // 自定义导出按钮文字
      addPage: const AddRegexPageView(), // 添加页面
      addLabel: S.of(context).add, // 自定义 add 按钮文字
      importPage: const ImportRegexPageView(), // 导入页面
      importLabel: S.of(context).import, // 自定义导入按钮文字
    );
  }
}





class RegexPage extends StatefulWidget {
  const RegexPage({super.key});

  @override
  RegexPageState createState() => RegexPageState();
}

class RegexPageState extends State<RegexPage> with WidgetsBindingObserver {


  late RegexService _regexService;
  Map<String, bool> _expandedItems = {};
  List<RegexPattern> _patterns = [];
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
      _loadSubscriptions();
    }
  }

  void _initializeServices() {
    final appState = Provider.of<AppState>(context, listen: false);

    _regexService = appState.regexService;
    _loadSubscriptions();
  }

  Future<void> _loadSubscriptions() async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });
    try {
      final patterns = await _regexService.getAllPatterns(orderBy: 'pattern', ascending: true);
      setState(() {
        _patterns = patterns;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

bool _isWhitelist = false;
bool _isBlacklist = false;

  void _onSwitchChanged(bool newValue) {
    setState(() {
      if (_isWhitelist == _isBlacklist) {
        // 当两个开关状态相同时（都为 false，因为它们不能同时为 true）
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
        if (newValue) {
          // 如果新值为 true，我们需要切换状态
          _isWhitelist = !_isWhitelist;
          _isBlacklist = !_isBlacklist;
        } else {
          // 如果新值为 false，我们只需要将当前为 true 的开关设为 false
          if (_isWhitelist) {
          _isWhitelist = false;
          _isBlacklist = true;
        } else {
          _isBlacklist = false;
          _isWhitelist = true;
        }
        }
      }
    });
  }





@override
Widget build(BuildContext context) {
  return Scaffold(
    body: RefreshIndicator(
      onRefresh: _loadSubscriptions,
      child: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : AdvancedSelfManagedSearchBar<RegexPattern>(
     
              items: _patterns,
              itemBuilder: (context, rexPattern, width) => _buildSubscriptionItem(rexPattern, width),
              getSearchString: (rexPattern) => '${rexPattern.pattern}  ${rexPattern.name}',
              getSortFields: (rexPattern) => ['Pattern', 'Name'],
              getSortFieldValues: (rexPattern) => [rexPattern.pattern, rexPattern.name],
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
        _patterns, _buildSubscriptionItem, adState.isAdEnabled);
  }

  Widget _buildSubscriptionItem(
      RegexPattern rexPattern, double subscriptionWidth) {
    return Card(
      color: Colors.grey[100],
      margin: const EdgeInsets.all(10.0),
      child: ExpansionTile(
        key: ValueKey(rexPattern.pattern),
        initiallyExpanded: _expandedItems[rexPattern.pattern] ?? false,
        onExpansionChanged: (isExpanded) {
          _expandedItems[rexPattern.pattern] = isExpanded;
        },
        title: SubscriptionTitleWidget(name: rexPattern.name),
        subtitle: Row(
          children: [
            SubscriptionUrlWidget(url: rexPattern.pattern),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SubscriptionStatusIconWidget(
              isBlacklist: rexPattern.isBlacklist,
              isWhitelist: rexPattern.isWhitelist,
            ),
            const SizedBox(width: 8),

                        EnableDisableButtonWidget(
              isEnabled: rexPattern.enabled,
              onPressed: () async {
              //  rexPattern.enabled = !rexPattern.enabled;

                 await _toggleSubscriptionEnabled(rexPattern);

                setState(() {
                 // rexPattern.enabled = !rexPattern.enabled;
                  });
              },
            ),
/*
// 在 _buildSubscriptionItem 中调用 _toggleSubscriptionEnabled
EnableDisableButtonWidget<RegexPattern>(
  isEnabled: rexPattern.enabled,
  item: pattern,
  onToggle: (context, pattern) => _toggleSubscriptionEnabled(context, pattern),
),
*/

            const SizedBox(width: 8),
            DeleteButtonWidget(
              onPressed: () => _showDeleteConfirmation(context, rexPattern),
            ),
            ExpansionIconWidget(
                isExpanded: _expandedItems[rexPattern.pattern] ?? false),

          ],
        ),
        children: [
          _buildExpandedContent(context, rexPattern),
        ],
      ),
    );
  }

  Widget _buildExpandedContent(
      BuildContext context, RegexPattern rexPattern) {
        final TextEditingController nameController = TextEditingController(text: rexPattern.name);
    //新增加的url 路径
    final TextEditingController patternController = TextEditingController(text: rexPattern.pattern);

  // 在这里更新 _isWhitelist 和 _isBlacklist 的值
  _isWhitelist = rexPattern.isWhitelist;
  _isBlacklist = rexPattern.isBlacklist;


    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
    
        children: [
          const Divider(height: 1),
                    const SizedBox(height: 10.0),
          NameInputWidget(
            nameController: nameController,
          ),
          const SizedBox(height: 10.0),
          /*
          PatternInputWidget(
            patternController: patternController,
          ),

          */

          const Divider(),

          const SizedBox(height: 10.0),
                    SwitchRowWidget(
            isAllowed: _isWhitelist,
            isBlocked: _isBlacklist,
            onSwitchChanged: _onSwitchChanged,
              allowedType: "Whitelist", // 传入 "Whitelist"
  blockedType: "Blacklist", // 传入 "Blacklist"
          ),
          const Divider(),
          const SizedBox(height: 10.0),
          const GoogleAdWidget(adInfo: AdManager.bannerAd),

        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ActionButtonWidget(
              icon: NewSet.delete,
              label: S.of(context).delete,
              onPressed: () =>  _showDeleteConfirmation(context, rexPattern),
              pressedColor: Colors.red,
            ),
    
            ActionButtonWidget(
              icon: NewSet.check,
              label: S.of(context).save,
              onPressed: () => _saveEntry(rexPattern, nameController.text, 
                  _isWhitelist, _isBlacklist),
            ),
          ],
        ),
        ],
      ),
      );
  }


  Future<void> _showDeleteConfirmation(BuildContext context, RegexPattern rexPattern) async {
 // void _showDeleteConfirmation(BuildContext context, RegexPattern rexPattern) {
    showDeleteConfirmationDialog<RegexPattern>(
      context,
      rexPattern,
      _regexService.remove,
      displayText: rexPattern.pattern.toString(),
    );
      await _loadSubscriptions();
  }
Future<void> _toggleSubscriptionEnabled(RegexPattern rexPattern) async {
  rexPattern.enabled = !rexPattern.enabled;
// 添加日志输出
  // 更新后端数据
  await _regexService.edit(rexPattern);

  if (rexPattern.enabled) {
    await _regexService.enablePattern(rexPattern);
  } else {
    await _regexService.disablePattern(rexPattern);
  }
// 添加日志输出
 // setState(() {});
}


Future<void> _updatePattern(RegexPattern rexPattern, String name,  bool isWhitelist, bool isBlacklist) async {
  final updatedPattern = RegexPattern(
    pattern: rexPattern.pattern,
    name: name,
    isWhitelist: isWhitelist,
    isBlacklist: isBlacklist,
    enabled: rexPattern.enabled,


  );

  await _regexService.edit(updatedPattern);



  if (rexPattern.enabled) {
    await _regexService.enablePattern(updatedPattern);

  } else {
    await _regexService.disablePattern(updatedPattern);

  }

}

void _saveEntry(RegexPattern rexPattern, String name, bool isWhitelist, bool isBlacklist) async {
  await _updatePattern(rexPattern, name, isWhitelist, isBlacklist);

  await _loadSubscriptions();
  setState(() {
    _expandedItems[rexPattern.pattern] = false;
  });
}
  
}