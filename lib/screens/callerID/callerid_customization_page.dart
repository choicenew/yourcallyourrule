import 'package:dlibphonenumber/dlibphonenumber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';

import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../screens/callerID/callerid_overlay.dart';
import '../../services/caller_id_monitor_service.dart';
import '../../services/caller_id_service.dart';
import '../../utils/ad_manager.dart';
import '../../utils/global_variable.dart';
import '../../widgets/adwidgets/native_ads.dart';
import '../../widgets/google_ad.dart';
import '../../widgets/hsv_color_picker.dart';

import 'callerid_configuration.dart';
import 'callerid_style_provider.dart';

// 用于自定义 CallerID 样式的设置页面
class CallerIdCustomizationPage extends StatefulWidget {
  const CallerIdCustomizationPage({super.key});

  @override
  State<CallerIdCustomizationPage> createState() =>
      _CallerIdCustomizationPageState();
}

class _CallerIdCustomizationPageState extends State<CallerIdCustomizationPage> {
  // 用于控制各个设置项的展开/收起状态
  final List<bool> _isExpanded = List.generate(6, (_) => false);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final styleProvider =
          Provider.of<CallerIdStyleProvider>(context, listen: false);
      try {
        ConfigurationManager.loadConfiguration(styleProvider);
      } catch (e) {
 
        // Create and save a default configuration
        ConfigurationManager.saveConfiguration(styleProvider);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).customizeCallerId)),
      body: Consumer<CallerIdStyleProvider>(
        builder: (context, styleProvider, child) {
          return Column(
            children: [
              // 预览区域
              Container(
                width: styleProvider.windowWidth,
                height: styleProvider.windowHeight,
                alignment: Alignment.center,
                child: CallerIdOverlay(
                  callerIdData: _mockCallerIdData(),
                  simInfo: _mockSimInfoData(),
                  stirInfo: _mockStirInfoData(),
                  onDismiss: () {},
                  isDismissible: false,
                ),
              ),

              Expanded(
                // Use Expanded within the Column
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    const Divider(),
                    const GoogleAdWidget(
                        adInfo: AdManager
                            .bannerAd), // Replace with your actual AdWidget
                    const Divider(),
                    // 样式设置项
                    _buildExpansionTile(S.of(context).windowSize, 0,
                        _buildWindowSizeSliders(styleProvider), styleProvider),
                    _buildExpansionTile(S.of(context).backgroundGradient, 1,
                        _buildBackgroundGradient(styleProvider), styleProvider),
                    _buildExpansionTile(S.of(context).textLabelColors, 2,
                        _buildTextColors(styleProvider), styleProvider),
                    _buildExpansionTile('Font Sizes', 3,
                        _buildFontSizes(styleProvider), styleProvider),
                    _buildExpansionTile(S.of(context).avatarAndIconSizes, 4,
                        _buildAvatarAndIconSizes(styleProvider), styleProvider),
                    _buildExpansionTile(S.of(context).elementPositions, 5,
                        _buildElementPositions(styleProvider), styleProvider),
                    //广告代码
                    nativeAdWidgetMedium(
                        adWidth: 320,
                        adHeight: 320), // Replace with your actual AdWidget
                  ],
                ),
              ),

              // 按钮区域
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FilledButton(
                      onPressed: () async {
                        try {
                          ConfigurationManager.importConfiguration(
                              context, styleProvider);
                          // 显示 SnackBar
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(S
                                    .of(context)
                                    .configurationImportedSuccessfully)),
                          );
                        } catch (e) {
                          // 处理 JSON 解析错误
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(S.of(context).invalidJsonFormat)),
                          );
                        }
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.amber,
                      ),
                      child: Text(S.of(context).import),
                    ),
                    FilledButton(
                      onPressed: () async {
                        await ConfigurationManager.exportConfiguration(
                            styleProvider);
                        // 显示 SnackBar
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  S.of(context).configurationExportedToFile)),
                        );
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.green[400],
                      ),
                      child: Text(S.of(context).export),
                    ),
                    FilledButton(
                      onPressed: () async {
                        _showPreview(context, styleProvider); //临时测试
                        // 保存配置 (此处仅为示例，实际保存逻辑需根据应用需求实现)
                      await  ConfigurationManager.toSharedPreferences(styleProvider);
                        await ConfigurationManager.saveConfiguration(
                            styleProvider);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(S.of(context).configurationSaved)),
                        );
                        // 传输配置给isolated overlay
                        //  await updateAndShareConfiguration(styleProvider);
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.pink[300],
                      ),
                      child: Text(S.of(context).save),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }


  Future<void> updateAndShareConfiguration(
      CallerIdStyleProvider styleProvider) async {
    // 传输配置给 isolated overlay
    final styleProviderData = ConfigurationManager.getConfigMap(styleProvider);

    // 添加 configType 标识
    final dataToSend = {
      "configType": "callerIdStyle",
      ...styleProviderData,
    };

    // 传递 Map 对象
    FlutterOverlayWindow.shareData(dataToSend);
  }

