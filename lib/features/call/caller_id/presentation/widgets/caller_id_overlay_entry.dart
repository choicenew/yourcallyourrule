import 'dart:isolate';
import 'dart:ui';

import 'package:dlibphonenumber/enums/phone_number_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/call/sim_info.dart';
import 'package:yourcallyourrule/core/entities/call/stir_info.dart';
import 'package:yourcallyourrule/core/entities/caller_id_data.dart';
import 'package:yourcallyourrule/core/provider/providers/caller_id_style_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/locale_service_provider.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';
import 'package:yourcallyourrule/features/language/provider/language_provider.dart';
import 'package:yourcallyourrule/features/call/caller_id/configuration/configuration_manager.dart';
import 'package:yourcallyourrule/features/call/caller_id/providers/caller_id_style_provider.dart';
import 'package:yourcallyourrule/features/call/caller_id/providers/security_message_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/core_security_message_provider.dart';
import 'package:yourcallyourrule/features/call/caller_id/presentation/widgets/caller_id_content_builder.dart';
import 'package:yourcallyourrule/features/call/caller_id/presentation/widgets/caller_id_overlay.dart';


/// 来电显示覆盖层入口组件
/// 在独立进程中显示来电信息的入口点
class CallerIdOverlayEntry extends ConsumerStatefulWidget {
  const CallerIdOverlayEntry({super.key});

  @override
  ConsumerState<CallerIdOverlayEntry> createState() => _CallerIdOverlayEntryState();
}

class _CallerIdOverlayEntryState extends ConsumerState<CallerIdOverlayEntry> {
  CallerIdData? _callerIdData;
  CallerIdStyleProvider? styleProvider;
  SecurityMessageProvider? securityProvider;
  SimInfo? _simInfo;
  StirInfo? _stirInfo;
  late final ConfigRepository _configRepository;

  @override
  void initState() {
    super.initState();
/*
    // 处理Isolate错误和退出
    Isolate.current.addErrorListener(RawReceivePort((dynamic error) {
      // 处理错误
    }).sendPort);

    Isolate.current.addOnExitListener(RawReceivePort((dynamic message) {
      // 处理退出
    }).sendPort);

    // 设置接收端口，用于接收主应用程序的消息
    final receivePort = ReceivePort();
    IsolateNameServer.registerPortWithName(receivePort.sendPort, '_overlayPort');

    // 监听来自主应用程序的消息
    receivePort.listen((dynamic message) {
      if (message is Map && message.containsKey('locale')) {
        // 更新LocaleProvider
        ref.read(localeProvider.notifier).updateLocale(message['locale']);
      }
    });
   */ 
    // 初始化配置仓库
    _configRepository = SharedPreferencesConfigRepository();
    final configurationManager = ConfigurationManager(_configRepository);

    // 获取Provider实例
    styleProvider = ref.read(callerIdStyleProvider);
    securityProvider = ref.read(coreSecurityMessageProvider);
    styleProvider = ref.read(callerIdStyleProvider);
    // 监听覆盖层消息
    FlutterOverlayWindow.overlayListener.listen((event) {

      setState(() {
        // 判断接收到的数据类型
        if (event is Map<String, dynamic> && event.containsKey("configType")) {
          String configType = event["configType"];

          if (configType == "callerIdStyle") {
            // 处理配置数据
            ConfigurationManager.updateConfigFromMap(event, styleProvider!, securityProvider!);
          } else if (configType == "callerIdData") {
            // 处理CallerIdData数据
            _processCallerIdData(event);
          } else if (configType == "stirInfo") {
            // 处理StirInfo数据
            _stirInfo = StirInfo.fromJson(event);
          } else if (configType == "simInfo") {
            // 处理SimInfo数据
            _simInfo = SimInfo.fromJson(event);
          }
        }
      });

      // 检查styleProvider和callerIdData是否都已接收
      if (styleProvider != null && _callerIdData != null) {
        setState(() {}); // 触发重新构建
      }
    });
  }

