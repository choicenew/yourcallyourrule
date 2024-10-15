import 'dart:async';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../generated/l10n.dart';
import '../services/caller_id_monitor_service.dart';
import '../services/sms_notification_service.dart';
import '../utils/ad_state.dart';
import '../utils/call_screen_plugin.dart';
import '../utils/language_provider.dart';
import '../utils/purchase_state.dart';
import '../utils/repeated_call.dart';
import '../utils/theme_provider.dart';
import '../utils/update_interval.dart';
import '../views/about.dart';
import '../widgets/adwidgets/native_ads.dart';
import '../widgets/purchase_manager.dart';
import 'appstate_provider.dart';
import 'language_data.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  late InAppPurchaseManager inAppPurchaseManager;

  bool _isPermissionsExpanded = false; // 定义 _isPermissionsExpanded

//电话拦截的action选项
  String? _selectedInterceptAction = 'endCall'; // 初始化并设置默认值
  bool _isCallUseLocalNotificationEnabled = false; // 新增: call 通知过滤开关状态
  bool _isCallCancelLocalNotificationEnabled = false; // 新增: call 通知过滤开关状态

//stir 通知
  bool _isStirUseStirNotificationEnabled = false; // 新增: call 通知过滤开关状态

  //  重复来电是否拦截
  final TimeBasedInterceptor _timeBasedInterceptor = TimeBasedInterceptor();
  late Duration _duration = const Duration(minutes: 30); // 设置初始值
  late bool _shouldIntercept = true; // 设置初始值
  TextEditingController _durationController = TextEditingController();

  //SMS拦截的选项
  late SmsFilterService _smsFilterService;
  bool _isSmsFilterEnabled = false; // 新增: SMS 过滤开关状态
  bool _isSmsUseLocalNotificationEnabled = false; // 新增: SMS 通知过滤开关状态
  bool _isSmsCancelLocalNotificationEnabled = false; // 新增: SMS 通知过滤开关状态

  //caller 设置
  bool _isDefaultCallerIdApp = false;

  // 为每个服务创建一个 TextEditingController
  final Map<String, TextEditingController> _controllers = {
    'SubscriptionModel': TextEditingController(),
    'ContactSubscription': TextEditingController(),
    'AutoBackup': TextEditingController(),
    'PluginUpdate': TextEditingController(),
    'RecordBackup': TextEditingController(),
  };

  @override
  void initState() {
    super.initState();
    final purchaseState = Provider.of<PurchaseState>(context, listen: false);
    inAppPurchaseManager = InAppPurchaseManager(context, purchaseState);
    _initializeIntervalSettings();
    _loadCallFilterService(); // 过滤电话action
    _loadInterceptAction(); // 新增: 加载 电话过滤action
    _loadSmsFilterService(); // 新增: 加载 SMS 过滤状态
    _loadStirNotification();
    //  _timeBasedInterceptor = TimeBasedInterceptor(); // 初始化实例
    _loadInterceptorSettings();
    _loadDefaultCallerIdStatus();
  }

  Future<void> _initializeIntervalSettings() async {
    for (var entry in _controllers.entries) {
      Duration interval = await getUserInterval(entry.key);
      entry.value.text = interval.inDays.toString();
    }
    setState(() {});
  }

  //caller加载配置
  Future<void> _loadDefaultCallerIdStatus() async {
    final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();

    _isDefaultCallerIdApp =
        await asyncPrefs.getBool('isDefaultCallerIdApp') ?? false;
    setState(() {});
  }

  Future<void> _loadSmsFilterService() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final appState = Provider.of<AppState>(context, listen: false);
      final asyncPrefs = SharedPreferencesAsync(); // 获取 SharedPreferences 实例
      _isSmsFilterEnabled =
          await asyncPrefs.getBool(SmsFilterService.smsFilterEnabledKey) ??
              false; // 从 SharedPreferences 中读取值
      appState.smsFilterService
          .setEnabled(_isSmsFilterEnabled); // 设置 SMS 过滤服务的状态
      _isSmsUseLocalNotificationEnabled =
          await asyncPrefs.getBool(SmsFilterService.smsLocalNotificationKey) ??
              false; // 从 SharedPreferences 中读取值
      appState.smsFilterService.setUseLocalNotification(
          _isSmsUseLocalNotificationEnabled); // 设置 SMS 过滤服务的状态
      _isSmsCancelLocalNotificationEnabled = await asyncPrefs
              .getBool(SmsFilterService.smsCancelLocalNotificationKey) ??
          false; // 从 SharedPreferences 中读取值
      appState.smsFilterService.closeLocalNotification(
          _isSmsCancelLocalNotificationEnabled); // 设置 SMS 过滤服务的状态

      setState(() {}); // 更新 UI
    });
  }

  Future<void> _loadCallFilterService() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final appState = Provider.of<AppState>(context, listen: false);
      final asyncPrefs = SharedPreferencesAsync(); // 获取 SharedPreferences 实例

      _isCallUseLocalNotificationEnabled = await asyncPrefs
              .getBool(CallerIdMonitorService.callLocalNotificationKey) ??
          false; // 从 SharedPreferences 中读取值
      appState.callerIdMonitorService.setUseLocalNotification(
          _isCallUseLocalNotificationEnabled); // 设置 call 过滤服务的状态
      _isCallCancelLocalNotificationEnabled = await asyncPrefs
              .getBool(CallerIdMonitorService.callCancelLocalNotificationKey) ??
          false; // 从 SharedPreferences 中读取值
      appState.callerIdMonitorService.closeLocalNotification(
          _isCallCancelLocalNotificationEnabled); // 设置 call 过滤服务的状态

      setState(() {}); // 更新 UI
    });
  }

