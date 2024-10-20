import 'dart:convert';
import 'dart:io';

import 'package:call_log/call_log.dart';
import 'package:dlibphonenumber/dlibphonenumber.dart';
import 'package:dlibphonenumber/locale.dart' as dlibphone;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:yourcallyourrule/views/public/label_translation_extension.dart';

import '../../generated/l10n.dart';
import '../../new_set_icons.dart';
import '../../screens/appstate_provider.dart';

import '../../services/allowed_blocked_service.dart';
import '../../services/caller_id_service.dart';

import '../../services/label_service.dart';
import '../../utils/ad_manager.dart';
import '../../utils/ad_state.dart';
import '../../utils/avatar_edit_dialog.dart';
import '../../utils/parse_phonenumber.dart';
import '../../utils/language_provider.dart';
import '../../widgets/adwidgets/native_ads.dart';
import '../../widgets/google_ad.dart';
import '../../widgets/self_managed_search_bar.dart';
import '../contact/contact_form_page.dart';
import '../label/add_label.dart';

import '../public/public_select_label.dart';
import '../shield_switch_style.dart';
import '../subpage_style.dart';

class CallHistoryPage extends StatefulWidget {
  final String? phoneNumber; // 添加号码参数
  const CallHistoryPage({super.key, this.phoneNumber});

  @override
  CallHistoryPageState createState() => CallHistoryPageState();
}

class CallHistoryPageState extends State<CallHistoryPage> {
  late AllowedService _allowedService;
  late BlockedService _blockedService;
  List<CallLogEntry> _callLogEntry = [];
  Map<String, CallerIdData> _callerIdDataCache = {};
  late CallerIdService _callerIdService;
  Map<String, bool> _expandedItems = {};
  bool _isAllowed = false;
  bool _isBlocked = false;
  bool _isContactButtonVisible = true;
  bool _isContactIconButtonVisible = true;
  late LabelService _labelService;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _initializeServices();
    _loadPreferences();
    //  _checkPermissionAndFetchLogs(); // 在 initState 中直接调用
//整合参数传递搜索
    if (widget.phoneNumber != null) {
      _filterCallLogsByPhoneNumber(widget.phoneNumber!);
    } else {
      _checkPermissionAndFetchLogs();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _checkPermissionAndFetchLogs() async {
    final status = await Permission.phone.status;
    if (status.isGranted) {
      _fetchCallLogs();
    } else if (status.isDenied) {
      _requestPhonePermission();
    }
  }

  void _initializeServices() {
    final appState = Provider.of<AppState>(context, listen: false);
    _labelService = appState.labelService;
    _callerIdService = appState.callerIdService;
    _allowedService = appState.allowedService;
    _blockedService = appState.blockedService;
  }

//请求权限
  Future<void> _requestPhonePermission() async {
    PermissionStatus status = await Permission.phone.request();

    if (status.isGranted) {
      // 显示 Snackbar 提示用户
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context).permissionGranted),
        ),
      );
    } else if (status.isDenied) {
      // 权限被拒绝，显示 Snackbar 并再次请求权限
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              S.of(context).thisAppNeedsAccessToYourCallLogInformation),
          action: SnackBarAction(
            label: S.of(context).grantPermission,
            onPressed: () async {
              PermissionStatus status = await Permission.contacts.request();
              if (status.isGranted) {
                // 显示 Snackbar 提示用户
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(S.of(context).permissionGranted),
                  ),
                );
              } else {
                // 再次拒绝，引导用户手动开启
                await openAppSettings();
                // 再次拒绝，显示 Snackbar 提示用户可以在设置中手动开启
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(S.of(context).deniedPermissionCanManuallyEnablePermissionInSetting),
                  ),
                );
              }
            },
          ),
        ),
      );
    } else if (status.isPermanentlyDenied) {
      // 权限被永久拒绝，显示 Snackbar 提示用户可以在设置中手动开启
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              S.of(context).deniedPermissionCanManuallyEnablePermissionInSetting),
        ),
      );
    }
  }

