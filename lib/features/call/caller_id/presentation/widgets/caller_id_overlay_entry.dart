import 'package:flutter/material.dart';
import 'package:floating_window_android/floating_window_android.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dlibphonenumber/enums/phone_number_type.dart';
import 'package:yourcallyourrule/core/entities/call/sim_info.dart';
import 'package:yourcallyourrule/core/entities/call/stir_info.dart';
import 'package:yourcallyourrule/core/entities/caller_id_data.dart';

import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/features/call/caller_id/presentation/widgets/caller_id_content_builder.dart';
import 'package:yourcallyourrule/features/call/caller_id/providers/callerid_style_security_provider.dart';

class CallerIdOverlayEntry extends ConsumerStatefulWidget {
  const CallerIdOverlayEntry({super.key});

  @override
  ConsumerState<CallerIdOverlayEntry> createState() => _CallerIdOverlayEntryState();
}

class _CallerIdOverlayEntryState extends ConsumerState<CallerIdOverlayEntry> {
  CallerIdData? _callerIdData;
  SimInfo? _simInfo;
  StirInfo? _stirInfo;

  @override
  void initState() {
    super.initState();
    
    // 【修改点】: initState 中不再需要手动加载配置或读取provider。
    // Provider 会自动处理自己的初始化。我们只需要监听来自主App的数据。
    FloatingWindowAndroid.overlayListener.listen((event) {
       debugPrint('Received data: $event');
      if (event is Map<String, dynamic> && event.containsKey("configType")) {
        setState(() {
          String configType = event["configType"];
          if (configType == "callerIdData") {
            _callerIdData = _processCallerIdData(event);
          } else if (configType == "stirInfo") {
            _stirInfo = StirInfo.fromJson(event);
          } else if (configType == "simInfo") {
            _simInfo = SimInfo.fromJson(event);
          }
          // 注意：配置更新现在由主App保存，这里的Provider会自动重新加载，
          // 所以不需要再手动处理 "callerIdStyle" 类型的消息。
          debugPrint("接收到配置更新: ${_callerIdData?.toMap()}");
        });
      }
    });
  }

  CallerIdData _processCallerIdData(Map<String, dynamic> data) {
    List<Label> labels = (data['labels'] as List? ?? [])
        .map((labelData) => Label.fromMap(labelData))
        .toList();

    return CallerIdData(
      id: data['phoneNumber'] ?? '',
      phoneNumber: PhoneNumber.fromString(data['phoneNumber'] ?? ''),
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
  }

  @override
  Widget build(BuildContext context) {
    if (_callerIdData == null) {
      return const Material(
        color: Color.fromARGB(0, 250, 1, 1),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    // 【关键修改点】: 在 build 方法中 watch 新的 provider
    final asyncConfig = ref.watch(callerIdStyleSecurityProvider);
    debugPrint("当前配置:${asyncConfig.toString()}");
    return Material(
      color: Colors.transparent,
      child: asyncConfig.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (config) {
          // 在 Isolate 中，浮窗通常是可关闭的
           return GestureDetector(
            key: Key(_callerIdData!.id),
           
             onTap: () {
              // 当用户点击内容卡片时，触发关闭操作。
              debugPrint("Content tapped, closing overlay...");
              FloatingWindowAndroid.closeOverlayFromOverlay();
            },

            child: CallerIdContentBuilder.buildOverlayContainer(
              config: config,
              child: CallerIdContentBuilder.buildCallerIdContent(
                context: context,
                callerIdData: _callerIdData!,
                config: config,
                simInfo: _simInfo,
                stirInfo: _stirInfo,
                isDraggable: false, // 在真实来电中，元素不可拖动
              ),
            ),
            
          );
        },
      ),
    );
  }
}