//stir 通知
  Future<void> _loadStirNotification() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final appState = Provider.of<AppState>(context, listen: false);
      final asyncPrefs = SharedPreferencesAsync(); // 获取 SharedPreferences 实例

      _isStirUseStirNotificationEnabled = await asyncPrefs
              .getBool(CallerIdMonitorService.stirLocalNotificationKey) ??
          false; // 从 SharedPreferences 中读取值
      appState.callerIdMonitorService.setUseStirNotification(
          _isStirUseStirNotificationEnabled); // 设置 call 过滤服务的状态
      setState(() {}); // 更新 UI
    });
  }

  // 加载电话Interceptor配置
  Future<void> _loadInterceptAction() async {
    SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
    // 直接赋值给 _selectedInterceptAction
    _selectedInterceptAction =
        await asyncPrefs.getString('intercept_action') ?? 'endCall';

    setState(() {}); // 触发 UI 重新构建
  }

  Future<void> _saveInterceptAction(String? newValue) async {
    SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
    await asyncPrefs.setString('intercept_action', newValue!);
  }

  // 加载Repeated Call Interceptor配置
  Future<void> _loadInterceptorSettings() async {
    await _timeBasedInterceptor.loadConfig();
    _duration = _timeBasedInterceptor.config.duration;
    _shouldIntercept = _timeBasedInterceptor.config.shouldIntercept;
    _durationController.text = _duration.inMinutes.toString();
    setState(() {}); // 将 setState 移到异步操作之后
  }

  // 保存SMSInterceptor配置
  void _saveInterceptorSettings() {
    _timeBasedInterceptor.updateConfig(_duration, _shouldIntercept);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(S.of(context).settingsSaved)),
    );
  }

  @override
  void dispose() {
    _durationController.dispose();
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 获取当前的 LocaleProvider
    Provider.of<LocaleProvider>(context, listen: false);

    final adState = Provider.of<AdState>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).settings),
      ),
      body: ListView(
        children: <Widget>[
          _buildAdEnabledStatus(),
          _buildInAppPurchaseToggle(),
          const SizedBox(height: 20),
          _buildLanguageSelection(),
          const SizedBox(height: 20),
          _buildDefaultCallerIDRequestToggle(),
          const SizedBox(height: 20),
          _buildCallActionInterceptorSettings(),
          const SizedBox(height: 20),
          _buildTimeBasedInterceptorSettings(),
          const SizedBox(height: 20),
          _buildStirSettings(),
          const SizedBox(height: 20),
          _buildSMSSettings(),
          const SizedBox(height: 20),
          _buildDarkModeSettings(context),
          const SizedBox(height: 20),
          _buildIntervalSettings(),
          const SizedBox(height: 20),
          _buildPermissionSection(context),
          _buildAboutPageTile(),
          const SizedBox(height: 20),
          //广告代码
          nativeAdWidgetMedium(adWidth: 320, adHeight: 320),
        ],
      ),
    );
  }

