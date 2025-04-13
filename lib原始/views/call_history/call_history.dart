import 'dart:async';
import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../generated/l10n.dart';
import '../../new_set_icons.dart';
import '../../screens/appstate_provider.dart';
import '../../services/allowed_blocked_service.dart';
import '../../services/caller_id_service.dart';
import '../../services/label_service.dart';
import '../../utils/ad_manager.dart';
import '../../utils/ad_state.dart';

import '../../views/public/label_translation_extension.dart';

import '../../widgets/google_ad.dart';
import '../../widgets/self_managed_search_bar.dart';
import '../contact/contact_form_page.dart';
import '../label/add_label.dart';
import '../public/isolated_widgets.dart';
import '../public/public_select_label.dart';
import '../public/responsive_grid_list.dart';

import '../subpage_style.dart';
import 'call_log_database.dart';
import 'call_log_manager.dart';
import 'call_log_searchsar_wrapper.dart';

class CallHistoryPage extends StatefulWidget {
  final String? phoneNumber;
  const CallHistoryPage({super.key, this.phoneNumber});

  @override
  CallHistoryPageState createState() => CallHistoryPageState();
}

class CallHistoryPageState extends State<CallHistoryPage> {
  late CallLogManager _callLogManager;
  late bool _isContactButtonVisible;
  late bool _isContactIconButtonVisible;
  List<CallLogEntry> callLogEntry = [];

  Map<String, bool> expandedItem = {};

  late AllowedService _allowedService;
  late BlockedService _blockedService;
  late LabelService _labelService;

  bool _isAllowed = false;
  bool _isBlocked = false;

  @override
  void initState() {
    super.initState();
    final appState = Provider.of<AppState>(context, listen: false);
    _callLogManager = CallLogManager(context, appState.callerIdService);
    _initializeServices();
    _loadPreferences();

    if (widget.phoneNumber != null) {
      _callLogManager.filterByPhoneNumber(widget.phoneNumber!);
    }
  }

  @override
  void dispose() {
    _callLogManager.dispose();
    super.dispose();
  }

  void _initializeServices() {
    final appState = Provider.of<AppState>(context, listen: false);
    _labelService = appState.labelService;

    _allowedService = appState.allowedService;
    _blockedService = appState.blockedService;
  }

  Future<void> _loadPreferences() async {
    final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
    _isContactButtonVisible =
        await asyncPrefs.getBool('isContactButtonVisible') ?? true;
    _isContactIconButtonVisible =
        await asyncPrefs.getBool('isContactIconButtonVisible') ?? true;
  }

//创建允许或者阻止开关
  void _onSwitchChanged(bool newValue) {
   // setState(() {
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
  //  });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).callHistory),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => _showSettingsDialog(),
          ),
        ],
      ),
      body: StreamBuilder<List<CallLogEntry>>(
        stream: _callLogManager.callLogsStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            // 调试日志
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          return RefreshIndicator(
            onRefresh: () async {
              // 调试日志
              await _callLogManager.refresh();
            },
            child: (snapshot.hasData && snapshot.data!.isNotEmpty)
                ? _buildCallLogSearchBar(snapshot.data!)
                : Center(child: Text(S.of(context).noDataAvailable)),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddLabelPageView()),
        ),
      ),
    );
  }

  Widget _buildCallLogSearchBar(List<CallLogEntry> callLogs) {
    return CallLogSearchBarWrapper(
      callLogs: callLogs,
      builder: (context, logs) => AdvancedSelfManagedSearchBar<CallLogEntry>(
        items: logs,
        itemBuilder: (context, entry, width) => _buildCallLogItem(entry, width),
        getSearchString: (entry) =>
            '${entry.timestamp} ${entry.number} ${entry.id}',
        getSortFields: (entry) => ['Time', 'Phone Number', 'ID'],
        getSortFieldValues: (entry) =>
            [entry.timestamp, entry.number, entry.id],
        originalBuilder: (context, items) => _build(context),
      ),
    );
  }

  Widget _buildCallLogItem(CallLogEntry entry, double width) {
       final phoneNumber = entry.number;




    final callerIdData = _callLogManager.callerIdCache[phoneNumber];

    if (callerIdData != null) {
      return _buildCallLogCard(entry, callerIdData);
    }

    return FutureBuilder<CallerIdData>(
      future: _callLogManager.getCallerIdData(entry),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return _buildCallLogCard(entry, snapshot.data!);
        }
        return Card(
          child: ListTile(
            title: Text(entry.number ?? S.of(context).unknown),
            subtitle: Text(S.of(context).loading),
          ),
        );
      },
    );
  }

