import 'package:call_log/call_log.dart';
import 'package:dlibphonenumber/dlibphonenumber.dart';
import 'package:dlibphonenumber/locale.dart' as dlibphone;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
//import 'package:path/path.dart' as path_helper;
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sim_card_info/sim_card_info.dart';
import 'package:sim_card_info/sim_info.dart';

import '../../new_set_icons.dart';
import '../../screens/appstate_provider.dart';

import '../../services/allowed_blocked_service.dart';
import '../../services/caller_id_service.dart';

import '../../services/label_service.dart';
import '../../utils/ad_manager.dart';
import '../../utils/ad_state.dart';
import '../../utils/avatar_edit_dialog.dart';
import '../../utils/language_provider.dart';
import '../../widgets/adwidgets/native_ads.dart';
import '../../widgets/google_ad.dart';
import '../contact/contact_form_page.dart';
import '../label/add_label.dart';
import '../shield_switch_style.dart';
import '../subpage_style.dart';

/*
// 获取第三方库的Locale对象
Locale getDlibPhoneNumberLocale(BuildContext context) {
  var currentLocale = Localizations.localeOf(context);
  var countryCode = currentLocale.countryCode ?? ''; // 使用空值合并操作符提供一个默认值
  return Locale(language: currentLocale.languageCode, country: countryCode);
}
*/
class CallHistoryPage extends StatefulWidget {
  const CallHistoryPage({super.key});

  @override
  _CallHistoryPageState createState() => _CallHistoryPageState();
}

class _CallHistoryPageState extends State<CallHistoryPage> with WidgetsBindingObserver {
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
    bool _isFirstLoad = true;
/*
  @override
  void initState() {
    super.initState();
    _initServices();
    _loadPreferences();
    _fetchCallLogs();
  }
*/

  @override
  void initState() {
    super.initState();
    final appState = Provider.of<AppState>(context, listen: false);
    _labelService = appState.labelService;
    _callerIdService = appState.callerIdService;
    _allowedService = appState.allowedService;
    _blockedService = appState.blockedService;
  _loadPreferences();
  WidgetsBinding.instance.addObserver(this);
 /* 
  // Delay fetching call logs
    if (_isFirstLoad) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _checkPermissionAndFetchLogs();
      });
      _isFirstLoad = false;
    }
*/
_handleFirstLoad();
  }

@override
void dispose() {
  WidgetsBinding.instance.removeObserver(this);
  super.dispose();
}

@override
void didChangeAppLifecycleState(AppLifecycleState state) {
  if (state == AppLifecycleState.resumed) {
    _fetchCallLogs(); // 在应用从后台回到前台时重新获取通话记录
  }
}

  void _handleFirstLoad() {
    if (_isFirstLoad) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _checkPermissionAndFetchLogs();
      });
      setState(() {
        _isFirstLoad = false;
      });
    }
  }

Future<void> _checkPermissionAndFetchLogs() async {
  final status = await Permission.phone.status;
  if (status.isGranted) {
    _fetchCallLogs();
  } else if (status.isDenied) {
    _requestPhonePermission();
  }
}

//请求权限
  Future<void> _requestPhonePermission() async {
    PermissionStatus status = await Permission.phone.request();

    if (status.isGranted) {
      // 显示 Snackbar 提示用户
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('您已授权权限'),
        ),
      );
    } else if (status.isDenied) {
      // 权限被拒绝，显示 Snackbar 并再次请求权限
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('此应用需要访问您的通话记录信息才能正常工作。请授予权限。'),
          action: SnackBarAction(
            label: '授予权限',
            onPressed: () async {
              PermissionStatus status = await Permission.contacts.request();
              if (status.isGranted) {
                // 显示 Snackbar 提示用户
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('您已授权权限'),
                  ),
                );
              } else {
                // 再次拒绝，引导用户手动开启
                await openAppSettings();
                // 再次拒绝，显示 Snackbar 提示用户可以在设置中手动开启
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('您已拒绝权限。您可以在设置中手动开启权限。'),
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
        const SnackBar(
          content: Text('您已永久拒绝权限。您可以在设置中手动开启权限。'),
        ),
      );
    }
  }

