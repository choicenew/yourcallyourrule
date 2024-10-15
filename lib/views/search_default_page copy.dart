import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dlibphonenumber/locale.dart' as dlibphone;
import 'package:fl_country_code_picker/fl_country_code_picker.dart';

import '../new_set_icons.dart';
import '../screens/appstate_provider.dart';
import '../services/allowed_blocked_service.dart';
import '../services/blacklist_whitelist_service.dart';
import '../services/caller_id_service.dart';
import '../services/label_service.dart';
import '../services/sms_blacklist_whitelist_service.dart';
import '../services/sms_text_service.dart';
import '../utils/ad_manager.dart';
import '../utils/avatar_edit_dialog.dart';
import '../utils/language_provider.dart';
import '../utils/parse_phonenumber.dart';
import '../widgets/adwidgets/native_ads.dart';
import '../widgets/google_ad.dart';
import '../widgets/search_bar.dart';
import 'allowed/allowed_page.dart';
import 'allowed/select_label.dart';
import 'blacklist/select_label.dart';
import 'blocked/blocked_page.dart';
import 'blocked/select_label.dart';
import 'call_history/call_history.dart';
import 'label/add_label.dart';
import 'label/label_page.dart';
//import 'label/select_label.dart';
import 'public/public_select_label.dart';
import 'shield_switch_style.dart';
import 'subpage_style.dart';
import 'dart:core';

import 'whitelist/whitelist_page.dart';

class GeneralPage extends StatefulWidget {
  final SearchResult searchResult;

  const GeneralPage({super.key, required this.searchResult});

  @override
  State<GeneralPage> createState() => _GeneralPageState();
}

class _GeneralPageState extends State<GeneralPage> with WidgetsBindingObserver {
  late BlacklistService _blacklistService;
  late WhitelistService _whitelistService;
  late AllowedService _allowedService;
  late BlockedService _blockedService;
  late LabelService _labelService;
  late SmsBlacklistService _smsBlacklistService;
  late SmsWhitelistService _smsWhitelistService;
  late SmsTextBlacklistService _smsTextBlacklistService;
  late SmsTextWhitelistService _smsTextWhitelistService;

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

  void _initializeServices() {
    final appState = Provider.of<AppState>(context, listen: false);
    _allowedService = appState.allowedService;
    _blockedService = appState.blockedService;
    _blacklistService = appState.blacklistService;
    _allowedService = appState.allowedService;
    _blockedService = appState.blockedService;
    _labelService = appState.labelService;
    _smsBlacklistService = appState.smsBlacklistService;
    _smsWhitelistService = appState.smsWhitelistService;
    _smsTextBlacklistService = appState.smsTextBlacklistService;
    _smsTextWhitelistService = appState.smsTextWhitelistService;
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

  // 用于跟踪每个 ExpansionTile 的展开状态
  final Map<String, bool> _expandedItems = {};
  // 用于存储 CallerIdData 的变量
  CallerIdData? _callerIdData;

  @override
  Widget build(BuildContext context) {
    dynamic entry = getEntryByTableName(
        context, widget.searchResult.tableName, widget.searchResult.value);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.searchResult.value),
      ),
      body: entry != null
          ? _buildEntryItem(entry) // 号码存在于数据库，显示详细信息
          : _buildLabelWidget(
              context, widget.searchResult.value), // 号码不存在，只显示 buildLabelWidget
    );
  }

/*
@override
Widget build(BuildContext context) {
  dynamic entry = getEntryByTableName(
      context, widget.searchResult.tableName, widget.searchResult.value);

  return Scaffold(
    appBar: AppBar(
      title: Text(widget.searchResult.value),
    ),
    body: widget.searchResult.tableName.isEmpty // 检查 tableName 是否为空字符串
        ? CallHistoryPage(phoneNumber: widget.searchResult.value) // 是 CallLog 数据，跳转到 CallHistoryPage
        : (entry != null
            ? _buildEntryItem(entry) // 号码存在于数据库，显示详细信息
            : _buildLabelWidget(context, widget.searchResult.value)), // 号码不存在，只显示 buildLabelWidget
  );
}
*/