// 私有的构建订阅列表方法
  Widget _build(BuildContext context) {
    final adState = Provider.of<AdState>(context);
    return buildResponsiveGridList(
        callLogEntry, _buildCallLogItem, adState.isAdEnabled);
  }

// 构建 Card 和 ExpansionTile
  Widget _buildCallLogCard(CallLogEntry entry, CallerIdData callerIdData) {
    return Card(
        color: const Color.fromARGB(255, 251, 251, 251), // 设置背景色为浅灰色
        margin: const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
        child: ExpansionTile(
          tilePadding:
              const EdgeInsets.symmetric(vertical: 10.0), // 增加顶部和底部 padding
          key: ValueKey(entry.number),
          initiallyExpanded: expandedItem[entry.number] ?? false,
          onExpansionChanged: (isExpanded) {
          //  setState(() {
              expandedItem[entry.number!] = isExpanded;
          //  });
          },
          leading: Stack(
            children: [
              AvatarWidget(
                avatar: callerIdData.avatar,
                label: callerIdData.labels.first.label,
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(4), // 调整 padding 来控制圆圈大小
                  decoration: const BoxDecoration(
                    color: Color(0xFFA8DF8E), // 设置圆圈颜色为黄色
                    shape: BoxShape.circle, // 设置形状为圆形
                  ),
                  child: Icon(
                    _getCallTypeIcon(entry.callType),
                    size: 16,
                    color: _getCallTypeColor(entry.callType),
                  ),
                ),
              ),
            ],
          ),

          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                entry.number!,
                style: entryTitleStyle,
                // overflow: TextOverflow.ellipsis,
                maxLines: 1, // 允许换行
              ),
              Text(
                '${callerIdData.countryName}, ${callerIdData.region ?? ''}, ${callerIdData.carrier ?? ''}',
                style: entryLocationStyle,
                // overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                //callerIdData.name,
                callerIdData.name == "Unknown"
                    ? '${S.of(context).name}: ${S.of(context).unknown}'
                    : '${S.of(context).name}: ${callerIdData.name}',

                style: entryNameStyle,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    formatCallLogTimestamp(entry.timestamp!),
                    style: entryTimeStyle,
                  ),
                ],
              ),
            ],
          ),

          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (callerIdData.labels.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(147, 203, 128, 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        callerIdData.labels.first.label
                            .translate(context), // 使用 translate 方法
                        style: entryLabelStyle,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  const SizedBox(width: 5.0),
                  Container(
                    // 将第二个 Text 包裹在 Container 中
                    padding: const EdgeInsets.symmetric(
                        horizontal: 4, vertical: 4), // 可选：添加 padding
                    decoration: BoxDecoration(
                      color: Colors.grey[200], // 设置背景色，例如浅灰色
                      borderRadius: BorderRadius.circular(8), // 可选：添加圆角
                    ),
                    child: Text(
                      'SIM:${entry.simDisplayName}',
                      style: entryTimeStyle,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 3.0),
              if (_isContactIconButtonVisible)
                IconButton(
                  icon: const Icon(Icons.person_add),
                  color: Colors.cyan,
                  onPressed: () =>
                      _addContact(context, callerIdData.phoneNumber),
                ),
              const SizedBox(width: 8),
              ExpansionIconWidget(
                  isExpanded:
                      expandedItem[callerIdData.phoneNumber] ?? false),
            ],
          ),
          children: [
            _buildExpandedContent(context, callerIdData),
          ],
        ));
  }

  Widget _buildExpandedContent(
      BuildContext context, CallerIdData callerIdData) {
    final TextEditingController nameController =
        TextEditingController(text: callerIdData.name);
    //新增加的avatar 路径
    final TextEditingController avatarController =
        TextEditingController(text: callerIdData.avatar);

    //新增加的label 路径
    final TextEditingController labelController =
        TextEditingController(text: callerIdData.labels.first.label);

    // 显示更多选项的逻辑
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Divider
          const Divider(height: 1),
          const SizedBox(height: 10),

          AvatarEditSectionWidget(
            avatar: avatarController.text,
            label: callerIdData.labels.first.label,
            onAvatarChanged: (newAvatarPath) {
              //    setState(() {
              avatarController.text = newAvatarPath;
              //   });
            },
          ),

          const SizedBox(height: 16),
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
            initialLabel: labelController.text,
            //   phoneNumber: callerIdData.phoneNumber,
            onLabelChanged: (newLabel) {
              // setState(() {
              labelController.text = newLabel;
              //  });
            },
            selectLabelService: ListServiceAdapter(
                Provider.of<AppState>(context, listen: false).labelService),
          ),

          const GoogleAdWidget(adInfo: AdManager.bannerAd),
          const Divider(),

          Row(
            mainAxisSize: MainAxisSize.min, // 让按钮最小
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (_isContactButtonVisible)
                ActionButtonWidget(
                  icon: Icons.person_add,
                  label: S.of(context).addContact,
                  onPressed: () =>
                      _addContact(context, callerIdData.phoneNumber),
                ),
              Expanded(child: NameInputWidget(nameController: nameController)),
              const SizedBox(width: 16),
              ActionButtonWidget(
                icon: NewSet.check,
                label: S.of(context).save,
                onPressed: () => _saveEntry(
                    callerIdData,
                    nameController.text,
                    avatarController.text,
                    labelController.text,
                    _isAllowed,
                    _isBlocked),
                    
              ),
            ],
          ),
        ],
      ),
    );
  }