//创建允许或者阻止开关
  void _onSwitchChanged(bool newValue) {
    setState(() {
      if (_isAllowed == newValue) {
        // 如果允许开关状态与传入的新值相同，说明是重复点击了相同的开关，无需进行任何操作
        return;
      }
      // 更新允许开关状态为传入的新值
      _isAllowed = newValue;
      // 更新阻止开关状态为与允许相反
      _isBlocked = !_isAllowed;
    });
  }
/*
  Future<void> _initServices() async {
    final allowedBlockedDatabase = await openDatabase(
      path_helper.join(await getDatabasesPath(), 'allowed_blocked.db'),
      onCreate: ab.createDatabase,
      version: 1,
    );
    final labelsDatabase = await openDatabase(
      path_helper.join(await getDatabasesPath(), 'labels_database.db'),
      onCreate: la.createDatabase,
      version: 1,
    );
    // 实例化服务
    _labelService = LabelService(labelsDatabase);
    _callerIdService = CallerIdService();
    _allowedService = AllowedService(allowedBlockedDatabase);
    _blockedService = BlockedService(allowedBlockedDatabase);
    await _callerIdService.initialize();
  }
*/

  Future<void> _loadPreferences() async {
    final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
    _isContactButtonVisible =
        await asyncPrefs.getBool('isContactButtonVisible') ?? true;
    _isContactIconButtonVisible =
        await asyncPrefs.getBool('isContactIconButtonVisible') ?? true;
    setState(() {});
  }

  //获取通话记录
  Future<void> _fetchCallLogs() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    PermissionStatus status = await Permission.phone.status;
    if (status.isGranted) {
      final Iterable<CallLogEntry> result = await CallLog.get();
      _callLogEntry = result.toList();
      
      // 预加载部分 CallerIdData
      await _preloadCallerIdData();

      setState(() {
        _isLoading = false;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Call log permission denied')),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }
  Future<void> _preloadCallerIdData() async {
    // 预加载前20个条目的 CallerIdData
    final preloadCount = _callLogEntry.length > 20 ? 20 : _callLogEntry.length;
    for (var i = 0; i < preloadCount; i++) {
      final entry = _callLogEntry[i];
      if (!_callerIdDataCache.containsKey(entry.number)) {
        _callerIdDataCache[entry.number ?? ''] = await getCallerIdData(entry, context);
      }
    }
  }

  // 异步加载 CallerIdData，但不触发整个页面的刷新
  Future<void> _loadCallerIdData(CallLogEntry entry) async {
    if (!_callerIdDataCache.containsKey(entry.number)) {
      final callerIdData = await getCallerIdData(entry, context);
      setState(() {
        _callerIdDataCache[entry.number ?? ''] = callerIdData;
      });
    }
  }


  Future<CallerIdData> getCallerIdData(
      CallLogEntry entry, BuildContext context) async {
    // 1. 初始化 sim_card_info 插件
    final simCardInfoPlugin = SimCardInfo();

    String? phoneNumber = entry.number ?? '';

    // 2. 获取 SIM 卡信息
    List<SimInfo> simInfoList = await simCardInfoPlugin.getSimInfo() ?? [];
    List<String> simCountryCodes =
        simInfoList.map((sim) => sim.countryIso).toList();

    // 3. 尝试解析号码
    PhoneNumberUtil phoneNumberUtil = PhoneNumberUtil.instance;
    String? countryCode;
    PhoneNumber? parsedPhoneNumber;
    String e164Number = "";

    // 判断号码是否包含国际区号
    RegExp internationalPrefixRegex = RegExp(r'^(?:\+|00)');

    if (internationalPrefixRegex.hasMatch(phoneNumber)) {
      // 包含国际区号， 使用 null 解析
      try {
        PhoneNumber parsedPhoneNumber =
            phoneNumberUtil.parse(phoneNumber, null);

        countryCode = phoneNumberUtil.getRegionCodeForNumber(parsedPhoneNumber);
        e164Number =
            phoneNumberUtil.format(parsedPhoneNumber, PhoneNumberFormat.e164);
      } catch (e) {
        // 可以添加额外的错误处理
      }
    } else {
      // 2不包含国际区号， 使用 SIM 卡国家代码循环解析
      for (String simCountryCode in simCountryCodes) {
        try {
          PhoneNumber parsedPhoneNumber =
              phoneNumberUtil.parse(phoneNumber, simCountryCode);

          // 验证解析结果
          String? parsedCountryCode =
              phoneNumberUtil.getRegionCodeForNumber(parsedPhoneNumber);
          if (parsedCountryCode?.toUpperCase() ==
              simCountryCode.toUpperCase()) {
            countryCode = simCountryCode; // 解析成功，记录国家代码
            e164Number = phoneNumberUtil.format(
                parsedPhoneNumber, PhoneNumberFormat.e164);

            break;
          }
        } catch (e) {
          // print('Failed to parse with country code $simCountryCode: $e');
        }
        //3 特殊尝试添加国际区号到手机号码
        try {
          // 2. 如果直接解析失败，尝试添加国家代码
          // 使用 getCountryCodeForRegion 获取数字国家代码
          int? numericCountryCode = phoneNumberUtil
              .getCountryCodeForRegion(simCountryCode.toUpperCase());

          String fullPhoneNumber = '+$numericCountryCode$phoneNumber';
          PhoneNumber parsedPhoneNumber =
              phoneNumberUtil.parse(fullPhoneNumber, null);

          // 验证解析结果
          String? parsedCountryCode =
              phoneNumberUtil.getRegionCodeForNumber(parsedPhoneNumber);
          if (parsedCountryCode?.toUpperCase() ==
              simCountryCode.toUpperCase()) {
            countryCode = simCountryCode; // 解析成功，记录国家代码
            e164Number = phoneNumberUtil.format(
                parsedPhoneNumber, PhoneNumberFormat.e164);

            break;
          }
        } catch (e) {
//
        }
      }
    }

    // 使用 Provider 获取当前的 Locale
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    final currentLocale = localeProvider.locale;

    final languageCode = currentLocale.languageCode.split('_')[0];

    // 创建 dlibphonenumber 的 Locale
    final dlibLocale = dlibphone.Locale(
      language: languageCode,
      // country: countryCode ?? '', // 使用解析出的国家代码
      country: (countryCode ?? '').toUpperCase(), // 使用 toUpperCase() 方法
    );

    final appState = Provider.of<AppState>(context, listen: false);

    _callerIdService = appState.callerIdService;
    /*
  CallerIdData callerIdData = await _callerIdService.getCallerId(
      phoneNumber, context, dlibLocale);

  return callerIdData;
  */

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
    try {
      CallerIdData callerIdData =
          await _callerIdService.getCallerId(e164Number, context, dlibLocale);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Call History'),
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
            : _build(context),
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

/*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Call History'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => _showSettingsDialog(),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _callLog.length,
        itemBuilder: (context, index) {
          return _buildCallLogItem(_callLog[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddLabelPage()),
        ),
      ),
    );
  }
*/
  /*  
    //创建calllog 列表
    Widget _buildCallLogListItem(BuildContext context) {
    return ListView.builder(
      itemCount: _callLog.length,
      itemBuilder: (context, index) {
        return _buildCallLogItem(_callLog[index]);
      },
    );
  }
  */
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
                     final callLogEntry = _callLogEntry[adjustedIndex]; // 获取当前 CallLogEntry
                  return SizedBox(
                    width: entryWidth,
                    child: _buildCallLogItem(callLogEntry, entryWidth),  // 传递 CallerIdData
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
          title: Text(entry.number ?? 'Unknown'),
          subtitle: const Text('Loading...'),
        ),
      );
    }
    return Card(
      color: const Color.fromRGBO(255, 239, 239, 1), // 设置背景色为浅灰色
      margin: const EdgeInsets.all(10.0),
      child: ExpansionTile(
            key: ValueKey(callerIdData.phoneNumber),
            initiallyExpanded: _expandedItems[callerIdData.phoneNumber] ?? false,
            onExpansionChanged: (isExpanded) {
              // setState(() {
              _expandedItems[callerIdData.phoneNumber] = isExpanded;
              //  });
            },
            leading: Container(
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
/*          
title: ListTile(
  title: Text(
    entry.number ?? '',
    style: entryTitleStyle,
    overflow: TextOverflow.ellipsis,
  ),
  subtitle: Text(
    '${callerIdData.countryName}, ${callerIdData.region ?? ''}',
    style: entryLocationStyle,
    overflow: TextOverflow.ellipsis,
  ),
),

subtitle: ListTile(
  leading: callerIdData.labels.isNotEmpty
      ? Text(
          callerIdData.labels.first.label,
          style: entryLabelStyle,
        )
      : null, // 或其他 Widget，例如 SizedBox.shrink()
  title: Text(
        callerIdData.name,
        style: entryNameStyle,
        //overflow: TextOverflow.ellipsis,
      ),
),
*/
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
            subtitle: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  callerIdData.name,
                  style: entryNameStyle,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            /*
  subtitle: Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (callerIdData.labels.isNotEmpty)
        Text(
          callerIdData.labels.first.label,
          style: entryLabelStyle,
        ),
            const SizedBox(width: 3.0), // 添加 SizedBox        
      Text(
        callerIdData.name,
        style: entryNameStyle,
        overflow: TextOverflow.ellipsis,
      ),
    ],
  ),

*/

            trailing: Column(
  mainAxisSize: MainAxisSize.min,
  children: [
    Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (callerIdData.labels.isNotEmpty)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(147, 203, 128, 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              callerIdData.labels.first.label,
              style: entryLabelStyle,
              overflow: TextOverflow.ellipsis,
            ),
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
    Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '${formatCallLogTimestamp(entry.timestamp!)}',
          style: entryLocationStyle,
        ),
        const SizedBox(width: 3.0),
        Text(
          '${entry.simDisplayName}',
          style: entryLocationStyle,
        ),
      ],
    ),
  ],
),
            children: [
              _buildExpandedContent(context, callerIdData),
            ],
          )

    );
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
              const Text('Choose Avatar (Local or Network):'),
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
            decoration: const InputDecoration(labelText: 'Avatar URL or Path'),
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
                      _isAllowed ? 'Add to Allowed' : 'Remove Allowed',
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
                      _isBlocked ? 'Add to Blocked' : 'Remove Blocked',
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
              //  setState(() {
              callerIdData.labels.first.label = newLabel;
              //   });
            },
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
                    label: const Text('Add Contact'),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ContactFormPage()),
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
                      labelText: 'Name',
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
                    name: nameController.text,
                    avatar: avatarController
                        .text, // Use the avatarController's value
                    label: callerIdData.labels.first.label,
                  );
                  await _labelService.addOrUpdate(
                      updatedEntry); // Update database with updated entry
                  if (_isAllowed) {
                    await _allowedService.add(updatedEntry as AllowedEntry);
                  } else if (_isBlocked) {
                    await _blockedService.add(updatedEntry as BlockedEntry);
                  }
                  await _fetchCallLogs();
                  // Additional action after saving (optional)
                  setState(() {
                    _expandedItems[callerIdData.phoneNumber] = false;
                  });
                },
                style: showmoreButtonStyle,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center, // 按钮内容居中对齐
                  children: [
                    Icon(NewSet.check),
                    SizedBox(width: 8.0),
                    Text(
                      'Save',
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
          title: const Text('Settings'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SwitchListTile(
                    title: const Text('Show Contact Button'),
                    value: _isContactButtonVisible,
                    onChanged: (bool value) {
                      setState(() {
                        _isContactButtonVisible = value;
                      });
                      _savePreferences();
                    },
                  ),
                  SwitchListTile(
                    title: const Text('Show Contact Icon Button'),
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
              child: const Text('Close'),
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
    String formattedDate = DateFormat('MM-dd HH:mm').format(dateTime);

    return formattedDate;
  }

}

// Labels widget implementation remains the same as in the previous version
/*
class Labels extends StatefulWidget {
  const Labels({super.key, required this.entry});

  final LabeledEntry entry;

  @override
  State<Labels> createState() => _LabelsState();
}

class _LabelsState extends State<Labels> {
  late LabelService _labelService;
  List<String> _labels = [];
  String? _selectedLabel;
/*
  @override
  void initState() {
    super.initState();
    _initServices();
  }

  Future<void> _initServices() async {
    // 打开 number_control_list.db 数据库

    final labelsDatabase = await openDatabase(
      path_helper.join(await getDatabasesPath(), 'labels_database.db'),
      onCreate: la.createDatabase,
      version: 1,
    );

    // 实例化服务
    _labelService = LabelService(labelsDatabase);

    // 获取所有标签
    final labels = await _labelService.getAllLabels();
    if (labels.isEmpty) {
      await _labelService.insertPredefinedLabelsIfNotExists(labelsDatabase);
    }

    // 获取当前号码的标签
    final currentLabel =
        await _labelService.getLabelFromPhoneNumber(widget.entry.phoneNumber);

    setState(() {
      _labels = labels;
      _selectedLabel = currentLabel;
    });
  }
*/
  @override
  void initState() {
    super.initState();
    final appState = Provider.of<AppState>(context, listen: false);
       _labelService = appState.labelService;
    _initLabels();
  }

  Future<void> _initLabels() async {
 
    
    // 获取所有标签
    final labels = await _labelService.getAllLabels();
    if (labels.isEmpty) {
      await _labelService.insertPredefinedLabelsIfNotExists(_labelService.database);
    }

    // 获取当前号码的标签
    final currentLabel = await _labelService.getLabelFromPhoneNumber(widget.entry.phoneNumber);

    setState(() {
      _labels = labels;
      _selectedLabel = currentLabel;
    });
  }   


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select a label:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          children: _labels.map((label) {
            // 判断当前标签是否为选中状态
            final translatedLabel = Intl.message(label); // 翻译标签
            final isSelected = label == _selectedLabel; // 判断是否选中
            // final isSelected = label == _selectedLabel;
            return ChoiceChip(
              label: Text(translatedLabel),
              // 根据是否选中设置不同的样式
              selected: isSelected,
              // 点击标签时触发的回调函数
              onSelected: (_) async {
                setState(() {
                  // 更新选中的标签
                  _selectedLabel = label;
                });
                // 更新黑名单条目的标签
                widget.entry.label = label;
                try {
                  // 将更改保存到数据库
                  await _labelService.editLabelForPhoneNumber(
                      widget.entry.label, widget.entry.phoneNumber);
                } catch (e) {
                  // 保存失败时,恢复之前的选中状态
                  setState(() {
                    _selectedLabel = widget.entry.label;
                  });
                  // 显示错误消息
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to update label: $e')),
                  );
                }
              },
              // 选中的标签显示蓝色
              selectedColor: Colors.blue,
              // 未选中的标签显示灰色
              backgroundColor: Colors.grey[300],
            );
          }).toList(),
        ),
        // 如果有选中的标签,显示选中的标签
        if (_selectedLabel != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Selected Label: $_selectedLabel',
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
      ],
    );
  }
}
*/
class Labels extends StatefulWidget {
  final String initialLabel;
  final String phoneNumber;
  final ValueChanged<String> onLabelChanged; // 简洁的回调函数名称