// 构建单个订阅项，并传入卡片宽度参数
  Widget _buildEntryItem(Future<dynamic> entryFuture) {
    // 接收 Future<dynamic> 作为参数

    return FutureBuilder<dynamic>(
      future: entryFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator()); // 显示加载指示器
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}')); // 显示错误信息
        } else {
          final entry = snapshot.data; // 获取 entry 对象

          return Column(
            children: [
              Card(
                color: Colors.grey[100], // 设置背景色为浅灰色
                margin: const EdgeInsets.all(10.0),
                child: ExpansionTile(
                  leading: Container(
                    width: 80.0,
                    height: 80.0,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.green,
                        width: 2.0,
                      ),
                      image: DecorationImage(
                        alignment: Alignment.center,
                        image: _buildAvatarImage(entry),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  title: Text(
                    entry.phoneNumber,
                    style: entryTitleStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Row(
                    children: [
                      Text(
                        entry.label,
                        style: entryLabelStyle,
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: Text(
                          entry.name ?? '',
                          style: entryNameStyle,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        entry.isSubscribed ? NewSet.link : NewSet.link_off,
                        color: entry.isSubscribed
                            ? onlineStatusIconColor
                            : offlineStatusIconColor,
                        size: statusIconSize,
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        iconSize: 32.0,
                        style: deleteButtonStyle,
                        onPressed: () =>
                            _showDeleteConfirmation(context, entry),
                      ),
                      // 展开/折叠图标
                      Icon(_expandedItems[entry.phoneNumber ?? entry.keyword] ==
                              true
                          ? Icons.expand_less
                          : Icons.expand_more),
                    ],
                  ),
                  // 使用 _expandedItems 跟踪 ExpansionTile 的展开状态
                  initiallyExpanded:
                      _expandedItems[entry.phoneNumber ?? entry.keyword] ??
                          false,
                  onExpansionChanged: (expanded) {
                    setState(() {
                      _expandedItems[entry.phoneNumber ?? entry.keyword] =
                          expanded;
                    });
                  },
                  children: [
                    SizedBox(
                      height: 600, // 可以根据需要调整高度
                      child: SingleChildScrollView(
                        child: buildExpandedContent(context, entry),
                      ),
                    ),
                  ],
                ),
              ),
              // 在 Card 后面添加广告
              nativeAdWidgetSmall(adWidth: 320, adHeight: 100),
            ],
          );
        }
      },
    );
  }

  Widget buildExpandedContent(BuildContext context, dynamic entry) {
    final screenWidth = MediaQuery.of(context).size.width;
    final textFieldHeight = 14.0; // 设置文本字段的高度

    //新增加的avatar 路径
    final TextEditingController avatarController =
        TextEditingController(text: entry.avatar);

    // 根据 entry 类型确定是否显示 Avatar 编辑部分
    final showAvatarEditing = entry is BlacklistEntry ||
        entry is AllowedEntry ||
        entry is BlockedEntry ||
        entry is SmsBlacklistEntry ||
        entry is SmsWhitelistEntry ||
        entry is WhitelistEntry ||
entry is LabeledEntry; // 添加 LabeledEntry

    // 根据 entry 类型确定是否显示允许/阻止开关
    final showAllowBlockSwitches = entry is BlacklistEntry ||
        entry is AllowedEntry ||
        entry is BlockedEntry ||
        entry is WhitelistEntry ||
        entry is LabeledEntry; // 添加 LabeledEntry

    // 根据 entry 类型确定是否显示标签组件
    Widget labelsWidget;
    if (entry is BlacklistEntry) {
      labelsWidget = Labels(
        initialLabel: entry.label,
        phoneNumber: entry.phoneNumber,
        onLabelChanged: (newLabel) {
          setState(() {
            entry.label = newLabel;
          });
        },
        selectLabelService: ListServiceAdapter(
            Provider.of<AppState>(context, listen: false).blacklistService),
      );

    } else if (entry is WhitelistEntry) {
      labelsWidget = Labels(
        initialLabel: entry.label,
        phoneNumber: entry.phoneNumber,
        onLabelChanged: (newLabel) {
          setState(() {
            entry.label = newLabel;
          });
        },
        selectLabelService: ListServiceAdapter(
            Provider.of<AppState>(context, listen: false).whitelistService),
      );

    } else if (entry is AllowedEntry) {
      labelsWidget = Labels(
        initialLabel: entry.label,
        phoneNumber: entry.phoneNumber,
        onLabelChanged: (newLabel) {
          setState(() {
            entry.label = newLabel;
          });
        },
        selectLabelService: ListServiceAdapter(
            Provider.of<AppState>(context, listen: false).allowedService),
      );
    } else if (entry is BlockedEntry) {
      labelsWidget = Labels(
        initialLabel: entry.label,
        phoneNumber: entry.phoneNumber,
        onLabelChanged: (newLabel) {
          setState(() {
            entry.label = newLabel;
          });
        },
        selectLabelService: ListServiceAdapter(
            Provider.of<AppState>(context, listen: false).blockedService),
      );
    } else if (entry is SmsWhitelistEntry) {
      labelsWidget = Labels(
        initialLabel: entry.label,
        phoneNumber: entry.phoneNumber,
        onLabelChanged: (newLabel) {
          setState(() {
            entry.label = newLabel;
          });
        },
        selectLabelService: ListServiceAdapter(
            Provider.of<AppState>(context, listen: false).smsWhitelistService),
      );
    } else if (entry is SmsBlacklistEntry) {
      labelsWidget = Labels(
        initialLabel: entry.label,
        phoneNumber: entry.phoneNumber,
        onLabelChanged: (newLabel) {
          setState(() {
            entry.label = newLabel;
          });
        },
        selectLabelService: ListServiceAdapter(
            Provider.of<AppState>(context, listen: false).smsBlacklistService),
      );      
    } else if (entry is LabeledEntry) {
      // 添加 LabeledEntry
      labelsWidget = Labels(
        initialLabel: entry.label,
        phoneNumber: entry.phoneNumber,
        onLabelChanged: (newLabel) {
          setState(() {
            entry.label = newLabel;
          });
        },
        selectLabelService: ListServiceAdapter(
            Provider.of<AppState>(context, listen: false).labelService),
      );
    } else {
      labelsWidget = const SizedBox.shrink();
    }

    // 根据 entry 类型确定文本字段的初始值
    String initialNameValue =
        entry is SmsTextBlacklistEntry || entry is SmsTextWhitelistEntry
            ? entry.keyword
            : entry.name;

    // 根据 entry 类型确定文本字段的标签
    String labelText =
        entry is SmsTextBlacklistEntry || entry is SmsTextWhitelistEntry
            ? 'Keyword'
            : 'Name';

    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(height: 1),
          const SizedBox(height: 10),

          // Avatar Editing Section (仅在 BlacklistEntry 中显示)
          if (showAvatarEditing)
            Row(
              children: [
                const Text('Choose Avatar (Local or Network):'),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) => AvatarEditDialog(
                      avatarController: avatarController,
                      onAvatarChanged: (newAvatarPath) {
                        setState(() {
                          entry.avatar = newAvatarPath;
                          avatarController.text = newAvatarPath;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          if (showAvatarEditing)
            TextFormField(
              controller: avatarController,
              decoration:
                  const InputDecoration(labelText: 'Avatar URL or Path'),
            ),

          if (showAvatarEditing) const Divider(height: 1),
          if (showAvatarEditing) const SizedBox(height: 10),

          // 插入 _buildCallerIdDataWidget
          _buildCallerIdDataWidget(context, entry.phoneNumber),

          // Blacklist/Whitelist options with adjusted padding
          // (仅在 BlacklistEntry, AllowedEntry, BlockedEntry, WhitelistEntry 中显示)
          if (showAllowBlockSwitches)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // allowed switch on the left
                Expanded(
                  child: Theme(
                    data: shieldSwitchThemeData,
                    child: SwitchListTile(
                      contentPadding: const EdgeInsets.only(top: 16, left: 16),
                      value: _isAllowed,
                      onChanged: _onSwitchChanged,
                      title: Text(
                        _isAllowed ? 'Add to Allowed' : 'Remove Allowed',
                        style: whiteTextStyle,
                      ),
                    ),
                  ),
                ),
                // blocked switch on the right
                Expanded(
                  child: Theme(
                    data: shieldSwitchThemeData,
                    child: SwitchListTile(
                      contentPadding: const EdgeInsets.only(top: 16, right: 16),
                      value: _isBlocked,
                      onChanged: (value) => _onSwitchChanged(!value),
                      title: Text(
                        _isBlocked ? 'Add to Blocked' : 'Remove Blocked',
                        style: whiteTextStyle,
                      ),
                    ),
                  ),
                ),
              ],
            ),

          // Stateful widget to manage Entry name and label
          labelsWidget,

          const Divider(height: 1),

          // name or keyword field
          if (entry is SmsTextBlacklistEntry || entry is SmsTextWhitelistEntry)
            Expanded(
              child: Container(
                width: screenWidth * 0.83,
                height: textFieldHeight,
                child: TextFormField(
                  initialValue: initialNameValue,
                  decoration: showmoreinputBoxDecoration.copyWith(
                    labelText: labelText,
                    border: const OutlineInputBorder(),
                    labelStyle: showmoreTextStyle,
                  ),
                  style: showmoreTextStyle,
                  onChanged: (value) {
                    setState(() {
                      if (entry is SmsTextBlacklistEntry ||
                          entry is SmsTextWhitelistEntry) {
                        entry.keyword = value;
                      } else {
                        entry.name = value;
                      }
                    });
                  },
                ),
              ),
            ),

          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ElevatedButton(
                  style: showmoreButtonStyle.copyWith(
                    foregroundColor: WidgetStateProperty.resolveWith<Color?>(
                      (Set<WidgetState> states) {
                        if (states.contains(WidgetState.pressed)) {
                          return Colors.green;
                        }
                        return null;
                      },
                    ),
                  ),
                  onPressed: () {
                    _showDeleteConfirmation(context, entry);
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(NewSet.delete),
                      SizedBox(width: 3.0),
                      Text('Delete'),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: TextFormField(
                    initialValue: entry.name,
                    decoration: showmoreinputBoxDecoration.copyWith(
                      labelText: 'Name',
                      border: const OutlineInputBorder(),
                      labelStyle: showmoreTextStyle,
                    ),
                    style: showmoreTextStyle,
                    onChanged: (value) {
                      setState(() {
                        entry.name = value;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    // 根据 entry 类型执行不同的保存操作

                   if (entry is BlacklistEntry) {
                      await _blacklistService.editEntry(entry);
                      if (_isAllowed) {
                        await _allowedService.add(entry as AllowedEntry);
                      } else if (_isBlocked) {
                        await _blockedService.add(entry as BlockedEntry);
                      }
                    } else if (entry is AllowedEntry) {
                      await _allowedService.editEntry(entry);
                    } else if (entry is BlockedEntry) {
                      await _blockedService.editEntry(entry);
                    } else if (entry is SmsBlacklistEntry) {
                      await _smsBlacklistService.editEntry(entry);
                    } else if (entry is SmsWhitelistEntry) {
                      await _smsWhitelistService.editEntry(entry);
                    } else if (entry is SmsTextBlacklistEntry) {
                      await _smsTextBlacklistService.editEntry(entry);
                    } else if (entry is SmsTextWhitelistEntry) {
                      await _smsTextWhitelistService.editEntry(entry);
                    } else if (entry is WhitelistEntry) {
                      await _whitelistService.editEntry(entry);
                    } else if (entry is LabeledEntry) {
                      // 添加 LabeledEntry
                      await _labelService.editEntry(entry);

                    }

                    // Additional action after saving (optional)
                    setState(() {
                      _expandedItems[entry.phoneNumber ?? entry.keyword] =
                          false;
                    });
                  },
                  style: showmoreButtonStyle,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(NewSet.check),
                      SizedBox(width: 8.0),
                      Text('Save'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

// ... (其他代码)

// 显示头像
  ImageProvider _buildAvatarImage(dynamic entry) {
    if (entry.avatar != null && entry.avatar!.isNotEmpty) {
      // 如果 entry.avatar 是 URL 链接，则使用 NetworkImage
      if (entry.avatar!.startsWith('http')) {
        return NetworkImage(entry.avatar!);
      } else {
        // 如果 entry.avatar 是本地资源路径，则使用 AssetImage
        return AssetImage(entry.avatar!);
      }
    } else if (entry.label != null && entry.label!.isNotEmpty) {
      // 如果 entry.label 不为空，则使用 entry.label 构建本地资源路径
      return AssetImage('assets/avatars/${entry.label}.png');
    } else {
      // 如果都为空，则使用默认的未知头像路径
      return const AssetImage('assets/avatars/unknown.png');
    }
  }

// 删除对话框
  void _showDeleteConfirmation(BuildContext context, dynamic entry) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('确认删除'),
        content: Text('您确定要删除 ${_getEntryDisplayName(entry)} 吗？'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();

              // 根据 entry 类型执行不同的删除操作
              if (entry is BlacklistEntry) {
                await _blacklistService.remove(entry);
              } else if (entry is AllowedEntry) {
                await _allowedService.remove(entry);
              } else if (entry is BlockedEntry) {
                await _blockedService.remove(entry);
              } else if (entry is LabeledEntry) {
                await _labelService.remove(entry);
              } else if (entry is SmsBlacklistEntry) {
                await _smsBlacklistService.remove(entry);
              } else if (entry is SmsWhitelistEntry) {
                await _smsWhitelistService.remove(entry);
              } else if (entry is SmsTextBlacklistEntry) {
                await _smsTextBlacklistService.remove(entry);
              } else if (entry is SmsTextWhitelistEntry) {
                await _smsTextWhitelistService.remove(entry);
              } else if (entry is WhitelistEntry) {
                await _whitelistService.remove(entry);
              }

              setState(() {}); // 更新 UI
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('删除成功')),
              );
            },
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }

  // 定义 CallerIdDataWidget
  CountryCode? selectedCountryCode;

// 主 Widget，包含国家代码选择器和 Caller ID 数据显示
  Widget _buildCallerIdDataWidget(BuildContext context, String phoneNumber) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 国家代码选择器
            _buildCountryCodeSelector(context, (countryCode) {
              // 更新外部的 selectedCountryCode
              setState(() {
                selectedCountryCode = countryCode;
              });
            }),
            // Caller ID 数据显示 (直接使用 FutureBuilder)
            FutureBuilder<CallerIdData>(
              key: ValueKey(selectedCountryCode), // 使用 countryCode 作为 Key
              future:
                  generateCallerIdData(phoneNumber, selectedCountryCode?.code),
              builder: (context, snapshot) {
                print("Selected Country Code: ${selectedCountryCode?.code}");
                print(
                    "FutureBuilder country code: ${selectedCountryCode?.code}");
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  final callerIdData = snapshot.data!;
                  return _buildCallerIdDataTable(callerIdData);
                } else {
                  return const Text('No data available.');
                }
              },
            ),
          ],
        );
      },
    );
  }

// ... 其他代码保持不变 ...

// 构建 CallerIdData 的 Table
  Widget _buildCallerIdDataTable(CallerIdData callerIdData) {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(1), // 冒号前占据 1/3 的空间
        1: FlexColumnWidth(2), // 冒号后占据 2/3 的空间
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle, // 垂直居中对齐
      children: [
        TableRow(
          children: [
            const Text(
              'Country:',
              style: callerlocationTextStyle,
            ),
            Text(
              callerIdData.countryName,
              style: callerlocationTextStyle,
            ),
          ],
        ),
        TableRow(
          children: [
            const Text(
              'Region:',
              style: callerlocationTextStyle,
            ),
            Text(
              callerIdData.region ?? '',
              style: callerlocationTextStyle,
            ),
          ],
        ),
        TableRow(
          children: [
            const Text(
              'Carrier:',
              style: callerlocationTextStyle,
            ),
            Text(
              callerIdData.carrier ?? '',
              style: callerlocationTextStyle,
            ),
          ],
        ),
        TableRow(
          children: [
            const Text(
              'label:',
              style: callerlocationTextStyle,
            ),
            Text(
              callerIdData.labels.first.label,
              style: callerlocationTextStyle,
            ),
          ],
        ),
      ],
    );
  }

