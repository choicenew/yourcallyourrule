import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:sim_card_info/sim_card_info.dart';
import 'package:sim_card_info/sim_info.dart';

import 'package:dlibphonenumber/dlibphonenumber.dart';
import 'package:dlibphonenumber/locale.dart' as dlibphone;
//import 'package:dlibphonenumber/locale.dart';

import 'package:provider/provider.dart';
import '../utils/language_provider.dart';
import 'package:rxdart/rxdart.dart';
import '../screens/callerID/callerid_overlay.dart';

import 'caller_id_service.dart';

class CallerIdMonitorService {
  static const callerIdChannel = MethodChannel('com.example.yourcallyourrule/caller_id');
  final CallerIdService _callerIdService;
  final _callerIdSubject = BehaviorSubject<CallerIdData>();
  Stream<CallerIdData> get callerIdStream => _callerIdSubject.stream;

  OverlayEntry? _currentOverlay;

  CallerIdMonitorService(this._callerIdService);
/*
 Future<void> initialize(BuildContext context) async {
  callerIdChannel.setMethodCallHandler((call) async {
    if (call.method == "onInitializationComplete") {
      try {
        final String result =
            await callerIdChannel.invokeMethod('initialize');
        print(result);
      } on PlatformException catch (e) {
        print(
            "Failed to initialize CallerIdMonitorService: '${e.message}'.");
      }
    } else if (call.method == 'onIncomingCall') {
      String phoneNumber = call.arguments['phoneNumber'];
      CallerIdData callerIdData = await _callerIdService.getCallerId(
          phoneNumber, context, Localizations.localeOf(context) as Locale);
      _callerIdSubject.add(callerIdData);
      showCallerIdOverlay(context, callerIdData);
    } else if (call.method == 'onCallEnded') {
      if (_currentOverlay != null) {
        enableOverlayDismissal();
      }
    }
    return null;
  });
}
*/

  Future<void> initialize(BuildContext context) async {
    // 1. 初始化 sim_card_info 插件
    final simCardInfoPlugin = SimCardInfo();

    callerIdChannel.setMethodCallHandler((call) async {
      if (call.method == "onCallerIdInitializationComplete") {
        try {
          final String result =
              await callerIdChannel.invokeMethod('initialize');
          print(result);
        } on PlatformException catch (e) {
          print("Failed to initialize CallerIdMonitorService: '${e.message}'.");
        }
      } else if (call.method == 'onIncomingCall') {
        String phoneNumber = call.arguments['phoneNumber'];

        // 2. 获取 SIM 卡信息
        List<SimInfo> simInfoList = await simCardInfoPlugin.getSimInfo() ?? [];
        List<String> simCountryCodes =
            simInfoList.map((sim) => sim.countryIso).toList();

        // 3. 尝试解析号码
        PhoneNumberUtil phoneNumberUtil = PhoneNumberUtil.instance;
        String? countryCode;
    String e164Number = "";

        // 判断号码是否包含国际区号
        RegExp internationalPrefixRegex = RegExp(r'^(?:\+|00)');

        if (internationalPrefixRegex.hasMatch(phoneNumber)) {
          // 包含国际区号， 使用 null 解析
          try {
            PhoneNumber parsedPhoneNumber =
                phoneNumberUtil.parse(phoneNumber, null);
            countryCode =
                phoneNumberUtil.getRegionCodeForNumber(parsedPhoneNumber);
                        e164Number =
            phoneNumberUtil.format(parsedPhoneNumber, PhoneNumberFormat.e164);
          } catch (e) {
           // print('Failed to parse with null: $e');
            // 可以添加额外的错误处理
          }
        } else {
          // 不包含国际区号， 使用 SIM 卡国家代码循环解析
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
                        e164Number =
            phoneNumberUtil.format(parsedPhoneNumber, PhoneNumberFormat.e164);
                break;
              }
            } catch (e) {
              print('Failed to parse with country code $simCountryCode: $e');
            }
            
         //3 特殊尝试添加国际区号到手机号码
        try {
          //  如果直接解析失败，尝试添加国家代码
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

        CallerIdData callerIdData = await _callerIdService.getCallerId(
            e164Number, context, dlibLocale);


        _callerIdSubject.add(callerIdData);
        showCallerIdOverlay(context, callerIdData);
      } else if (call.method == 'onCallEnded') {
        if (_currentOverlay != null) {
          enableOverlayDismissal();
        }
      }
      return null;
    });
  }
/*
  void showCallerIdOverlay(BuildContext context, CallerIdData callerIdData) {
    OverlayState? overlayState = Overlay.of(context);

    _currentOverlay = OverlayEntry(
      builder: (context) => CallerIdOverlay(
        callerIdData: callerIdData,
        onDismiss: () {
          _currentOverlay?.remove();
          _currentOverlay = null;
        },
        isDismissible: false, // 初始时不允许关闭
      ),
    );

    overlayState.insert(_currentOverlay!);
  }
*/
  void showCallerIdOverlay(BuildContext context, CallerIdData callerIdData) {
    print("CallerIdMonitorService: Attempting to show overlay for ${callerIdData.phoneNumber}");
    OverlayState? overlayState = Overlay.of(context);

    _currentOverlay = OverlayEntry(
      builder: (context) => CallerIdOverlay(
        callerIdData: callerIdData,
        onDismiss: () {
          print("CallerIdMonitorService: Overlay dismissed");
          _currentOverlay?.remove();
          _currentOverlay = null;
        },
        isDismissible: false,
      ),
    );

    try {
      overlayState.insert(_currentOverlay!);
      print("CallerIdMonitorService: Overlay inserted successfully");
    } catch (e) {
      print("CallerIdMonitorService: Error inserting overlay: $e");
    }
  }