//添加aboutPage
  Widget _buildAboutPageTile() {
    return ListTile(
      title: Text(S.of(context).about),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AboutPage()),
        );
      },
    );
  }

//显示广告状态
  Widget _buildAdEnabledStatus() {
    return Consumer<AdState>(
      builder: (context, adState, child) {
        return ListTile(
          title: Text(
              '${S.of(context).adEnabled} ${adState.isAdEnabled ? S.of(context).enabled : S.of(context).disabled}'),
        );
      },
    );
  }

//去除广告
  Widget _buildInAppPurchaseToggle() {
    return Consumer2<AdState, PurchaseState>(
      // 使用 Consumer2 监听 AdState 和 PurchaseState
      builder: (context, adState, purchaseState, child) {
        return SwitchListTile(
          title: Text(
            S.of(context).removeAdsAndEnableOnlineBackup,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          subtitle: Text(adState.isAdEnabled
              ? S.of(context).enableToRemoveAds
              : S.of(context).inappPurchasesEnabled),
          value: !adState.isAdEnabled,
          onChanged: (bool value) {
            if (!adState.isAdEnabled) {
              inAppPurchaseManager.toggleAdState(context);
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PurchasePage()),
              ).then((_) {});
            }
          },
        );
      },
    );
  }

  Widget _buildLanguageSelection() {
    return Consumer<LocaleProvider>(
      builder: (context, localeProvider, child) {
        Locale currentLocale = localeProvider.locale;

        // 确保当前语言代码在语言列表中，否则使用默认值
        if (!languages.any((lang) => lang['code'] == currentLocale)) {
          currentLocale = const Locale('en', 'US');
        }

        return ListTile(
          title: Text(
            S.of(context).chooseYourLanguage,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          trailing: DropdownButton<Locale>(
            // 将类型改为 Locale
            value: currentLocale,
            items: languages.map((language) {
              return DropdownMenuItem<Locale>(
                // 将类型改为 Locale
                value: language['code']!,
                child: Text(language['name']!),
              );
            }).toList(),
            onChanged: (Locale? newValue) {
              // 将类型改为 Locale?
              if (newValue != null) {
                localeProvider.updateLocale(newValue);
              }
            },
          ),
        );
      },
    );
  }

  // 构建 TimeBasedInterceptor 设置项
  Widget _buildCallActionInterceptorSettings() {
    return ExpansionTile(
      title: Text(S.of(context).blockedCallAction,
          style: Theme.of(context).textTheme.titleLarge),
      initiallyExpanded: false, // 可以根据需要设置初始展开状态
      children: [
        _buildInterceptActionSelection(),
        _buildCallLocalNotificationToggle(),
        _buildCallCloseLocalNotificationToggle(),
      ],
    );
  }

  // 构建 TimeBasedInterceptor 设置项
  Widget _buildTimeBasedInterceptorSettings() {
    return ExpansionTile(
      title: Text(S.of(context).repeatedCalls,
          style: Theme.of(context).textTheme.titleLarge),
      initiallyExpanded: false, // 可以根据需要设置初始展开状态
      children: [
        _buildCallFilterDuration(_durationController),
        _buildCallFilterDurationToggle(),
      ],
    );
  }

//选择电话的默认拦截方式
  Widget _buildInterceptActionSelection() {
    return ListTile(
      title: Text(
        S.of(context).incomingCallInterceptAction,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ), // 主标题
      subtitle: Text(S.of(context).chooseTheDefaultInterceptAction), // 副标题
      trailing: DropdownButton<String>(
        value: _selectedInterceptAction,
        onChanged: (String? newValue) {
          setState(() {
            _selectedInterceptAction = newValue!;
          });
          _saveInterceptAction(newValue);
        },
        items: <DropdownMenuItem<String>>[
          DropdownMenuItem<String>(
            value: 'endCall',
            child: Text(S.of(context).endcall),
          ),
          DropdownMenuItem<String>(
            value: 'answerThenHangup',
            child: Text(S.of(context).answerthenhangup),
          ),
          DropdownMenuItem<String>(
            value: 'silenceNoAnswer',
            child: Text(S.of(context).silencenoanswer),
          ),
        ],
      ),
    );
  }

//call 拦截action通知

  Widget _buildCallLocalNotificationToggle() {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        return SwitchListTile(
          title: Text(
            S.of(context).blockedCallNotification,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          subtitle: Text(_isCallUseLocalNotificationEnabled
              ? S.of(context).enableBlockedCallNotification
              : S.of(context).disableBlockedCallNotification),
          value: _isCallUseLocalNotificationEnabled,
          onChanged: (bool value) async {
            // 只请求一次权限
            if (value && !await Permission.notification.request().isGranted) {
              if (await Permission.notification.request().isPermanentlyDenied) {
                openAppSettings();
              }
              return;
            }
            _isCallUseLocalNotificationEnabled = value;
            // 更新 CallerIdMonitorService 的状态和 SharedPreferences
            await appState.callerIdMonitorService
                .setUseLocalNotification(value);
            final asyncPrefs = SharedPreferencesAsync();
            await asyncPrefs.setBool(
                CallerIdMonitorService.callLocalNotificationKey, value);

            setState(() {}); // 触发 UI 重新构建
          },
        );
      },
    );
  }