  const Labels({
    super.key,
    required this.initialLabel,
    required this.phoneNumber,
    required this.onLabelChanged,
  });

  @override
  State<Labels> createState() => _LabelsState();
}

class _LabelsState extends State<Labels> {
  late LabelService _labelService;
  String? _selectedLabel;
  List<String> _labels = [];

  @override
  void initState() {
    super.initState();
    final appState = Provider.of<AppState>(context, listen: false);
    _labelService = appState.labelService;
    _selectedLabel = widget.initialLabel;
    _initLabels();
  }

  Future<void> _initLabels() async {
    // 获取所有标签
    final labels = await _labelService.getAllLabels();
    if (labels.isEmpty) {
      await _labelService
          .insertPredefinedLabelsIfNotExists(_labelService.database);
      // 重新获取标签列表
      _labels = await _labelService.getAllLabels();
    } else {
      _labels = labels;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select a label:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          children: _labels.map((label) {
            // 判断当前标签是否为选中状态
            final translatedLabel = Intl.message(label); // 翻译标签
            final isSelected = label == _selectedLabel; // 判断是否选中
            // final isSelected = label == _selectedLabel;
            return ChoiceChip(
              label: Text(translatedLabel),
              // 根据是否选中设置不同的样式
              selected: isSelected,
              // 点击标签时触发的回调函数
              onSelected: (_) async {
                setState(() {
                  // 更新选中的标签
                  _selectedLabel = label;
                });
                // 更新黑名单条目的标签
                widget.onLabelChanged(label);
              },
              // 选中的标签显示蓝色
              selectedColor: Colors.green,
              // 未选中的标签显示灰色
              backgroundColor: Colors.grey[300],
            );
          }).toList(),
        ),
        // 如果有选中的标签,显示选中的标签
        if (_selectedLabel != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${Intl.message('Selected Label')}: $_selectedLabel',
              style: const TextStyle(
                fontSize: 16.0,
                backgroundColor: Color.fromRGBO(
                    147, 203, 128, 1), // Add background color here
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }
}
