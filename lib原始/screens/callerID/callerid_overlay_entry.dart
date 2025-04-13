import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../services/caller_id_monitor_service.dart';
import '../../services/caller_id_service.dart';
import '../../utils/language_provider.dart';
import '../../views/public/label_translation_extension.dart';
import 'callerid_configuration.dart';
import 'callerid_style_provider.dart';
import 'number_type_extension.dart';

class CallerIdOverlayEntry extends StatefulWidget {
  const CallerIdOverlayEntry({super.key});

  @override
  State<CallerIdOverlayEntry> createState() => _CallerIdOverlayEntryState();
}

class _CallerIdOverlayEntryState extends State<CallerIdOverlayEntry> {
  CallerIdData? _callerIdData;
  CallerIdStyleProvider? styleProvider; // 移除 late 关键字
  SimInfo? _simInfo;
  StirInfo? _stirInfo;

  @override
  void initState() {
    super.initState();
   // _loadDefaultStyle(); // 加载默认样式

    // 接收来自主应用程序的消息
    Isolate.current.addErrorListener(RawReceivePort((dynamic error) {
      // ... 处理错误
    })
        .sendPort);

    Isolate.current.addOnExitListener(RawReceivePort((dynamic message) {
      // ... 处理退出
    })
        .sendPort);

    final receivePort = ReceivePort(); // 使用 ReceivePort
    IsolateNameServer.registerPortWithName(
        receivePort.sendPort, '_overlayPort');

    receivePort.listen((dynamic message) {
      if (message is Map && message.containsKey('locale')) {
        // 更新 LocaleProvider
        Provider.of<LocaleProvider>(context, listen: false)
            .updateLocale(message['locale']);
      }
    });

    // 获取 CallerIdStyleProvider 实例
    styleProvider = Provider.of<CallerIdStyleProvider>(context, listen: false);


    FlutterOverlayWindow.overlayListener.listen((event) {
      setState(() {
        // 判断接收到的数据类型
        if (event is Map<String, dynamic> && event.containsKey("configType")) {
          String configType = event["configType"];

          if (configType == "callerIdStyle") {
            // 处理配置数据
            ConfigurationManager.updateConfigFromMap(event, styleProvider!);
          } else if (configType == "callerIdData") {
            // 处理 CallerIdData 数据
            _callerIdData = CallerIdData.fromJson(event);
          } else if (configType == "stirInfo") {
            // 处理 StirInfo 数据
            _stirInfo = StirInfo.fromJson(event);
          } else if (configType == "simInfo") {
            // 处理 SimInfo 数据
            _simInfo = SimInfo.fromJson(event);
          }
        }
      });

      // 检查 styleProvider 和 callerIdData 是否都已接收
      if (styleProvider != null && _callerIdData != null) {
        setState(() {}); // 触发重新构建
      }
    });
  }

  /*
// 加载默认样式
  Future<void> _loadDefaultStyle() async {
    final loadedStyleProvider =
        await ConfigurationManager.fromSharedPreferences();
        
    setState(() {
      styleProvider = loadedStyleProvider;
    });
  }
*/