// 构建选择国际区号的控件
  Widget _buildCountryCodeSelector(
    BuildContext context,
    Function(CountryCode?) onCountryCodeSelected,
  ) {
    const countryPicker = FlCountryCodePicker();
    final localeProvider = Provider.of<LocaleProvider>(context);

    return GestureDetector(
      onTap: () async {
        final picked = await countryPicker.showPicker(
          context: context,
          // initialSelectedLocale 设置为 null
          initialSelectedLocale: null,
        );
        // 将选择的国家代码传递给回调函数，并在 _buildCallerIdDataWidget 中触发重新构建
        onCountryCodeSelected(picked);
        print('Selected Country Code: ${picked?.code}');
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: const BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 使用 localeProvider.locale.countryCode 获取默认的国家代码和国家名称
            Text(
              selectedCountryCode != null
                  ? '${selectedCountryCode!.dialCode} ${selectedCountryCode!.name} (${selectedCountryCode!.code})'
                  : 'Select Country Code (Optional)',
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(width: 8.0),
            const Icon(Icons.arrow_drop_down, color: Colors.white),
          ],
        ),
      ),
    );
  }

//自定义添加labelpage 跳转
  Widget _buildLabelWidget(BuildContext context, String phoneNumber) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Align(
        // 使用 Align 组件
        alignment: Alignment.topCenter, // 设置顶部对齐
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildCallerIdDataWidget(context, phoneNumber),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AddLabelPage(initialPhoneNumber: phoneNumber),
                  ),
                );
              },
              child: const Text('Add to Label'),
            ),
            const SizedBox(height: 16),
            nativeAdWidgetMedium(adWidth: 320, adHeight: 400),
            const GoogleAdWidget(adInfo: AdManager.bannerAd),
          ],
        ),
      ),
    );
  }