  void enableOverlayDismissal() {
    if (_currentOverlay != null) {
      _currentOverlay = OverlayEntry(
        builder: (context) => CallerIdOverlay(
          callerIdData: _callerIdSubject.value,
          onDismiss: () {
            _currentOverlay?.remove();
            _currentOverlay = null;
          },
          isDismissible: true, // 允许关闭
        ),
      );
      _currentOverlay?.markNeedsBuild();
    }
  }

  void dispose() {
    _callerIdSubject.close();
    _currentOverlay?.remove();
    _currentOverlay = null;
  }
}

/*
class CallerIdOverlay extends StatefulWidget {
  final CallerIdData callerIdData;
  final VoidCallback onDismiss;
  final bool isDismissible;

  const CallerIdOverlay({
    Key? key,
    required this.callerIdData,
    required this.onDismiss,
    required this.isDismissible,
  }) : super(key: key);

  @override
  _CallerIdOverlayState createState() => _CallerIdOverlayState();
}

class _CallerIdOverlayState extends State<CallerIdOverlay> {
  Offset _offset = Offset(20, 20);
  double _opacity = 1.0;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: _offset.dx,
        top: _offset.dy,
        child: GestureDetector(
          onPanUpdate: (details) {
            setState(() {
              _offset += details.delta;
              // 确保 overlay 不会移出屏幕
              _offset = Offset(
                _offset.dx.clamp(0, MediaQuery.of(context).size.width - 300),
                _offset.dy.clamp(0, MediaQuery.of(context).size.height - 150),
              );
            });
          },
          child: widget.isDismissible
              ? Dismissible(
                  key: Key(widget.callerIdData.phoneNumber),
                  direction: DismissDirection.horizontal,
                  onDismissed: (_) => widget.onDismiss(),
                  onUpdate: (details) {
                    setState(() {
                      _opacity = 1.0 - details.progress;
                    });
                  },
                  child: _buildOverlayContent(),
                )
              : _buildOverlayContent(),
        ));
  }

  Widget _buildOverlayContent() {
    return Opacity(
      opacity: _opacity,
      child: Consumer<CallerIdStyleProvider>(
        builder: (context, styleProvider, child) {
          return Container(
            width: styleProvider.windowWidth,
            height: styleProvider.windowHeight,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(6.0, 1),
                end: Alignment(-1, 6.0),
                colors: [
                  styleProvider.backgroundColorStart,
                  styleProvider.backgroundColorEnd,
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: _buildCallerIdContent(styleProvider),
          );
        },
      ),
    );
  }

  Widget _buildCallerIdContent(CallerIdStyleProvider styleProvider) {
    return Stack(
      children: <Widget>[
        //头像
        _buildDraggableElement(
          child: CircleAvatar(
            radius: styleProvider.avatarSize / 2,
            backgroundImage: widget.callerIdData.avatarImage,
          ),
          onPositionChanged: styleProvider.updateAvatarPosition,
          position: styleProvider.avatarPosition,
        ),
        //运营商
        _buildDraggableElement(
          child: Text(
            widget.callerIdData.carrier ?? 'Unknown',
            style: TextStyle(
              fontSize: styleProvider.carrierFontSize,
              color: styleProvider.textCarrierColor,
            ),
          ),
          onPositionChanged: styleProvider.updateCarrierPosition,
          position: styleProvider.carrierPosition,
        ),
        //name
        _buildDraggableElement(
          child: Text(
            widget.callerIdData.name,
            style: TextStyle(
              fontSize: styleProvider.nameFontSize,
              color: styleProvider.textNameColor,
            ),
          ),
          onPositionChanged: styleProvider.updateNamePosition,
          position: styleProvider.namePosition,
        ),
        //countryName
        _buildDraggableElement(
          child: Text(
            widget.callerIdData.countryName,
            style: TextStyle(
              fontSize: styleProvider.countryNameFontSize,
              color: styleProvider.textCountryNameColor,
            ),
          ),
          onPositionChanged: styleProvider.updateCountryNamePosition,
          position: styleProvider.countryNamePosition,
        ),
        //label
        _buildDraggableElement(
          child: Row(
            children: [
              Icon(Icons.policy_outlined,
                  color: styleProvider.textIconLabelColor,
                  size: styleProvider.iconSize),
              SizedBox(width: 5),
              Text(
                widget.callerIdData.labels
                    .map((label) => label.label)
                    .join(', '),
                style: TextStyle(
                  fontSize: styleProvider.labelsFontSize,
                  color: styleProvider.textLabelsColor,
                ),
              ),
            ],
          ),
          onPositionChanged: styleProvider.updateLabelsPosition,
          position: styleProvider.labelsPosition,
        ),
        //count
        _buildDraggableElement(
          child: Text(
            widget.callerIdData.count?.toString() ?? 'Unknown',
            style: TextStyle(
              fontSize: styleProvider.countFontSize,
              color: styleProvider.textCountColor,
            ),
          ),
          onPositionChanged: styleProvider.updateCountPosition,
          position: styleProvider.countPosition,
        ),
        //numberType
        _buildDraggableElement(
          child: Text(
            widget.callerIdData.numberType?.toString() ?? 'Unknown',
            style: TextStyle(
              fontSize: styleProvider.numberTypeFontSize,
              color: styleProvider.textNumberTypeColor,
            ),
          ),
          onPositionChanged: styleProvider.updateNumberTypePosition,
          position: styleProvider.numberTypePosition,
        ),
        //电话号码
        _buildDraggableElement(
          child: Text(
            widget.callerIdData.phoneNumber,
            style: TextStyle(
              fontSize: styleProvider.numberFontSize,
              color: styleProvider.textNumberColor,
            ),
          ),
          onPositionChanged: styleProvider.updateNumberPosition,
          position: styleProvider.numberPosition,
        ),
        //地理位置
        _buildDraggableElement(
          child: Row(
            children: [
              Icon(Icons.location_on,
                  color: styleProvider.textIconLocationColor,
                  size: styleProvider.iconSize),
              SizedBox(width: 5),
              Text(
                widget.callerIdData.region ?? 'Unknown',
                style: TextStyle(
                  fontSize: styleProvider.locationFontSize,
                  color: styleProvider.textLocationColor,
                ),
              ),
            ],
          ),
          onPositionChanged: styleProvider.updateLocationPosition,
          position: styleProvider.locationPosition,
        ),
        // Add more elements as needed
      ],
    );
  }

  Widget _buildDraggableElement({
    required Widget child,
    required Function(Offset) onPositionChanged,
    required Offset position,
  }) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: GestureDetector(
        onPanUpdate: (details) {
          onPositionChanged(position + details.delta);
        },
        child: child,
      ),
    );
  }
}


class CallerIdCustomizationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Customize Caller ID')),
      body: Consumer<CallerIdStyleProvider>(
        builder: (context, styleProvider, child) {
          return ListView(
            padding: EdgeInsets.all(16),
            children: [
              Text('Background Gradient',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              ColorPicker(
                color: styleProvider.backgroundColorStart,
                onColorChanged: (color) =>
                    styleProvider.setBackgroundColorStart(color),
              ),
              ColorPicker(
                color: styleProvider.backgroundColorEnd,
                onColorChanged: (color) =>
                    styleProvider.setBackgroundColorEnd(color),
              ),
              SizedBox(height: 20),
              Text('Text Colors',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              _buildColorPicker('Name Color', styleProvider.textNameColor,
                  (color) => styleProvider.setTextNameColor(color)),
              _buildColorPicker('Number Color', styleProvider.textNumberColor,
                  (color) => styleProvider.setTextNumberColor(color)),
              _buildColorPicker(
                  'Location Color',
                  styleProvider.textLocationColor,
                  (color) => styleProvider.setTextLocationColor(color)),
              _buildColorPicker('Carrier Color', styleProvider.textCarrierColor,
                  (color) => styleProvider.setTextCarrierColor(color)),
              _buildColorPicker(
                  'Country Name Color',
                  styleProvider.textCountryNameColor,
                  (color) => styleProvider.setTextCountryNameColor(color)),
              _buildColorPicker('Labels Color', styleProvider.textLabelsColor,
                  (color) => styleProvider.setTextLabelsColor(color)),
              _buildColorPicker('Count Color', styleProvider.textCountColor,
                  (color) => styleProvider.setTextCountColor(color)),
              _buildColorPicker(
                  'Number Type Color',
                  styleProvider.textNumberTypeColor,
                  (color) => styleProvider.setTextNumberTypeColor(color)),
              SizedBox(height: 20),
              Text('Font Sizes', style: TextStyle(fontWeight: FontWeight.bold)),
              _buildSlider('Name Font Size', styleProvider.nameFontSize, 12, 24,
                  (value) => styleProvider.setNameFontSize(value)),
              _buildSlider('Number Font Size', styleProvider.numberFontSize, 12,
                  24, (value) => styleProvider.setNumberFontSize(value)),
              _buildSlider('Location Font Size', styleProvider.locationFontSize,
                  12, 24, (value) => styleProvider.setLocationFontSize(value)),
              _buildSlider('Carrier Font Size', styleProvider.carrierFontSize,
                  12, 24, (value) => styleProvider.setCarrierFontSize(value)),
              _buildSlider(
                  'Country Name Font Size',
                  styleProvider.countryNameFontSize,
                  12,
                  24,
                  (value) => styleProvider.setCountryNameFontSize(value)),
              _buildSlider('Labels Font Size', styleProvider.labelsFontSize, 12,
                  24, (value) => styleProvider.setLabelsFontSize(value)),
              _buildSlider('Count Font Size', styleProvider.countFontSize, 12,
                  24, (value) => styleProvider.setCountFontSize(value)),
              _buildSlider(
                  'Number Type Font Size',
                  styleProvider.numberTypeFontSize,
                  12,
                  24,
                  (value) => styleProvider.setNumberTypeFontSize(value)),
              SizedBox(height: 20),
              Text('Avatar Size',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              _buildSlider('Avatar Size', styleProvider.avatarSize, 40, 80,
                  (value) => styleProvider.setAvatarSize(value)),
              SizedBox(height: 20),
              Text('Icon Size', style: TextStyle(fontWeight: FontWeight.bold)),
              _buildSlider('Icon Size', styleProvider.iconSize, 16, 32,
                  (value) => styleProvider.setIconSize(value)),
              SizedBox(height: 20),
              Text('Window Size',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              _buildSlider(
                  'Width',
                  styleProvider.windowWidth,
                  200,
                  400,
                  (value) => styleProvider.setWindowSize(
                      value, styleProvider.windowHeight)),
              _buildSlider(
                  'Height',
                  styleProvider.windowHeight,
                  100,
                  300,
                  (value) => styleProvider.setWindowSize(
                      styleProvider.windowWidth, value)),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Preview Caller ID'),
                onPressed: () {
                  _showPreview(context, styleProvider);
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildColorPicker(
      String label, Color color, Function(Color) onChanged) {
    return Row(
      children: [
        Expanded(child: Text(label)),
        ColorPicker(color: color, onColorChanged: onChanged),
      ],
    );
  }

  Widget _buildSlider(String label, double value, double min, double max,
      Function(double) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: ((max - min) / 2).round(),
          label: value.round().toString(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  void _showPreview(BuildContext context, CallerIdStyleProvider styleProvider) {
    // Create a mock CallerIdData
    CallerIdData mockData = CallerIdData(
      phoneNumber: '+1 234 567 8900',
      countryName: 'United States',
      region: 'New York',
      carrier: 'Example Carrier',
      numberType: PhoneNumberType.mobile,
      labels: [Label(label: 'Personal')],
      name: 'John Doe',
      avatar: 'assets/default_avatar.png',
      count: 5,
    );

    showDialog(
      context: context,
      builder: (context) => Stack(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(color: Colors.black.withOpacity(0.5)),
          ),
          CallerIdOverlay(
            callerIdData: mockData,
            onDismiss: () => Navigator.of(context).pop(),
            isDismissible: true,
          ),
        ],
      ),
    );
  }
}

class ColorPicker extends StatelessWidget {
  final Color color;
  final ValueChanged<Color> onColorChanged;

  ColorPicker({required this.color, required this.onColorChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: Colors.primaries.length,
        itemBuilder: (context, index) {
          final itemColor = Colors.primaries[index];
          return GestureDetector(
            onTap: () => onColorChanged(itemColor),
            child: Container(
              width: 50,
              height: 50,
              color: itemColor,
              child: itemColor == color
                  ? Icon(Icons.check, color: Colors.white)
                  : null,
            ),
          );
        },
      ),
    );
  }
}
*/
