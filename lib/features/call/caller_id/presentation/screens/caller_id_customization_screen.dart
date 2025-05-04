import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:provider/provider.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/adwidgets/native_ads.dart';
import 'package:yourcallyourrule/ads/google_ad.dart';

import 'package:yourcallyourrule/data/repositories/call/config_repository.dart';


import 'package:yourcallyourrule/features/caller_id/services/call_handlers/overlay_handler.dart';

import '../../configuration/configuration_manager.dart';
import '../../mock_data/caller_id_mock.dart';
import '../../providers/caller_id_style_provider.dart';
import '../widgets/caller_id_overlay.dart';
import '../widgets/customization/button_panel.dart';
import '../widgets/customization/color_panel.dart';
import '../widgets/customization/size_panel.dart';

/// 来电显示自定义页面
/// 允许用户自定义来电显示的样式、颜色、位置等
class CallerIdCustomizationScreen extends StatefulWidget {
  const CallerIdCustomizationScreen({super.key});

  @override
  State<CallerIdCustomizationScreen> createState() =>
      _CallerIdCustomizationScreenState();
}

class _CallerIdCustomizationScreenState
    extends State<CallerIdCustomizationScreen> {
  // 用于控制各个设置项的展开/收起状态
  final List<bool> _isExpanded = List.generate(6, (_) => false);
  OverlayPosition? storedPosition;
  late final ConfigRepository _configRepository;
  late final ConfigurationManager _configurationManager;

  @override
  void initState() {
    super.initState();
    // Initialize configuration repository and manager
    _configRepository = SharedPreferencesConfigRepository();
    _configurationManager = ConfigurationManager(_configRepository);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final styleProvider =
          Provider.of<CallerIdStyleProvider>(context, listen: false);
      _configurationManager.loadFromRepository(styleProvider).catchError((e) {
        // If loading fails (e.g., no saved config), save the default config
        _configurationManager.saveToRepository(styleProvider);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Customize Caller ID')),
      body: Consumer<CallerIdStyleProvider>(
        builder: (context, styleProvider, child) {
          return Column(
            children: [
              // Preview Area
              Container(
                width: styleProvider.windowWidth,
                height: styleProvider.windowHeight,
                alignment: Alignment.center,
                child: CallerIdOverlay(
                  callerIdData: CallerIdMockData.mockCallerIdData(),
                  simInfo: CallerIdMockData.mockSimInfoData(),
                  stirInfo: CallerIdMockData.mockStirInfoData(),
                  onDismiss: () {},
                  isDismissible: false,
                ),
              ),

              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    const Divider(),
                    const GoogleAdWidget(adInfo: AdManager.bannerAd),
                    const Divider(),
                    // Style settings
                    _buildExpansionTile('Window Size', 0,
                        _buildWindowSizeSliders(styleProvider), styleProvider),
                    _buildExpansionTile('Background Gradient', 1,
                        _buildBackgroundGradient(styleProvider), styleProvider),
                    _buildExpansionTile('Text & Label Colors', 2,
                        _buildTextColors(styleProvider), styleProvider),
                    _buildExpansionTile('Font Sizes', 3,
                        _buildFontSizes(styleProvider), styleProvider),
                    _buildExpansionTile('Avatar & Icon Sizes', 4,
                        _buildAvatarAndIconSizes(styleProvider), styleProvider),
                    _buildExpansionTile('Element Positions', 5,
                        _buildElementPositions(styleProvider), styleProvider),
                    // Ad
                    nativeAdWidgetMedium(adWidth: 320, adHeight: 320),
                  ],
                ),
              ),

              // Button Area
              ButtonPanel(
                styleProvider: styleProvider,
                configurationManager: _configurationManager,
                onPreviewPressed: _showPreview,
              ),
            ],
          );
        },
      ),
    );
  }