//创建允许或者阻止开关
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


  Future<void> _loadPreferences() async {
    final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
    _isContactButtonVisible =
        await asyncPrefs.getBool('isContactButtonVisible') ?? true;
    _isContactIconButtonVisible =
        await asyncPrefs.getBool('isContactIconButtonVisible') ?? true;
    //setState(() {});
  }

  //获取通话记录
  Future<void> _fetchCallLogs() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final Iterable<CallLogEntry> result = await CallLog.get();
      final newCallLogEntry = result.toList();

      // 2. 检查通话记录是否有变化
      if (newCallLogEntry.length != _callLogEntry.length ||
          newCallLogEntry.toString() != _callLogEntry.toString()) {
        // 检查长度和内容是否相同
        setState(() {
          _callLogEntry = newCallLogEntry;
        });

        // 3. 预加载所有 CallerIdData
        await _preloadCallerIdData();
      }
    } catch (e) {
      //print('Error loading call logs: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }


//整合参数传递搜索
  Future<void> _filterCallLogsByPhoneNumber(String phoneNumber) async {
    if (_isLoading) return;

    PermissionStatus status = await Permission.phone.status;
    if (status.isGranted) {
      final Iterable<CallLogEntry> result = await CallLog.get();
      final newCallLogEntry = result.toList();

      setState(() {
        _isLoading = true;
        _callLogEntry = newCallLogEntry
            .where((entry) => entry.number == phoneNumber)
            .toList();
      });

      await _preloadCallerIdData();

      setState(() {
        _isLoading = false;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).callLogPermissionDenied)),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _preloadCallerIdData() async {
    // 1. 从本地文件加载缓存数据
    await _loadCachedCallerIdData();

    // 2. 预加载所有 CallerIdData (如果缓存中不存在)
    for (var i = 0; i < _callLogEntry.length; i++) {
      final entry = _callLogEntry[i];
      if (!_callerIdDataCache.containsKey(entry.number)) {
        _callerIdDataCache[entry.number ?? ''] =
            await getCallerIdData(entry, context);
      }
    }

    // 3. 保存更新后的缓存数据到本地文件
    await _saveCachedCallerIdData();
  }

  // 异步加载 CallerIdData，但不触发整个页面的刷新
  Future<void> _loadCallerIdData(CallLogEntry entry) async {
    if (!_callerIdDataCache.containsKey(entry.number)) {
      final callerIdData = await getCallerIdData(entry, context);
      _callerIdDataCache[entry.number ?? ''] = callerIdData;
      await _saveCachedCallerIdData(); // 保存更新后的缓存数据
    }
  }

  Future<CallerIdData> getCallerIdData(
      CallLogEntry entry, BuildContext context) async {
    String? phoneNumber = entry.number ?? '';

    // 解析号码 (使用提取出的函数)
    Map<String, String> parsedData = await parsePhoneNumber(entry.number!);
    String countryCode = parsedData['countryCode']!;
    String e164Number = parsedData['e164Number']!;

    // 使用 Provider 获取当前的 Locale
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    final currentLocale = localeProvider.locale;

    final languageCode = currentLocale.languageCode;

    // 创建 dlibphonenumber 的 Locale
    final dlibLocale = dlibphone.Locale(
      language: languageCode,
      // country: countryCode ?? '', // 使用解析出的国家代码
      country: (countryCode).toUpperCase(), // 使用 toUpperCase() 方法
    );

    final appState = Provider.of<AppState>(context, listen: false);

    _callerIdService = appState.callerIdService;

    // 检查 phoneNumber 是否为空
    if (phoneNumber.isEmpty) {
      return CallerIdData(
        phoneNumber: 'Unknown', // 或其他你认为合适的默认值
        countryName: 'Unknown',
        region: 'Unknown',
        carrier: 'Unknown',
        numberType: PhoneNumberType.unknown,
        labels: [Label(label: 'Unknown')],
        name: 'OtherUnknown',
        avatar: 'Unknown',
        count: 0,
      );
    }

    // 检查缓存
    if (_callerIdDataCache.containsKey(phoneNumber)) {
      return _callerIdDataCache[phoneNumber]!;
    }

    // 如果缓存中不存在数据，则查询数据库
    try {
      CallerIdData callerIdData =
          await _callerIdService.getCallerId(e164Number, dlibLocale);
      // 将查询结果存储到缓存中
      _callerIdDataCache[phoneNumber] = callerIdData;
      _saveCachedCallerIdData(); // 保存更新后的数据

      return callerIdData;
    } catch (error) {
      return CallerIdData(
        phoneNumber: phoneNumber,
        countryName: 'locationOther',
        labels: [Label(label: 'Other')],
        name: 'OtherUnknown',
      );
    }
  }

// 保存缓存数据到本地文件
  Future<void> _saveCachedCallerIdData() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/caller_id_cache.json');
    final jsonData = jsonEncode(_callerIdDataCache);
    await file.writeAsString(jsonData);
  }

// 从本地文件加载缓存数据
  Future<void> _loadCachedCallerIdData() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/caller_id_cache.json');
    if (await file.exists()) {
      final jsonData = await file.readAsString();
      _callerIdDataCache = (jsonDecode(jsonData) as Map<String, dynamic>)
          .map((key, value) => MapEntry(key, CallerIdData.fromJson(value)));
    }
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
      body: RefreshIndicator(
        onRefresh: _fetchCallLogs,
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            // : _build(context),
            : AdvancedSelfManagedSearchBar<CallLogEntry>(
                items: _callLogEntry,
                itemBuilder: (context, entry, width) =>
                    _buildCallLogItem(entry, width),
                getSearchString: (entry) =>
                    '${entry.timestamp} ${entry.number} ${entry.name}',
                getSortFields: (entry) => ['Label', 'Phone Number', 'Name'],
                getSortFieldValues: (entry) =>
                    [entry.timestamp, entry.number, entry.name],
                originalBuilder: (context, items) => _build(context),
                //adBuilder: (width, height) => nativeAdWidgetSmall(adWidth: width, adHeight: height),
              ),
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


  // 私有的构建订阅列表方法
  Widget _build(BuildContext context) {
    final adState = Provider.of<AdState>(context);
    return OrientationBuilder(
      builder: (context, orientation) {
        final mediaQuery = MediaQuery.of(context);

        // 根据屏幕方向和宽度设置每行卡片数
        final int entriesPerRow = orientation == Orientation.portrait
            ? (mediaQuery.size.width > 900 ? 2 : 1)
            : (mediaQuery.size.width > 1000 ? 4 : 2);

        // 根据屏幕宽度设置水平 padding
        final double functionEntryHorizontalPadding =
            mediaQuery.size.width > 900 ? 24.0 : 9.0;

        // 计算卡片宽度
        final double entryWidth = (mediaQuery.size.width -
                2 * functionEntryHorizontalPadding -
                (entriesPerRow - 1) * 10) /
            entriesPerRow;
        return ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: functionEntryHorizontalPadding,
              ),
              child: Wrap(
                spacing: 5,
                runSpacing: 5,
                alignment: WrapAlignment.spaceBetween,
                // 使用 adState.isAdEnabled
                children: List.generate(
                    _callLogEntry.length +
                        (adState.isAdEnabled ? _callLogEntry.length ~/ 3 : 0),
                    (index) {
                  if ((index + 1) % 4 == 0 && adState.isAdEnabled) {
                    return nativeAdWidgetSmall(
                        adWidth: entryWidth, adHeight: 90);
                  } else {
                    final adjustedIndex = index - (index ~/ 4);
                    final callLogEntry =
                        _callLogEntry[adjustedIndex]; // 获取当前 CallLogEntry
                    return SizedBox(
                      width: entryWidth,
                      child: _buildCallLogItem(
                          callLogEntry, entryWidth), // 传递 CallerIdData
                    );
                  }
                }),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCallLogItem(CallLogEntry entry, double entryWidth) {
    final callerIdData = _callerIdDataCache[entry.number ?? ''];

    if (callerIdData == null) {
      // 如果 CallerIdData 还没有加载，显示一个简单的占位符并触发加载
      _loadCallerIdData(entry);
      return Card(
        child: ListTile(
          title: Text(entry.number ?? S.of(context).unknown),
          subtitle: Text(S.of(context).loading),
        ),
      );
    }
    return Card(
        color: const Color.fromARGB(255, 251, 251, 251), // 设置背景色为浅灰色
        margin: const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
        child: ExpansionTile(
          tilePadding:
              const EdgeInsets.symmetric(vertical: 10.0), // 增加顶部和底部 padding
          key: ValueKey(callerIdData.phoneNumber),
          initiallyExpanded: _expandedItems[callerIdData.phoneNumber] ?? false,
          onExpansionChanged: (isExpanded) {
            // setState(() {
            _expandedItems[callerIdData.phoneNumber] = isExpanded;
            //  });
          },
          leading: Container(
            margin: const EdgeInsets.only(left: 0.0), // 设置左侧 margin 为 16.0
            width: 80.0,
            height: 80.0,
            // clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.green,
                width: 2.0,
              ),
              image: DecorationImage(
                alignment: Alignment.center,
                image: callerIdData.avatarImage,
                fit: BoxFit.contain,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4), // 调整 padding 来控制圆圈大小
                    decoration: const BoxDecoration(
                      color: Colors.yellow, // 设置圆圈颜色为黄色
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
                        callerIdData.labels.first.label.translate(context), // 使用 translate 方法
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
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ContactFormPage(),
                    ),
                  ),
                ),
              const SizedBox(width: 8),
              Icon(_expandedItems[callerIdData.phoneNumber] == true
                  ? Icons.expand_less
                  : Icons.expand_more),
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

    // 显示更多选项的逻辑
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Divider
          const Divider(height: 1),
          const SizedBox(height: 10),

          // Avatar Editing Section
          Row(
            children: [
              Text(S.of(context).chooseAvatarLocalOrNetwork),
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) => AvatarEditDialog(
                    avatarController: avatarController,
                    onAvatarChanged: (newAvatarPath) {
                      setState(() {
                        callerIdData.avatar = newAvatarPath;
                        avatarController.text = newAvatarPath;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          TextFormField(
            controller: avatarController,
            decoration:
                InputDecoration(labelText: S.of(context).avatarUrlOrPath),
          ),

          const Divider(height: 1),
          const SizedBox(height: 10),
          // Blacklist/Whitelist options with adjusted padding
          Row(
            mainAxisSize: MainAxisSize.min, // 添加了 mainAxisSize
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // allowed switch on the left
              Expanded(
                // 或 Flexible
                child: Theme(
                  data: shieldSwitchThemeData,
                  child: SwitchListTile(
                    contentPadding: const EdgeInsets.only(top: 16, left: 16),
                    value: _isAllowed,
                    onChanged: _onSwitchChanged,
                    title: Text(
                      _isAllowed
                          ? S.of(context).addToAllowed
                          : S.of(context).removeAllowed,
                      style: whiteTextStyle,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // blocked switch on the right
              Expanded(
                // 或 Flexible
                child: Theme(
                  data: shieldSwitchThemeData,
                  child: SwitchListTile(
                    contentPadding: const EdgeInsets.only(top: 16, right: 16),
                    value: _isBlocked,
                    onChanged: (value) => _onSwitchChanged(!value),
                    title: Text(
                      _isBlocked
                          ? S.of(context).addToBlocked
                          : S.of(context).removeBlocked,
                      style: whiteTextStyle,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Divider(),
          // Stateful widget to manage Entry name and label

        Labels(
          initialLabel: callerIdData.labels.first.label,
          phoneNumber: callerIdData.phoneNumber,
          onLabelChanged: (newLabel) {
            setState(() {
              callerIdData.labels.first.label = newLabel;
            });
          },
          selectLabelService: ListServiceAdapter(
              Provider.of<AppState>(context, listen: false).labelService),
        ),


          const GoogleAdWidget(adInfo: AdManager.bannerAd),
          const Divider(),

          Row(
            //按钮最小均分
            mainAxisSize: MainAxisSize.min, // 让按钮最小
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // 让按钮左右对齐
            children: [
              if (_isContactButtonVisible)
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.person_add),
                    label: Text(S.of(context).addContact),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ContactFormPage()),
                    ),
                  ),
                ),

              const SizedBox(width: 16.0), // Spacing between buttons
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: TextFormField(
                    controller: nameController,
                    decoration: showmoreinputBoxDecoration.copyWith(
                      labelText: S.of(context).name,
                      border: const OutlineInputBorder(),
                      labelStyle: showmoreTextStyle,
                    ),
                    style: showmoreTextStyle,
                  ),
                ),
              ),

              const SizedBox(width: 16.0), // Spacing between buttons
              ElevatedButton(
                onPressed: () async {
                  final updatedEntry = LabeledEntry(
                    phoneNumber: callerIdData.phoneNumber,
                                        label: callerIdData.labels.first.label,
                    name: nameController.text,
                    avatar: avatarController
                        .text, // Use the avatarController's value

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


                  await _labelService.addOrUpdate(
                      updatedEntry); // Update database with updated entry
                  if (_isAllowed) {
                    await _allowedService.addOrUpdate(allowedEntry);
        await _blockedService.remove(blockedEntry);
                  } else if (_isBlocked) {
                    await _blockedService.addOrUpdate(blockedEntry);
    await _allowedService.remove(allowedEntry);
                  }
                  await _fetchCallLogs();
                  // Additional action after saving (optional)
                  setState(() {
                    _expandedItems[callerIdData.phoneNumber] = false;
                  });
                },
                style: showmoreButtonStyle,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center, // 按钮内容居中对齐
                  children: [
                    const Icon(NewSet.check),
                    const SizedBox(width: 8.0),
                    Text(
                     S.of(context).save,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getCallTypeIcon(CallType? callType) {
    switch (callType) {
      case CallType.incoming:
        return Icons.call_received;
      case CallType.outgoing:
        return Icons.call_made;
      case CallType.missed:
        return Icons.call_missed;
      case CallType.rejected: // 添加拒接电话的处理
        return NewSet.phone_rejected; // 或者你希望显示的其他图标
      default:
        return Icons.call;
    }
  }

  Color _getCallTypeColor(CallType? callType) {
    return callType == CallType.missed ? Colors.red : Colors.green;
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
}