//用于测试浮动窗口的

  OverlayPosition? storedPosition;

  Future<void> _showPreview(
      BuildContext context, CallerIdStyleProvider styleProvider) async {
    // if (await FlutterOverlayWindow.isPermissionGranted()) return;
    await updateAndShareConfiguration(styleProvider);

    CallerIdData mockCallerIdData = CallerIdData(
      phoneNumber: '+12345678900',
      countryName: 'United States',
      region: 'New York',
      carrier: 'Example Carrier',
      numberType: PhoneNumberType.fixedLineOrMobile,
      labels: [Label(label: 'Robocall')],
      name: 'John Doe',
      avatar: 'assets/avatars/Unknown.png',
      count: 5,
    );

// 模拟 StirInfo 数据，基于 _mockCallerIdData 中的 phoneNumber
// 模拟 StirInfo 数据，基于 CallerIdData 中的 phoneNumber
    StirInfo mockStirInfoData = StirInfo(
      isVerified: true, // 模拟已验证状态
      isNotVerified: false, // 模拟未验证状态
      isFailed: false, // 模拟验证失败状态
      phoneNumber:
          mockCallerIdData.phoneNumber, // 使用 CallerIdData 中的 phoneNumber
    );

// 模拟 SimInfo 数据
    SimInfo mockSimInfoData = SimInfo(
      carrierName: 'Example Carrier',
      displayName: 'SIM 1',
      iccId: '8901234567890123456',
      countryIso: 'US',
      phoneNumber: '+1 234 567 8900',
      simSlotIndex: 0,
      subscriptionId: 1,
      mccString: '310',
      mncString: '410',
      simPhoneNumber: '+1 123 456 7890',
      callType: "audio",
    );

    // 获取当前 Overlay 位置，如果 Overlay 处于激活状态
    if (await FlutterOverlayWindow.isActive()) {
      storedPosition = await FlutterOverlayWindow.getOverlayPosition();
    } else {
      // 如果 Overlay 未激活，则初始化位置或使用默认位置
      storedPosition = storedPosition ?? const OverlayPosition(0, 0);
    }

    // 使用 FlutterOverlayWindow.shareData() 将 CallerIdData 发送到 Overlay Isolate
    // await FlutterOverlayWindow.shareData(mockCallerIdData);
    await FlutterOverlayWindow.shareData({
      "configType": "callerIdData", // 添加 configType 字段
      ...mockCallerIdData.toJson(),
    });

    //传递stir信息
    await FlutterOverlayWindow.shareData({
      "configType": "stirInfo", // 添加 configType 字段
      ...mockStirInfoData.toJson(),
    });
    // 传递 SIM 信息

    await FlutterOverlayWindow.shareData({
      "configType": "simInfo", // 添加 configType 字段
      ...mockSimInfoData.toJson(),
    });

    if (await FlutterOverlayWindow.isActive()) {
      // 如果 Overlay 已经激活，则更新其位置
      await FlutterOverlayWindow.moveOverlay(storedPosition!);
      await FlutterOverlayWindow.closeOverlay();
    } else {
      // 如果 Overlay 未激活，则显示 Overlay 并设置初始位置
      await FlutterOverlayWindow.showOverlay(
        enableDrag: true,
        overlayTitle: "Incoming",
        overlayContent:
            "name:${mockCallerIdData.name},region:${mockCallerIdData.countryName},carrier:${mockCallerIdData.carrier}",
        alignment: OverlayAlignment.center,
        flag: OverlayFlag.defaultFlag,
        visibility: NotificationVisibility.visibilityPublic,
        positionGravity: PositionGravity.auto,
        height: (styleProvider.windowHeight * (pixelRatio ?? 1.0))
            .toInt(), // 使用 styleProvider.windowHeight
        width: (styleProvider.windowWidth * (pixelRatio ?? 1.0)).toInt(),
        startPosition: storedPosition!,
      );
    }
  }



  // 构建可折叠设置项
  Widget _buildExpansionTile(String title, int index, Widget content,
      CallerIdStyleProvider styleProvider) {
    return ExpansionTile(
      title: Text(title),
      initiallyExpanded: _isExpanded[index],
      onExpansionChanged: (expanded) =>
          setState(() => _isExpanded[index] = expanded),
      children: [
        content,
      ],
    );
  }

  // 构建窗口大小设置滑块
  Widget _buildWindowSizeSliders(CallerIdStyleProvider styleProvider) {
    return Column(
      children: [
        _buildSlider(
            S.of(context).width,
            styleProvider.windowWidth,
            200,
            400,
            (value) =>
                styleProvider.setWindowSize(value, styleProvider.windowHeight)),
        _buildSlider(
            S.of(context).height,
            styleProvider.windowHeight,
            100,
            300,
            (value) =>
                styleProvider.setWindowSize(styleProvider.windowWidth, value)),
      ],
    );
  }

  // 构建背景渐变设置
  Widget _buildBackgroundGradient(CallerIdStyleProvider styleProvider) {
    return Column(
      children: [
        _buildColorPicker(
            S.of(context).startColor,
            styleProvider.backgroundColorStart,
            (color) => styleProvider.setBackgroundColorStart(color)),
        _buildColorPicker(
            S.of(context).endColor,
            styleProvider.backgroundColorEnd,
            (color) => styleProvider.setBackgroundColorEnd(color)),
      ],
    );
  }

  // 构建文字颜色设置
  Widget _buildTextColors(CallerIdStyleProvider styleProvider) {
    return Column(
      children: [
        _buildColorPicker(
            S.of(context).labelIconColor,
            styleProvider.textIconLabelColor,
            (color) => styleProvider.setTextIconLabelColor(color)),
        _buildColorPicker(
            S.of(context).locationIconColor,
            styleProvider.textIconLocationColor,
            (color) => styleProvider.setTextIconLocationColor(color)),
//call type颜色
        _buildColorPicker(
            S.of(context).calltypeIconColor,
            styleProvider.textIconCallTypeColor,
            (color) => styleProvider.setTextIconCallTypeColor(color)),

        _buildColorPicker(
            S.of(context).avatarBorderColor,
            styleProvider.avatarBorderColor,
            (color) => styleProvider.setAvatarBorderColor(color)),

        _buildColorPicker(S.of(context).nameColor, styleProvider.textNameColor,
            (color) => styleProvider.setTextNameColor(color)),
        _buildColorPicker(
            S.of(context).numberColor,
            styleProvider.textNumberColor,
            (color) => styleProvider.setTextNumberColor(color)),
        _buildColorPicker(
            S.of(context).locationColor,
            styleProvider.textLocationColor,
            (color) => styleProvider.setTextLocationColor(color)),
        _buildColorPicker(
            S.of(context).carrierColor,
            styleProvider.textCarrierColor,
            (color) => styleProvider.setTextCarrierColor(color)),
        _buildColorPicker(
            S.of(context).countryNameColor,
            styleProvider.textCountryNameColor,
            (color) => styleProvider.setTextCountryNameColor(color)),
        //    _buildColorPicker('Region Color', styleProvider.textRegionColor,
        //       (color) => styleProvider.setTextRegionColor(color)),

        _buildColorPicker(
            S.of(context).labelsColor,
            styleProvider.textLabelsColor,
            (color) => styleProvider.setTextLabelsColor(color)),
        _buildColorPicker(
            S.of(context).countColor,
            styleProvider.textCountColor,
            (color) => styleProvider.setTextCountColor(color)),
        _buildColorPicker(
            S.of(context).numberTypeColor,
            styleProvider.textNumberTypeColor,
            (color) => styleProvider.setTextNumberTypeColor(color)),
//stir颜色
        _buildColorPicker(S.of(context).stirColor, styleProvider.textStirColor,
            (color) => styleProvider.setTextStirColor(color)),
//Sim卡颜色
        _buildColorPicker(
            S.of(context).simCardColor,
            styleProvider.textSimCardColor,
            (color) => styleProvider.setTextSimCardColor(color)),
        //添加其他的
      ],
    );
  }

  // 构建字体大小设置
  Widget _buildFontSizes(CallerIdStyleProvider styleProvider) {
    return Column(
      children: [
        _buildSlider(S.of(context).nameFontSize, styleProvider.nameFontSize, 12,
            24, (value) => styleProvider.setNameFontSize(value)),
        _buildSlider(
            S.of(context).carrierFontSize,
            styleProvider.carrierFontSize,
            12,
            24,
            (value) => styleProvider.setCarrierFontSize(value)),
        _buildSlider(
            S.of(context).countryNameFontSize,
            styleProvider.countryNameFontSize,
            12,
            24,
            (value) => styleProvider.setCountryNameFontSize(value)),
        _buildSlider(S.of(context).labelsFontSize, styleProvider.labelsFontSize,
            12, 24, (value) => styleProvider.setLabelsFontSize(value)),
        _buildSlider(S.of(context).countFontSize, styleProvider.countFontSize,
            12, 24, (value) => styleProvider.setCountFontSize(value)),
        _buildSlider(
            S.of(context).numberTypeFontSize,
            styleProvider.numberTypeFontSize,
            12,
            24,
            (value) => styleProvider.setNumberTypeFontSize(value)),
        _buildSlider(S.of(context).numberFontSize, styleProvider.numberFontSize,
            12, 24, (value) => styleProvider.setNumberFontSize(value)),
        _buildSlider(
            S.of(context).locationFontSize,
            styleProvider.locationFontSize,
            12,
            24,
            (value) => styleProvider.setLocationFontSize(value)),
        //Stir文字尺寸
        _buildSlider(S.of(context).stirFontSize, styleProvider.stirFontSize, 12,
            24, (value) => styleProvider.setStirFontSize(value)),
        //SIm卡文字尺寸
        _buildSlider(
            S.of(context).simCardFontSize,
            styleProvider.simCardFontSize,
            12,
            24,
            (value) => styleProvider.setSimCardFontSize(value)),
        //其他的
      ],
    );
  }

  // 构建头像和图标大小设置
  Widget _buildAvatarAndIconSizes(CallerIdStyleProvider styleProvider) {
    return Column(
      children: [
        _buildSlider(S.of(context).avatarSize, styleProvider.avatarSize, 40, 80,
            (value) => styleProvider.setAvatarSize(value)),
        _buildSlider(
            S.of(context).avatarBorderSize,
            styleProvider.avatarBorderSize,
            40,
            80,
            (value) => styleProvider.setAvatarBorderSize(value)),
        _buildSlider(S.of(context).iconSize, styleProvider.iconSize, 16, 32,
            (value) => styleProvider.setIconSize(value)),
      ],
    );
  }

  // 构建元素位置设置