/*
  /// Update and share configuration to the overlay
  Future<void> updateAndShareConfiguration(
      CallerIdStyleProvider styleProvider) async {
    final config = CallerIdConfigX.fromStyleProvider(styleProvider);

    // 添加 configType 标识
    final dataToSend = {
      "configType": "callerIdStyle",
      ...config.toMap(),
    };

    // Pass Map object
    FlutterOverlayWindow.shareData(dataToSend);
  }
*/
 
  /// Show preview
  Future<void> _showPreview(
      BuildContext context, CallerIdStyleProvider styleProvider) async {
    // 使用 OverlayHandler 替代原有实现
    final overlayHandler = OverlayHandler();
    final mockData = CallerIdMockData.mockCallerIdData();
    final stirInfo = CallerIdMockData.mockStirInfoData();
    final simInfo = CallerIdMockData.mockSimInfoData();

    // 设置像素密度比例
    final mediaQuery = MediaQuery.of(context);
    overlayHandler.setPixelRatio(mediaQuery.devicePixelRatio);

    // 调用OverlayHandler的统一配置更新方法
    await overlayHandler.updateAndShareConfiguration(styleProvider);

    // 显示标准化浮窗
    await overlayHandler.showCallerIdOverlay(mockData, stirInfo, simInfo);
  }

  /// Build collapsible setting item
  Widget _buildExpansionTile(String title, int index, Widget content,
      CallerIdStyleProvider styleProvider) {
    return ExpansionTile(
      title: Text(title),
      initiallyExpanded: _isExpanded[index],
      onExpansionChanged: (expanded) =>
          setState(() => _isExpanded[index] = expanded),
      children: [content],
    );
  }

  /// Build window size setting sliders
  Widget _buildWindowSizeSliders(CallerIdStyleProvider styleProvider) {
    return Column(
      children: [
        _buildSlider(
          'Width',
          styleProvider.windowWidth,
          200,
          400,
          (value) =>
              styleProvider.setWindowSize(value, styleProvider.windowHeight),
        ),
        _buildSlider(
          'Height',
          styleProvider.windowHeight,
          100,
          300,
          (value) =>
              styleProvider.setWindowSize(styleProvider.windowWidth, value),
        ),
      ],
    );
  }

  /// Build background gradient settings
  Widget _buildBackgroundGradient(CallerIdStyleProvider styleProvider) {
    return Column(
      children: [
        ColorPanel(
          title: 'Start Color',
          currentColor: styleProvider.backgroundColorStart,
          onColorChanged: (color) =>
              styleProvider.setBackgroundColorStart(color),
        ),
        ColorPanel(
          title: 'End Color',
          currentColor: styleProvider.backgroundColorEnd,
          onColorChanged: (color) => styleProvider.setBackgroundColorEnd(color),
        ),
      ],
    );
  }

  /// Build text color settings
  Widget _buildTextColors(CallerIdStyleProvider styleProvider) {
    return Column(
      children: [
        ColorPanel(
          title: 'Label Icon Color',
          currentColor: styleProvider.textIconLabelColor,
          onColorChanged: (color) => styleProvider.setTextIconLabelColor(color),
        ),
        ColorPanel(
          title: 'Location Icon Color',
          currentColor: styleProvider.textIconLocationColor,
          onColorChanged: (color) =>
              styleProvider.setTextIconLocationColor(color),
        ),
        ColorPanel(
          title: 'Call Type Icon Color',
          currentColor: styleProvider.textIconCallTypeColor,
          onColorChanged: (color) =>
              styleProvider.setTextIconCallTypeColor(color),
        ),
        ColorPanel(
          title: 'Avatar Border Color',
          currentColor: styleProvider.avatarBorderColor,
          onColorChanged: (color) => styleProvider.setAvatarBorderColor(color),
        ),
        ColorPanel(
          title: 'Name Color',
          currentColor: styleProvider.textNameColor,
          onColorChanged: (color) => styleProvider.setTextNameColor(color),
        ),
        ColorPanel(
          title: 'Number Color',
          currentColor: styleProvider.textNumberColor,
          onColorChanged: (color) => styleProvider.setTextNumberColor(color),
        ),
        ColorPanel(
          title: 'Location Color',
          currentColor: styleProvider.textLocationColor,
          onColorChanged: (color) => styleProvider.setTextLocationColor(color),
        ),
        ColorPanel(
          title: 'Carrier Color',
          currentColor: styleProvider.textCarrierColor,
          onColorChanged: (color) => styleProvider.setTextCarrierColor(color),
        ),
        ColorPanel(
          title: 'Country Name Color',
          currentColor: styleProvider.textCountryNameColor,
          onColorChanged: (color) =>
              styleProvider.setTextCountryNameColor(color),
        ),
        ColorPanel(
          title: 'Labels Color',
          currentColor: styleProvider.textLabelsColor,
          onColorChanged: (color) => styleProvider.setTextLabelsColor(color),
        ),
        ColorPanel(
          title: 'Count Color',
          currentColor: styleProvider.textCountColor,
          onColorChanged: (color) => styleProvider.setTextCountColor(color),
        ),
        ColorPanel(
          title: 'Number Type Color',
          currentColor: styleProvider.textNumberTypeColor,
          onColorChanged: (color) =>
              styleProvider.setTextNumberTypeColor(color),
        ),
        ColorPanel(
          title: 'STIR Color',
          currentColor: styleProvider.textStirColor,
          onColorChanged: (color) => styleProvider.setTextStirColor(color),
        ),
        ColorPanel(
          title: 'SIM Card Color',
          currentColor: styleProvider.textSimCardColor,
          onColorChanged: (color) => styleProvider.setTextSimCardColor(color),
        ),
      ],
    );
  }

  /// Build font size settings
  Widget _buildFontSizes(CallerIdStyleProvider styleProvider) {
    return Column(
      children: [
        SizePanel(
          label: 'Name Font Size',
          currentSize: styleProvider.nameFontSize,
          onSizeChanged: (value) => styleProvider.setNameFontSize(value),
        ),
        SizePanel(
          label: 'Carrier Font Size',
          currentSize: styleProvider.carrierFontSize,
          onSizeChanged: (value) => styleProvider.setCarrierFontSize(value),
        ),
        SizePanel(
          label: 'Country Name Font Size',
          currentSize: styleProvider.countryNameFontSize,
          onSizeChanged: (value) => styleProvider.setCountryNameFontSize(value),
        ),
        SizePanel(
          label: 'Labels Font Size',
          currentSize: styleProvider.labelsFontSize,
          onSizeChanged: (value) => styleProvider.setLabelsFontSize(value),
        ),
        SizePanel(
          label: 'Count Font Size',
          currentSize: styleProvider.countFontSize,
          onSizeChanged: (value) => styleProvider.setCountFontSize(value),
        ),
        SizePanel(
          label: 'Number Type Font Size',
          currentSize: styleProvider.numberTypeFontSize,
          onSizeChanged: (value) => styleProvider.setNumberTypeFontSize(value),
        ),
        SizePanel(
          label: 'Number Font Size',
          currentSize: styleProvider.numberFontSize,
          onSizeChanged: (value) => styleProvider.setNumberFontSize(value),
        ),
        SizePanel(
          label: 'Location Font Size',
          currentSize: styleProvider.locationFontSize,
          onSizeChanged: (value) => styleProvider.setLocationFontSize(value),
        ),
        SizePanel(
          label: 'STIR Font Size',
          currentSize: styleProvider.stirFontSize,
          onSizeChanged: (value) => styleProvider.setStirFontSize(value),
        ),
        SizePanel(
          label: 'SIM Card Font Size',
          currentSize: styleProvider.simCardFontSize,
          onSizeChanged: (value) => styleProvider.setSimCardFontSize(value),
        ),
      ],
    );
  }

  /// Build avatar and icon size settings
  Widget _buildAvatarAndIconSizes(CallerIdStyleProvider styleProvider) {
    return Column(
      children: [
        _buildSlider(
          'Avatar Size',
          styleProvider.avatarSize,
          40,
          80,
          (value) => styleProvider.setAvatarSize(value),
        ),
        _buildSlider(
          'Avatar Border Size',
          styleProvider.avatarBorderSize,
          40,
          80,
          (value) => styleProvider.setAvatarBorderSize(value),
        ),
        _buildSlider(
          'Icon Size',
          styleProvider.iconSize,
          16,
          32,
          (value) => styleProvider.setIconSize(value),
        ),
      ],
    );
  }

  /// Build element position settings
  Widget _buildElementPositions(CallerIdStyleProvider styleProvider) {
    return Column(
      children: [
        _buildPositionSlider(
          'Avatar Position',
          styleProvider.avatarPosition,
          (offset) => styleProvider.updateAvatarPosition(offset),
        ),
        _buildPositionSlider(
          'Name Position',
          styleProvider.namePosition,
          (offset) => styleProvider.updateNamePosition(offset),
        ),
        _buildPositionSlider(
          'Carrier Position',
          styleProvider.carrierPosition,
          (offset) => styleProvider.updateCarrierPosition(offset),
        ),
        _buildPositionSlider(
          'Country Name Position',
          styleProvider.countryNamePosition,
          (offset) => styleProvider.updateCountryNamePosition(offset),
        ),
        _buildPositionSlider(
          'Labels Position',
          styleProvider.labelsPosition,
          (offset) => styleProvider.updateLabelsPosition(offset),
        ),
        _buildPositionSlider(
          'Count Position',
          styleProvider.countPosition,
          (offset) => styleProvider.updateCountPosition(offset),
        ),
        _buildPositionSlider(
          'Number Type Position',
          styleProvider.numberTypePosition,
          (offset) => styleProvider.updateNumberTypePosition(offset),
        ),
        _buildPositionSlider(
          'Number Position',
          styleProvider.numberPosition,
          (offset) => styleProvider.updateNumberPosition(offset),
        ),
        _buildPositionSlider(
          'Location Position',
          styleProvider.locationPosition,
          (offset) => styleProvider.updateLocationPosition(offset),
        ),
        _buildPositionSlider(
          'STIR Position',
          styleProvider.stirPosition,
          (offset) => styleProvider.updateStirPosition(offset),
        ),
        _buildPositionSlider(
          'SIM Card Position',
          styleProvider.simCardPosition,
          (offset) => styleProvider.updateSimCardPosition(offset),
        ),
        _buildPositionSlider(
          'Call Type Position',
          styleProvider.callTypePosition,
          (offset) => styleProvider.updateCallTypePosition(offset),
        ),
      ],
    );
  }

  /// Build slider
  Widget _buildSlider(String label, double value, double min, double max,
      Function(double) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          SizedBox(width: 120, child: Text(label)),
          Expanded(
            child: Slider(
              value: value,
              min: min,
              max: max,
              onChanged: onChanged,
            ),
          ),
          SizedBox(width: 50, child: Text(value.toStringAsFixed(1))),
        ],
      ),
    );
  }

  /// Build position slider
  Widget _buildPositionSlider(
      String label, Offset position, Function(Offset) onChanged) {
    return ExpansionTile(
      title: Text(label),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              _buildSlider(
                'X',
                position.dx,
                0,
                300,
                (value) => onChanged(Offset(value, position.dy)),
              ),
              _buildSlider(
                'Y',
                position.dy,
                0,
                300,
                (value) => onChanged(Offset(position.dx, value)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