//自动call 拦截action通知
  Widget _buildCallCloseLocalNotificationToggle() {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        return SwitchListTile(
          title: Text(
            S.of(context).autoCloseLocalNotification,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          subtitle: Text(_isCallCancelLocalNotificationEnabled
              ? S.of(context).onlyOriginalCallAppNotification
              : S.of(context).bothOriginalCallAppLocalNotification),
          value:
              _isCallCancelLocalNotificationEnabled, // 直接访问 SmsFilterService 的状态
          onChanged: (bool value) async {
            // 只请求一次权限
            if (value && !await Permission.notification.request().isGranted) {
              if (await Permission.notification.request().isPermanentlyDenied) {
                openAppSettings();
              }
              return;
            }

            // 更新 call 本地通知状态
            _isCallCancelLocalNotificationEnabled = value;
            await appState.callerIdMonitorService.closeLocalNotification(value);
            final asyncPrefs = SharedPreferencesAsync();
            await asyncPrefs.setBool(
                CallerIdMonitorService.callCancelLocalNotificationKey, value);
            setState(() {});
          },
        );
      },
    );
  }

  Widget _buildCallFilterDuration(TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        // 使用 Row 布局
        children: [
          Expanded(
            // 使用 Expanded 部件，并设置 flex 属性
            flex: 2,
            child: Text(
              S.of(context).statisticsTimeRangeMinutes,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Expanded(
            // 使用 Expanded 部件，并设置 flex 属性
            flex: 1,
            child: TextField(
              controller: _durationController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
              ),
              onChanged: (value) {
                int? minutes = int.tryParse(value);
                if (minutes != null) {
                  // 直接在 onChanged 回调中更新 _duration 并保存设置
                  _duration = Duration(minutes: minutes);
                  _saveInterceptorSettings();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCallFilterDurationToggle() {
    return SwitchListTile(
      title: Text(
        S.of(context).interceptRepeatedIncomingCallsWithinTheTimeRange,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      subtitle: Text(
        _shouldIntercept
            ? S.of(context).allowRepeatedIncomingCalls
            : S.of(context).filterRepeatedIncomingCalls,
      ),
      value: _shouldIntercept,
      onChanged: (value) {
        _shouldIntercept = value;
        _saveInterceptorSettings();
        setState(() {});
      },
    );
  }

  // 构建 stir 设置项
  Widget _buildStirSettings() {
    return ExpansionTile(
      title: Text(S.of(context).stirNotification,
          style: Theme.of(context).textTheme.titleLarge),
      subtitle: Text(S.of(context).onlyForSupportedArea),
      initiallyExpanded: false, // 可以根据需要设置初始展开状态
      children: [
        _buildStirNotificationToggle(),
      ],
    );
  }

//stir 通知

  Widget _buildStirNotificationToggle() {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        return SwitchListTile(
          title: Text(
            S.of(context).stirNotification,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          subtitle: Text(_isStirUseStirNotificationEnabled
              ? S.of(context).enableStirNotification
              : S.of(context).disableStirNotification),
          value: _isStirUseStirNotificationEnabled,
          onChanged: (bool value) async {
            _isStirUseStirNotificationEnabled = value;
            // 更新 CallerIdMonitorService 的状态和 SharedPreferences
            await appState.callerIdMonitorService.setUseStirNotification(value);
            final asyncPrefs = SharedPreferencesAsync();
            await asyncPrefs.setBool(
                CallerIdMonitorService.stirLocalNotificationKey, value);

            setState(() {}); // 触发 UI 重新构建
          },
        );
      },
    );
  }

  // 构建 sms 设置项
  Widget _buildSMSSettings() {
    return ExpansionTile(
      title: Text(S.of(context).smsNotification,
          style: Theme.of(context).textTheme.titleLarge),
      initiallyExpanded: false, // 可以根据需要设置初始展开状态
      children: [
        _buildSmsFilterToggle(),
        _buildSmsLocalNotificationToggle(),
        _buildSmsCloseLocalNotificationToggle(),
      ],
    );
  }

  Widget _buildSmsFilterToggle() {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        return SwitchListTile(
          title: Text(
            S.of(context).smsFiltering,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          subtitle: Text(_isSmsFilterEnabled
              ? S.of(context).filterIncomingSmsMessages
              : S.of(context).noIncomingSmsMessagesFilter),
          value: _isSmsFilterEnabled,
          onChanged: (bool value) async {
            // 只请求一次权限
            if (value && !await Permission.sms.request().isGranted) {
              if (await Permission.sms.request().isPermanentlyDenied) {
                openAppSettings();
              }
              return;
            }

            // 更新 SMS 过滤状态
            _isSmsFilterEnabled = value;
            await appState.smsFilterService.setEnabled(value);
            final asyncPrefs = SharedPreferencesAsync();
            await asyncPrefs.setBool(
                SmsFilterService.smsFilterEnabledKey, value);
            setState(() {});
          },
        );
      },
    );
  }

  Widget _buildSmsLocalNotificationToggle() {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        return SwitchListTile(
          title: Text(
            S.of(context).smsLocalNotification,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          subtitle: Text(_isSmsUseLocalNotificationEnabled
              ? S.of(context).enableSmsLocalNotification
              : S.of(context).disableSmsLocalNotification),
          value: _isSmsUseLocalNotificationEnabled,
          onChanged: (bool value) async {
            // 只请求一次权限
            if (value && !await Permission.notification.request().isGranted) {
              if (await Permission.notification.request().isPermanentlyDenied) {
                openAppSettings();
              }
              return;
            }

            // 更新 SMS 本地通知状态
            _isSmsUseLocalNotificationEnabled = value;
            await appState.smsFilterService.setUseLocalNotification(value);
            final asyncPrefs = SharedPreferencesAsync();
            await asyncPrefs.setBool(
                SmsFilterService.smsLocalNotificationKey, value);
            setState(() {});
          },
        );
      },
    );
  }

  Widget _buildSmsCloseLocalNotificationToggle() {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        return SwitchListTile(
          title: Text(
            S.of(context).onlyRingLocalNotification,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          subtitle: Text(_isSmsCancelLocalNotificationEnabled
              ? S.of(context).onlyUseOriginalSmsNotification
              : S.of(context).bothOriginalSmsLocalNotification),
          value:
              _isSmsCancelLocalNotificationEnabled, // 直接访问 SmsFilterService 的状态
          onChanged: (bool value) async {
            // 只请求一次权限
            if (value && !await Permission.notification.request().isGranted) {
              if (await Permission.notification.request().isPermanentlyDenied) {
                openAppSettings();
              }
              return;
            }

            // 更新 SMS 本地通知状态
            _isSmsCancelLocalNotificationEnabled = value;
            await appState.smsFilterService.closeLocalNotification(value);
            final asyncPrefs = SharedPreferencesAsync();
            await asyncPrefs.setBool(
                SmsFilterService.smsCancelLocalNotificationKey, value);
            setState(() {});
          },
        );
      },
    );
  }

  Widget _buildIntervalSettings() {
    return ExpansionTile(
      title: Text(
        S.of(context).serviceUpdateIntervalsDays,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ..._controllers.entries
                .map((entry) => _buildIntervalSetting(entry.key, entry.value)),
          ],
        ),
      ],
    );
  }

  Widget _buildIntervalSetting(
      String serviceName, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(serviceName),
          ),
          Expanded(
            flex: 1,
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
              ),
              onChanged: (value) {
                int? days = int.tryParse(value);
                if (days != null) {
                  setUserInterval(serviceName, days);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

//  新增： 默认caller ID请求页面
  Widget _buildDefaultCallerIDRequestToggle() {
    return ListTile(
      onTap: () async {
        bool result = await CallScreeningPlugin.requestCallScreeningRole();

        // 更新 SharedPreferences 中的状态
        final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
        await asyncPrefs.setBool('isDefaultCallerIdApp', result);

        // 显示 Snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result
                ? S.of(context).callScreeningRoleRequestSuccessful
                : S.of(context).callScreeningRoleRequestFailed),
          ),
        );

        // 更新 UI 状态
        setState(() {
          _isDefaultCallerIdApp = result;
        });
      },
      title: Text(
        S.of(context).setupDefaultCallerIdApp,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      subtitle: Text(_isDefaultCallerIdApp
          ? S.of(context).allowThisAppToShowCallerId
          : S.of(context).disableThisAppToShowCallerId),
      trailing: Icon(
        _isDefaultCallerIdApp ? Icons.check_circle : Icons.cancel,
        color: _isDefaultCallerIdApp ? Colors.green : Colors.red,
      ),
    );
  }

  // 这里添加
  Widget _buildPermissionSection(BuildContext context) {
    return ExpansionTile(
      title: Text(
        S.of(context).permissions,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      initiallyExpanded: _isPermissionsExpanded,
      onExpansionChanged: (bool expanded) {
        _isPermissionsExpanded = expanded;
        setState(() {});
      },
      children: <Widget>[
        _buildPermissionSwitch(
            context, Permission.contacts, S.of(context).contacts),
        _buildPermissionSwitch(
            context, Permission.phone, S.of(context).callLog),
        _buildPermissionSwitch(
            context, Permission.notification, S.of(context).notifications),
        _buildPermissionSwitch(
            context, Permission.systemAlertWindow, S.of(context).overlay),
        _buildPermissionSwitch(context, Permission.sms, S.of(context).sms),
        //_buildPermissionSwitch(context, Permission.storage, S.of(context).storage),
        _buildPermissionSwitch(context, Permission.ignoreBatteryOptimizations,
            S.of(context).batteryOptimization),
      ],
    );
  }

  Widget _buildPermissionSwitch(
      BuildContext context, Permission permission, String permissionName) {
    return FutureBuilder<PermissionStatus>(
      future: permission.status,
      builder:
          (BuildContext context, AsyncSnapshot<PermissionStatus> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // or any loading indicator
        } else if (snapshot.hasError) {
          return ListTile(
            title: Text(permissionName),
            subtitle: Text(S.of(context).errorGettingPermissionStatus),
          );
        } else {
          return SwitchListTile(
            title: Text(permissionName),
            value: snapshot.data!.isGranted,
            onChanged: (bool value) async {
              if (value) {
                PermissionStatus status = await permission.request();
                if (!status.isGranted) {
                  // 权限被拒绝
                  _showPermissionDeniedDialog(context, permissionName);
                }
              } else {
                // 处理关闭权限的逻辑 (例如，禁用相关功能)
                // 注意：你可能无法通过代码直接关闭权限，需要提示用户手动关闭
                showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text(S.of(context).disablePermission),
                    content: Text(
                      S.of(context).manuallyDisablePermissionInAppSetting(
                          permissionName),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: Text(S.of(context).ok),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                );
              }
              setState(() {});
            },
          );
        }
      },
    );
  }

  void _showPermissionDeniedDialog(
      BuildContext context, String permissionName) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(S.of(context).permissionDenied),
        content: Text(S.of(context).PermissionWasNotGranted(permissionName)),
        actions: <Widget>[
          TextButton(
            child: Text(S.of(context).ok),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDarkModeSettings(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return ListTile(
          title: Text(
            S.of(context).darkMode,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          subtitle: Text(S.of(context).enableDarkModeBasedOnTime),
          trailing: DropdownButton<ThemeMode>(
            value: themeProvider.themeMode,
            onChanged: (ThemeMode? newValue) {
              if (newValue != null) {
                themeProvider.setThemeMode(newValue);
              }
            },
            items: [
              DropdownMenuItem(
                value: ThemeMode.system,
                child: Text(S.of(context).system),
              ),
              DropdownMenuItem(
                value: ThemeMode.light,
                child: Text(S.of(context).light),
              ),
              DropdownMenuItem(
                value: ThemeMode.dark,
                child: Text(S.of(context).dark),
              ),
            ],
          ),
        );
      },
    );
  }
}