// 构建元素位置设置 (重新添加)
  Widget _buildElementPositions(CallerIdStyleProvider styleProvider) {
    return Column(
      children: [
        _buildPositionSlider(
            S.of(context).avatarPosition,
            styleProvider.avatarPosition,
            (offset) => styleProvider.updateAvatarPosition(offset)),
        _buildPositionSlider(
            S.of(context).namePosition,
            styleProvider.namePosition,
            (offset) => styleProvider.updateNamePosition(offset)),
        _buildPositionSlider(
            S.of(context).carrierPosition,
            styleProvider.carrierPosition,
            (offset) => styleProvider.updateCarrierPosition(offset)),
        _buildPositionSlider(
            S.of(context).countryNamePosition,
            styleProvider.countryNamePosition,
            (offset) => styleProvider.updateCountryNamePosition(offset)),
        _buildPositionSlider(
            S.of(context).labelsPosition,
            styleProvider.labelsPosition,
            (offset) => styleProvider.updateLabelsPosition(offset)),
        _buildPositionSlider(
            S.of(context).countPosition,
            styleProvider.countPosition,
            (offset) => styleProvider.updateCountPosition(offset)),
        _buildPositionSlider(
            S.of(context).numberTypePosition,
            styleProvider.numberTypePosition,
            (offset) => styleProvider.updateNumberTypePosition(offset)),
        _buildPositionSlider(
            S.of(context).numberPosition,
            styleProvider.numberPosition,
            (offset) => styleProvider.updateNumberPosition(offset)),
        _buildPositionSlider(
            S.of(context).locationPosition,
            styleProvider.locationPosition,
            (offset) => styleProvider.updateLocationPosition(offset)),
//stir位置
        _buildPositionSlider(
            S.of(context).stirPosition,
            styleProvider.stirPosition,
            (offset) => styleProvider.updateStirPosition(offset)),
        //Sim card位置
        _buildPositionSlider(
            S.of(context).simCardPosition,
            styleProvider.simCardPosition,
            (offset) => styleProvider.updateSimCardPosition(offset)),

        // ... 元素位置设置
      ],
    );
  }

  // 构建位置滑块
  Widget _buildPositionSlider(
      String label, Offset offset, Function(Offset) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label), // Display the label
        const SizedBox(height: 10), // Add some spacing
        Row(
          children: [
            Expanded(
              child: Slider(
                value: offset.dx,
                min: 0,
                max: 400, // Adjust max value as needed
                label: offset.dx.round().toString(),
                onChanged: (value) => onChanged(Offset(value, offset.dy)),
              ),
            ),
            Text('X: ${offset.dx.round()}'),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Slider(
                value: offset.dy,
                min: 0,
                max: 300, // Adjust max value as needed
                label: offset.dy.round().toString(),
                onChanged: (value) => onChanged(Offset(offset.dx, value)),
              ),
            ),
            Text('Y: ${offset.dy.round()}'),
          ],
        ),
      ],
    );
  }

  Widget _buildColorPicker(
      String label, Color color, Function(Color) onChanged) {
    return Row(
      children: [
        Expanded(child: Text(label)),
        ElevatedButton(
          // Use a button to trigger the dialog
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  child: SizedBox(
                    // Wrap with SizedBox and provide a height
                    height: 600, // Adjust the height as needed
                    child: HSVColorPicker(
                      pickerColor: color,
                      onColorChanged: onChanged,
                    ),
                  ),
                );
              },
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shadowColor: color.withOpacity(1),
            elevation: 10,
          ),
          child: Text(S.of(context).selectColor),
        ),
      ],
    );
  }

  // 构建数值滑块
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



  // 模拟 CallerIdData 数据
  CallerIdData _mockCallerIdData() {
    return CallerIdData(
      phoneNumber: '+1 234 567 8900',
      countryName: 'United States',
      region: 'New York',
      carrier: 'Example Carrier',
      numberType: PhoneNumberType.fixedLineOrMobile,
      labels: [Label(label: 'Other')],
      name: 'Example Name',
      avatar: 'assets/avatars/Other.png',
      count: 5,
    );
  }

// 模拟 stirInfo 数据，基于 _mockCallerIdData 中的 phoneNumber
// 模拟 StirInfo 数据，基于 _mockCallerIdData 中的 phoneNumber
  StirInfo _mockStirInfoData() {
    CallerIdData callerIdData = _mockCallerIdData();
    String phoneNumber = callerIdData.phoneNumber; // 获取 phoneNumber

    // 模拟验证状态，你可以根据需要修改
    bool isVerified = true;
    bool isNotVerified = false;
    bool isFailed = false;

    return StirInfo(
      isVerified: isVerified,
      isNotVerified: isNotVerified,
      isFailed: isFailed,
      phoneNumber: phoneNumber, // 将 phoneNumber 传递给 StirInfo
    );
  }

// 模拟 SimInfo 数据
  SimInfo _mockSimInfoData() {
    return SimInfo(
      carrierName: 'Example Carrier',
      displayName: 'SIM 1',
      iccId: '8901234567890123456',
      countryIso: 'US',
      phoneNumber: '+1 234 567 8900',
      simSlotIndex: 0,
      subscriptionId: 1,
      mccString: '310',
      mncString: '410',
      simPhoneNumber: '+1 123 456 7890',
      callType: "audio",
    );
  }
}