  // 处理CallerIdData数据
  void _processCallerIdData(Map<String, dynamic> data) {
    // 创建标签列表
    List<Label> labels = [];
    if (data.containsKey('labels') && data['labels'] is List) {
      labels = (data['labels'] as List)
          .map((labelData) => Label(
                label: labelData['label'],
                color: labelData['color'],
                icon: labelData['icon'],
              ))
          .toList();
    }

    // 创建CallerIdData对象
    _callerIdData = CallerIdData(
      id: data['phoneNumber'] ?? '',
      phoneNumber: data['phoneNumber'] != null
          ? PhoneNumber.fromString(data['phoneNumber'])
          : PhoneNumber.fromString(''),
// 直接使用索引从枚举列表中获取值
    numberType: data['numberType'] != null && data['numberType'] is int
                  ? PhoneNumberType.values[data['numberType']]
          : PhoneNumberType.unknown,
      name: data['name'],
      countryName: data['countryName'],
      region: data['region'],
      carrier: data['carrier'],
      labels: labels,
      avatar: data['avatar'],
      count: data['count'] ?? 0,
    );

    debugPrint(_callerIdData!.toMap().toString());
  }

  @override
  Widget build(BuildContext context) {
    // 如果_callerIdData不为空，则显示CallerIdOverlay
    if (styleProvider != null && _callerIdData != null) {
      return Material(
        color: Colors.transparent,
        child: Consumer(
          builder: (context, ref, child) {
            final styleProvider = ref.watch(callerIdStyleProvider);
            return IsolateCallerIdOverlay(
              callerIdData: _callerIdData!,
              simInfo: _simInfo,
              stirInfo: _stirInfo,
              onDismiss: () {
                FlutterOverlayWindow.closeOverlay();
              },
              isDismissible: true,
              styleProvider: styleProvider,
            );
          },
        ),
      );
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }
}

/// 在Isolate中使用的来电显示覆盖层组件
class IsolateCallerIdOverlay extends StatefulWidget {
  final CallerIdData callerIdData;
  final SimInfo? simInfo;
  final StirInfo? stirInfo;
  final VoidCallback onDismiss;
  final bool isDismissible;
  final CallerIdStyleProvider styleProvider;

  const IsolateCallerIdOverlay({
    super.key,
    required this.callerIdData,
    this.simInfo,
    this.stirInfo,
    required this.onDismiss,
    required this.isDismissible,
    required this.styleProvider,
  });

  @override
  State<IsolateCallerIdOverlay> createState() => _IsolateCallerIdOverlayState();
}

class _IsolateCallerIdOverlayState extends State<IsolateCallerIdOverlay> {
  Offset _offset = const Offset(0, 0);
  double _opacity = 1.0;
  bool _isDismissed = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: _offset.dx,
          top: _offset.dy,
          child: GestureDetector(
            onTap: () {
              if (widget.isDismissible) {
                FlutterOverlayWindow.closeOverlay();
              }
            },
            child: widget.isDismissible
                ? _isDismissed
                    ? const SizedBox.shrink()
                    : Dismissible(
                        key: Key(widget.callerIdData.id),
                        direction: DismissDirection.horizontal,
                        onDismissed: (_) {
                          setState(() {
                            _isDismissed = true;
                          });
                          FlutterOverlayWindow.closeOverlay();
                        },
                        onUpdate: (details) {
                          setState(() {
                            _opacity = 1.0 - details.progress;
                          });
                        },
                        child: _buildOverlayContent(context),
                      )
                : _buildOverlayContent(context),
          ),
        ),
      ],
    );
  }

  // 构建覆盖层内容
  Widget _buildOverlayContent(BuildContext context) {
    return CallerIdContentBuilder.buildOverlayContainer(
      styleProvider: widget.styleProvider,
      opacity: _opacity,
      child: CallerIdContentBuilder.buildCallerIdContent(
        context: context,
        callerIdData: widget.callerIdData,
        styleProvider: widget.styleProvider,
        simInfo: widget.simInfo,
        stirInfo: widget.stirInfo,
        isDraggable: false,
      ),
    );
  }

  // 使用共享的CallerIdContentBuilder替代原有的内容构建方法
}