// 获取 entry 的显示名称
  String _getEntryDisplayName(dynamic entry) {
    if (entry is SmsTextBlacklistEntry || entry is SmsTextWhitelistEntry) {
      return '阻止项 ${entry.keyword}';
    } else if (entry is LabeledEntry) {
      return '标签项 ${entry.name ?? entry.phoneNumber}';
    } else {
      return '阻止项 ${entry.phoneNumber}';
    }
  }

// ... (其他代码)

  // 根据 SearchResult 的 tableName 和 value 获取对应的 Entry 对象
  dynamic getEntryByTableName(
      BuildContext context, String tableName, String value) {
    switch (tableName) {
      case 'blacklist_phonenumber':
        return Provider.of<AppState>(context, listen: false)
            .blacklistService
            .getEntryByPhoneNumber(value);
      case 'whitelist_phonenumber':
        return Provider.of<AppState>(context, listen: false)
            .whitelistService
            .getEntryByPhoneNumber(value);

      case 'allowed_phonenumber':
        return Provider.of<AppState>(context, listen: false)
            .allowedService
            .getEntryByPhoneNumber(value);
      case 'blocked_phonenumber':
        return Provider.of<AppState>(context, listen: false)
            .blockedService
            .getEntryByPhoneNumber(value);
      case 'label_calls':
        return Provider.of<AppState>(context, listen: false)
            .labelService
            .getEntryByPhoneNumber(value);

      case 'sms_blacklisted':
        return Provider.of<AppState>(context, listen: false)
            .smsBlacklistService
            .getEntryByPhoneNumber(value);
      case 'sms_whitelisted':
        return Provider.of<AppState>(context, listen: false)
            .smsWhitelistService
            .getEntryByPhoneNumber(value);
      case 'sms_text_blacklisted':
        return Provider.of<AppState>(context, listen: false)
            .smsTextBlacklistService
            .getEntryByKeyword(value);
      case 'sms_text_whitelisted':
        return Provider.of<AppState>(context, listen: false)
            .smsTextWhitelistService
            .getEntryByKeyword(value);

      default:
        return null; // 在找不到匹配的表名时返回 null
    }
  }

  Future<CallerIdData> generateCallerIdData(String phoneNumber,
      [String? countryCode]) async {
    print("CallerIdMonitorService: 收到 incoming call: $phoneNumber");

    // 解析号码 (使用提取出的函数)

    final parsedData = countryCode != null
        ? await parsePhoneNumberWithIso(
            phoneNumber, countryCode) // 使用传入的 countryCode 解析
        : await parsePhoneNumberWithoutIso(phoneNumber, null); // 使用默认逻辑解析

    print("通用页: 收到 incoming call: $countryCode");

    final countryCodeFromParsedData = parsedData['countryCode']!;
    final e164Number = parsedData['e164Number']!;

    // 使用 Provider 获取当前的 Locale
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    final currentLocale = localeProvider.locale;

    final languageCode = currentLocale.languageCode.split('_')[0];

    // 创建 dlibphonenumber 的 Locale
    final dlibLocale = dlibphone.Locale(
      language: languageCode,
      country: (countryCodeFromParsedData).toUpperCase(), // 使用 toUpperCase() 方法
    );

    final appState = Provider.of<AppState>(context, listen: false);
    final callerIdService = appState.callerIdService;

    CallerIdData callerIdData =
        await callerIdService.getCallerId(e164Number, context, dlibLocale);
    print("通用页:  ${callerIdData.region}");
    return callerIdData;
  }

/*
  Future<CallerIdData> generateCallerIdData(String phoneNumber) async {
    print("CallerIdMonitorService: 收到 incoming call: $phoneNumber");

  // 解析号码 (使用提取出的函数)
    final parsedData = await parsePhoneNumber(phoneNumber);
    final countryCode = parsedData['countryCode']!;
    final e164Number = parsedData['e164Number']!;
    // 使用 Provider 获取当前的 Locale
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    final currentLocale = localeProvider.locale;

    final languageCode = currentLocale.languageCode.split('_')[0];

    // 创建 dlibphonenumber 的 Locale
    final dlibLocale = dlibphone.Locale(
      language: languageCode,
      // country: countryCode ?? '', // 使用解析出的国家代码
      country: (countryCode).toUpperCase(), // 使用 toUpperCase() 方法
    );

  final appState = Provider.of<AppState>(context, listen: false);
  final callerIdService = appState.callerIdService;

    CallerIdData callerIdData =
        await callerIdService.getCallerId(e164Number, context, dlibLocale);

      return callerIdData;


  }
*/
}