IconData _getCallTypeIcon(String? callType) {
  switch (callType) {
    case 'incoming':
      return Icons.call_received;
    case 'outgoing':
      return Icons.call_made;
    case 'missed':
      return Icons.call_missed_outgoing;
    case 'rejected':
      return Icons.phone_disabled;
    case 'blocked':
      return Icons.block;
    default:
      return Icons.call; // Default icon for unknown call types or null values
  }
}

Color _getCallTypeColor(String? callType) {
  switch (callType) {
    case 'missed':
      return Colors.red;
    case 'rejected':
      return Colors.redAccent;
    case 'blocked':
      return Colors.grey;    
    case 'incoming':
    case 'outgoing':
      return Colors.green;
    default:
      return Colors.black; // Default color for unknown call types or null values
  }
}

  void _showSettingsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(S.of(context).settings),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SwitchListTile(
                    title: Text(S.of(context).showContactButton),
                    value: _isContactButtonVisible,
                    onChanged: (bool value) {
                      setState(() {
                        _isContactButtonVisible = value;
                      });
                      _savePreferences();
                    },
                  ),
                  SwitchListTile(
                    title: Text(S.of(context).showContactIconButton),
                    value: _isContactIconButtonVisible,
                    onChanged: (bool value) {
                      setState(() {
                        _isContactIconButtonVisible = value;
                      });
                      _savePreferences();
                    },
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              child: Text(S.of(context).close),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  Future<void> _savePreferences() async {
    final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
    await asyncPrefs.setBool('isContactButtonVisible', _isContactButtonVisible);
    await asyncPrefs.setBool(
        'isContactIconButtonVisible', _isContactIconButtonVisible);
  }

  // 函数：将 CallLog 条目的 timestamp 转换为格式化的时间字符串
  String formatCallLogTimestamp(int timestamp) {
    // 使用 DateTime.fromMillisecondsSinceEpoch 转换为 DateTime 对象
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);

    // 使用 DateFormat 格式化时间
    String formattedDate = DateFormat('MM/dd HH:mm').format(dateTime);

    return formattedDate;
  }

// contactdPage
  void _addContact(BuildContext context, phonenumber) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ContactFormPage(initialPhoneNumber: phonenumber), // 去掉 const
      ),
    );
  }

  void _saveEntry(CallerIdData callerIdData, String name, String avatar,
      String label, bool isAllowed, bool isBlocked) async {
    // 添加 isAllowed 和 isBlocked 参数
    final updatedEntry = LabeledEntry(
      phoneNumber: callerIdData.phoneNumber,
      label: label,
      name: name,
      avatar: avatar,
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

// 想更新 phoneNumber 的记录的 name 和 avatar 字段
    final fieldsToUpdate = {
      'name': name, // 直接使用传入的 name 字符串
      'avatar': avatar, // 直接使用传入的 avatar 字符串
      'labels': jsonEncode([
        {'label': label, 'type': 0}
      ]), // 将 label 字符串转换为 JSON 字符串
    };

    await CallScreeningDatabase.instance
        .updateCallerIdDataByFields(callerIdData.phoneNumber, fieldsToUpdate);
    // 添加 print 语句

    await _labelService
        .addOrUpdate(updatedEntry); // Update database with updated entry

    if (isAllowed) {
      // 使用传递的 isAllowed
      await _allowedService.addOrUpdate(allowedEntry);
      await _blockedService.remove(blockedEntry);
    } else if (isBlocked) {
      // 使用传递的 isBlocked
      await _blockedService.addOrUpdate(blockedEntry);
      await _allowedService.remove(allowedEntry);
    }
    // await _loadEntries();

    setState(() {
      expandedItem[callerIdData.phoneNumber] = false;
    });
    await _callLogManager.loadAllCallLogs();
  }

  //结束
}