  @override
  Widget build(BuildContext context) {
    // 如果 _callerIdData 不为空，则显示 CallerIdOverlay
    if (styleProvider != null && _callerIdData != null) {
      return Material(
        color: Colors.transparent,
        child: Consumer<CallerIdStyleProvider>(
          builder: (context, styleProvider, child) {
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
      return const Center(child: CircularProgressIndicator()); // 或其他加载指示器
    }
  }
}

//正式代码
class IsolateCallerIdOverlay extends StatefulWidget {
  final CallerIdData callerIdData;
  final SimInfo? simInfo;
  final StirInfo? stirInfo;
  final VoidCallback onDismiss;
  final bool isDismissible;
  final CallerIdStyleProvider styleProvider; // 添加 styleProvider 参数

  const IsolateCallerIdOverlay({
    super.key,
    required this.callerIdData,
    this.simInfo,
    this.stirInfo,
    required this.onDismiss,
    required this.isDismissible,
    required this.styleProvider, // 接收 styleProvider 参数
  });

  @override
  State<IsolateCallerIdOverlay> createState() => _IsolateCallerIdOverlayState();
}

class _IsolateCallerIdOverlayState extends State<IsolateCallerIdOverlay> {
  Offset _offset = const Offset(0, 0);
  double _opacity = 1.0;

  bool _isDismissed = false; // 添加变量记录是否被 dismiss

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
                ? _isDismissed // 使用条件渲染，如果已经被 dismiss，则不渲染 Dismissible
                    ? const SizedBox.shrink()
                    : Dismissible(
                        key: Key(widget.callerIdData.phoneNumber),
                        direction: DismissDirection.horizontal,
                        onDismissed: (_) {
                          setState(() {
                            _isDismissed = true; // 记录被 dismiss
                          });
                          FlutterOverlayWindow
                              .closeOverlay(); // 滑动关闭时也关闭 overlay
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

  // 提取 Container 内容到一个单独的函数中，提高代码的可读性
  Widget _buildOverlayContent(BuildContext context) {
    return Opacity(
      opacity: _opacity,
      child: Container(
        width: widget.styleProvider.windowWidth,
        height: widget.styleProvider.windowHeight,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: const Alignment(6.0, 1),
            end: const Alignment(-1, 6.0),
            colors: [
              widget.styleProvider.backgroundColorStart,
              widget.styleProvider.backgroundColorEnd,
            ],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: _buildCallerIdContent(widget.styleProvider),
      ),
    );
  }
//正式代码

  Widget _buildCallerIdContent(CallerIdStyleProvider styleProvider) {
    return Stack(
      children: <Widget>[
        //头像
        _buildElement(
          child: CircleAvatar(
            radius: styleProvider.avatarBorderSize / 2,
            backgroundColor: styleProvider.avatarBorderColor,
            child: CircleAvatar(
              radius: styleProvider.avatarSize / 2,
              backgroundImage: widget.callerIdData.avatarImage,
            ),
          ),
          position: styleProvider.avatarPosition,
        ),
        //运营商
        _buildElement(
          child: Text(
            widget.callerIdData.carrier ?? S.of(context).unknown,
            style: TextStyle(
              fontSize: styleProvider.carrierFontSize,
              color: styleProvider.textCarrierColor,
            ),
          ),
          position: styleProvider.carrierPosition,
        ),
        //name
        _buildElement(
          child: Text(
            widget.callerIdData.name == "Unknown"
                ? '${S.of(context).name}: ${S.of(context).unknown}'
                : '${S.of(context).name}: ${widget.callerIdData.name}',
            style: TextStyle(
              fontSize: styleProvider.nameFontSize,
              color: styleProvider.textNameColor,
            ),
          ),
          position: styleProvider.namePosition,
        ),
        //countryName
        _buildElement(
          child: Text(
            widget.callerIdData.countryName,
            style: TextStyle(
              fontSize: styleProvider.countryNameFontSize,
              color: styleProvider.textCountryNameColor,
            ),
          ),
          position: styleProvider.countryNamePosition,
        ),
        //label
        _buildElement(
          child: Row(
            children: [
              Icon(Icons.policy_outlined,
                  color: styleProvider.textIconLabelColor,
                  size: styleProvider.iconSize),
              const SizedBox(width: 5),
              Text(
                widget.callerIdData.labels
                    //.map((label) => label.label)
                    .map((label) =>
                        label.label.translate(context)) // 使用 translate 方法
                    .join(', '),
                style: TextStyle(
                  fontSize: styleProvider.labelsFontSize,
                  color: styleProvider.textLabelsColor,
                ),
              ),
            ],
          ),
          position: styleProvider.labelsPosition,
        ),
        //count
        _buildElement(
          child: Text(
            //widget.callerIdData.count?.toString() ?? 'Unknown',
            '${S.of(context).markedBy} ${widget.callerIdData.count?.toString() ?? S.of(context).unknown}', // 翻译 "Marked by"
            style: TextStyle(
              fontSize: styleProvider.countFontSize,
              color: styleProvider.textCountColor,
            ),
          ),
          position: styleProvider.countPosition,
        ),
        //numberType
        _buildElement(
          child: Text(
            // widget.callerIdData.numberType?.toString() ?? S.of(context).unknown,
            widget.callerIdData.numberType?.translated(context) ??
                S.of(context).unknown,
            style: TextStyle(
              fontSize: styleProvider.numberTypeFontSize,
              color: styleProvider.textNumberTypeColor,
            ),
          ),
          position: styleProvider.numberTypePosition,
        ),
        //电话号码
        _buildElement(
          child: Text(
            widget.callerIdData.phoneNumber,
            style: TextStyle(
              fontSize: styleProvider.numberFontSize,
              color: styleProvider.textNumberColor,
            ),
          ),
          position: styleProvider.numberPosition,
        ),
        //地理位置
        _buildElement(
          child: Row(
            children: [
              Icon(Icons.location_on,
                  color: styleProvider.textIconLocationColor,
                  size: styleProvider.iconSize),
              const SizedBox(width: 5),
              Text(
                widget.callerIdData.region ?? S.of(context).unknown,
                style: TextStyle(
                  fontSize: styleProvider.locationFontSize,
                  color: styleProvider.textLocationColor,
                ),
              ),
            ],
          ),
          position: styleProvider.locationPosition,
        ),

        //stir位置
        _buildElement(
          child: Text(
            // 直接使用 if-else if-else 语句
            widget.stirInfo?.isVerified == true
                ? S.of(context).verified
                : (widget.stirInfo?.isNotVerified == true
                    ? S.of(context).notVerified
                    : S.of(context).failed),
            style: TextStyle(
              fontSize: styleProvider.stirFontSize,
              color: styleProvider.textStirColor,
            ),
          ),
          position: styleProvider.stirPosition,
        ),

        //CallType位置
        _buildElement(
          child: Row(
            children: [
              Icon(
                widget.simInfo?.callType == "incoming"
                    ? Icons.call_received
                    : Icons.call_made,
                color: styleProvider.textIconCallTypeColor,
                size: styleProvider.iconSize,
              ),
              const SizedBox(width: 5),
              // ... other children ...
            ],
          ),
          position: styleProvider.callTypePosition,
        ),

        //SIM卡位置
        _buildElement(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5), // 半透明白色
              borderRadius: BorderRadius.circular(8.0), // 圆角
            ),
            padding: const EdgeInsets.symmetric(
                horizontal: 3.0, vertical: 3.0), // 内边距
            child: Row(
              children: [
                Text(
                  widget.simInfo?.simSlotIndex == 0
                      ? "SIM 1,-${widget.simInfo?.countryIso}"
                      : (widget.simInfo?.simSlotIndex != null
                          ? "SIM 2,-${widget.simInfo?.countryIso}"
                          : S.of(context).unknown),
                  style: TextStyle(
                    fontSize: styleProvider.simCardFontSize,
                    color: styleProvider.textSimCardColor,
                  ),
                ),
              ],
            ),
          ),
          position: styleProvider.simCardPosition,
        ),

        // Add more elements as needed
      ],
    );
  }

  Widget _buildElement({
    required Widget child,
    required Offset position,
  }) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: child,
    );
  }
}

//正式代码
