import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/adwidgets/native_ads.dart';
import 'package:yourcallyourrule/ads/google_ad.dart';
import 'package:yourcallyourrule/features/call/caller_id/configuration/caller_id_config.dart';
import 'package:yourcallyourrule/features/call/caller_id/configuration/configuration_manager.dart';
import 'package:yourcallyourrule/features/call/caller_id/providers/callerid_style_security_provider.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/overlay_handler.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import '../../mock_data/caller_id_mock.dart';
import '../widgets/caller_id_overlay.dart';
import '../widgets/customization/button_panel.dart';
import '../widgets/customization/color_panel.dart';
import '../widgets/customization/size_panel.dart';

/// 来电显示自定义页面 (重构后)
/// 使用单一的 `callerIdStyleSecurityProvider` 来管理所有状态
class CallerIdCustomizationScreen extends ConsumerStatefulWidget {
  const CallerIdCustomizationScreen({super.key});

  @override
  ConsumerState<CallerIdCustomizationScreen> createState() =>
      _CallerIdCustomizationScreenState();
}

class _CallerIdCustomizationScreenState
    extends ConsumerState<CallerIdCustomizationScreen> {
  // 用于控制各个设置项的展开/收起状态
  final List<bool> _isExpanded = List.generate(7, (_) => false);
  // ConfigurationManager 现在通过 Provider 获取，无需手动创建
  late final ConfigurationManager _configurationManager;

  @override
  void initState() {
    super.initState();
    // 从 Provider 中读取 Manager 实例
    _configurationManager = ref.read(configurationManagerProvider);

    // initState 中的加载逻辑，现在操作统一的 Provider
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final notifier = ref.read(callerIdStyleSecurityProvider.notifier);
      // 调用 manager 加载数据
      _configurationManager.loadConfig().then((loadedConfig) {
        // 加载成功后，用新数据更新 Notifier 的状态
        notifier.updateStateWith(loadedConfig);
      }).catchError((e) {
        // 如果加载失败（例如，没有已保存的配置），则获取当前 Notifier 的状态并保存
        final currentConfig = ref.read(callerIdStyleSecurityProvider).value;
        if (currentConfig != null) {
          _configurationManager.saveConfig(currentConfig);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.callerIdCustomizationTitle)),
      body: Consumer(
        builder: (context, ref, child) {
          // 只 watch 一个 Provider
          final asyncConfig = ref.watch(callerIdStyleSecurityProvider);

          // 使用 .when 处理加载、错误和数据状态，这种方式更健壮
          return asyncConfig.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text("Error: $err")),
            data: (config) {
              // config 对象现在包含了所有样式和安全信息
              return Column(
                children: [
                  // 预览区域
                  Container(
                    width: config.windowWidth,
                    height: config.windowHeight,
                    alignment: Alignment.center,
                    // CallerIdOverlay 应该内部也使用 provider 来获取配置
                    // 这样预览才能实时反映所有变化
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
                        // 设置项
                        _buildExpansionTile(
                            AppLocalizations.of(context)!.windowSizeSetting,
                            0,
                            _buildWindowSizeSliders(config)),
                        _buildExpansionTile(
                            AppLocalizations.of(context)!
                                .backgroundGradientSetting,
                            1,
                            _buildBackgroundGradient(config)),
                        _buildExpansionTile(
                            AppLocalizations.of(context)!.textColorsSetting,
                            2,
                            _buildTextColors(config)),
                        _buildExpansionTile(
                            AppLocalizations.of(context)!.fontSizesSetting,
                            3,
                            _buildFontSizes(config)),
                        _buildExpansionTile(
                            AppLocalizations.of(context)!
                                .avatarIconSizesSetting,
                            4,
                            _buildAvatarAndIconSizes(config)),
                        _buildExpansionTile(
                            AppLocalizations.of(context)!
                                .elementPositionsSetting,
                            5,
                            _buildElementPositions(config)),
                        _buildExpansionTile(
                            AppLocalizations.of(context)!
                                .scrollingSecurityMessageSettings,
                            6,
                            _buildSecurityMessageSettings(config)),
                        nativeAdWidgetMedium(adWidth: 320, adHeight: 320),
                      ],
                    ),
                  ),
                  // 按钮区域
                  ButtonPanel(
                    configurationManager: _configurationManager,
                    onPreviewPressed: () => _showPreview(context),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  /// 显示预览浮窗
  Future<void> _showPreview(BuildContext context) async {
    final overlayHandler = OverlayHandler();
    final mockData = CallerIdMockData.mockCallerIdData();
    final stirInfo = CallerIdMockData.mockStirInfoData();
    final simInfo = CallerIdMockData.mockSimInfoData();

    final mediaQuery = MediaQuery.of(context);
    overlayHandler.setPixelRatio(mediaQuery.devicePixelRatio);
    
    // 在重构后的模型中，OverlayHandler 应该也通过 Riverpod 获取最新的配置
    // 因此这里不再需要手动传递配置，只需触发显示即可
    await overlayHandler.showCallerIdOverlay(mockData, stirInfo, simInfo);
  }

  /// 构建可折叠的设置项
  Widget _buildExpansionTile(String title, int index, Widget content) {
    return ExpansionTile(
      title: Text(title),
      initiallyExpanded: _isExpanded[index],
      onExpansionChanged: (expanded) =>
          setState(() => _isExpanded[index] = expanded),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: content,
        )
      ],
    );
  }

  // --- 所有构建辅助方法现在都接收统一的 config 对象 ---

  /// 构建窗口尺寸设置
  Widget _buildWindowSizeSliders(CallerIdConfig config) {
    final notifier = ref.read(callerIdStyleSecurityProvider.notifier);
    return Column(
      children: [
        _buildSlider(
          AppLocalizations.of(context)!.width,
          config.windowWidth,
          200,
          400,
          (value) => notifier.setWindowSize(width: value),
        ),
        _buildSlider(
          AppLocalizations.of(context)!.height,
          config.windowHeight,
          100,
          300,
          (value) => notifier.setWindowSize(height: value),
        ),
      ],
    );
  }

  /// 构建背景渐变色设置
  Widget _buildBackgroundGradient(CallerIdConfig config) {
    final notifier = ref.read(callerIdStyleSecurityProvider.notifier);
    return Column(
      children: [
        ColorPanel(
          title: AppLocalizations.of(context)!.startColor,
          currentColor: config.backgroundColorStart,
          onColorChanged: notifier.setBackgroundColorStart,
        ),
        ColorPanel(
          title: AppLocalizations.of(context)!.endColor,
          currentColor: config.backgroundColorEnd,
          onColorChanged: notifier.setBackgroundColorEnd,
        ),
      ],
    );
  }

  /// 构建文本颜色设置
  Widget _buildTextColors(CallerIdConfig config) {
    final notifier = ref.read(callerIdStyleSecurityProvider.notifier);
    return Column(
      children: [
        ColorPanel(
            title: AppLocalizations.of(context)!.labelIconColor,
            currentColor: config.textIconLabelColor,
            onColorChanged: notifier.setTextIconLabelColor),
        ColorPanel(
            title: AppLocalizations.of(context)!.locationIconColor,
            currentColor: config.textIconLocationColor,
            onColorChanged: notifier.setTextIconLocationColor),
        ColorPanel(
            title: AppLocalizations.of(context)!.callTypeIconColor,
            currentColor: config.textIconCallTypeColor,
            onColorChanged: notifier.setTextIconCallTypeColor),
        ColorPanel(
            title: AppLocalizations.of(context)!.avatarBorderColor,
            currentColor: config.avatarBorderColor,
            onColorChanged: notifier.setAvatarBorderColor),
        ColorPanel(
            title: AppLocalizations.of(context)!.nameColor,
            currentColor: config.textNameColor,
            onColorChanged: notifier.setTextNameColor),
        ColorPanel(
            title: AppLocalizations.of(context)!.numberColor,
            currentColor: config.textNumberColor,
            onColorChanged: notifier.setTextNumberColor),
        ColorPanel(
            title: AppLocalizations.of(context)!.locationColor,
            currentColor: config.textLocationColor,
            onColorChanged: notifier.setTextLocationColor),
        ColorPanel(
            title: AppLocalizations.of(context)!.carrierColor,
            currentColor: config.textCarrierColor,
            onColorChanged: notifier.setTextCarrierColor),
        ColorPanel(
            title: AppLocalizations.of(context)!.countryNameColor,
            currentColor: config.textCountryNameColor,
            onColorChanged: notifier.setTextCountryNameColor),
        ColorPanel(
            title: AppLocalizations.of(context)!.labelsColor,
            currentColor: config.textLabelsColor,
            onColorChanged: notifier.setTextLabelsColor),
        ColorPanel(
            title: AppLocalizations.of(context)!.countColor,
            currentColor: config.textCountColor,
            onColorChanged: notifier.setTextCountColor),
        ColorPanel(
            title: AppLocalizations.of(context)!.numberTypeColor,
            currentColor: config.textNumberTypeColor,
            onColorChanged: notifier.setTextNumberTypeColor),
        ColorPanel(
            title: AppLocalizations.of(context)!.stirColor,
            currentColor: config.textStirColor,
            onColorChanged: notifier.setTextStirColor),
        ColorPanel(
            title: AppLocalizations.of(context)!.simCardColor,
            currentColor: config.textSimCardColor,
            onColorChanged: notifier.setTextSimCardColor),
      ],
    );
  }

  /// 构建字体大小设置
  Widget _buildFontSizes(CallerIdConfig config) {
    final notifier = ref.read(callerIdStyleSecurityProvider.notifier);
    return Column(
      children: [
        SizePanel(
            label: AppLocalizations.of(context)!.nameFontSize,
            currentSize: config.nameFontSize,
            onSizeChanged: notifier.setNameFontSize),
        SizePanel(
            label: AppLocalizations.of(context)!.carrierFontSize,
            currentSize: config.carrierFontSize,
            onSizeChanged: notifier.setCarrierFontSize),
        SizePanel(
            label: AppLocalizations.of(context)!.countryNameFontSize,
            currentSize: config.countryNameFontSize,
            onSizeChanged: notifier.setCountryNameFontSize),
        SizePanel(
            label: AppLocalizations.of(context)!.labelsFontSize,
            currentSize: config.labelsFontSize,
            onSizeChanged: notifier.setLabelsFontSize),
        SizePanel(
            label: AppLocalizations.of(context)!.countFontSize,
            currentSize: config.countFontSize,
            onSizeChanged: notifier.setCountFontSize),
        SizePanel(
            label: AppLocalizations.of(context)!.numberTypeFontSize,
            currentSize: config.numberTypeFontSize,
            onSizeChanged: notifier.setNumberTypeFontSize),
        SizePanel(
            label: AppLocalizations.of(context)!.numberFontSize,
            currentSize: config.numberFontSize,
            onSizeChanged: notifier.setNumberFontSize),
        SizePanel(
            label: AppLocalizations.of(context)!.locationFontSize,
            currentSize: config.locationFontSize,
            onSizeChanged: notifier.setLocationFontSize),
        SizePanel(
            label: AppLocalizations.of(context)!.stirFontSize,
            currentSize: config.stirFontSize,
            onSizeChanged: notifier.setStirFontSize),
        SizePanel(
            label: AppLocalizations.of(context)!.simCardFontSize,
            currentSize: config.simCardFontSize,
            onSizeChanged: notifier.setSimCardFontSize),
      ],
    );
  }

  /// 构建头像和图标尺寸设置
  Widget _buildAvatarAndIconSizes(CallerIdConfig config) {
    final notifier = ref.read(callerIdStyleSecurityProvider.notifier);
    return Column(
      children: [
        _buildSlider(
            AppLocalizations.of(context)!.avatarSize,
            config.avatarSize,
            40,
            80,
            notifier.setAvatarSize),
        _buildSlider(
            AppLocalizations.of(context)!.avatarBorderSize,
            config.avatarBorderSize,
            1,
            10,
            notifier.setAvatarBorderSize),
        _buildSlider(AppLocalizations.of(context)!.iconSize, config.iconSize,
            16, 32, notifier.setIconSize),
      ],
    );
  }

  /// 构建元素位置设置
  Widget _buildElementPositions(CallerIdConfig config) {
    final notifier = ref.read(callerIdStyleSecurityProvider.notifier);
    return Column(
      children: [
        _buildPositionSlider(
            AppLocalizations.of(context)!.avatarPosition,
            config.avatarPosition,
            notifier.updateAvatarPosition),
        _buildPositionSlider(AppLocalizations.of(context)!.namePosition,
            config.namePosition, notifier.updateNamePosition),
        _buildPositionSlider(
            AppLocalizations.of(context)!.carrierPosition,
            config.carrierPosition,
            notifier.updateCarrierPosition),
        _buildPositionSlider(
            AppLocalizations.of(context)!.countryRegionNamePosition,
            config.countryNamePosition,
            notifier.updateCountryNamePosition),
        _buildPositionSlider(
            AppLocalizations.of(context)!.labelsPosition,
            config.labelsPosition,
            notifier.updateLabelsPosition),
        _buildPositionSlider(AppLocalizations.of(context)!.countPosition,
            config.countPosition, notifier.updateCountPosition),
        _buildPositionSlider(
            AppLocalizations.of(context)!.numberTypePosition,
            config.numberTypePosition,
            notifier.updateNumberTypePosition),
        _buildPositionSlider(
            AppLocalizations.of(context)!.numberPosition,
            config.numberPosition,
            notifier.updateNumberPosition),
        _buildPositionSlider(
            AppLocalizations.of(context)!.locationPosition,
            config.locationPosition,
            notifier.updateLocationPosition),
        _buildPositionSlider(AppLocalizations.of(context)!.stirPosition,
            config.stirPosition, notifier.updateStirPosition),
        _buildPositionSlider(
            AppLocalizations.of(context)!.simCardPosition,
            config.simCardPosition,
            notifier.updateSimCardPosition),
        _buildPositionSlider(
            AppLocalizations.of(context)!.callTypePosition,
            config.callTypePosition,
            notifier.updateCallTypePosition),
      ],
    );
  }

  /// 构建安全滚动信息设置
  Widget _buildSecurityMessageSettings(CallerIdConfig config) {
    final notifier = ref.read(callerIdStyleSecurityProvider.notifier);
    return Column(
      children: [
        SwitchListTile(
          title: Text(AppLocalizations.of(context)!.enableSecurityMessage),
          value: config.securityMessageEnabled,
          onChanged: notifier.setSecurityMessageEnabled,
        ),
        ColorPanel(
            title: AppLocalizations.of(context)!.messageColor,
            currentColor: config.securityMessageTextColor,
            onColorChanged: notifier.setSecurityMessageTextColor),
        ColorPanel(
            title: AppLocalizations.of(context)!.messageBackgroundColor,
            currentColor: config.securityMessageBackgroundColor,
            onColorChanged: notifier.setSecurityMessageBackgroundColor),
        SizePanel(
            label: AppLocalizations.of(context)!.messageFontSize,
            currentSize: config.securityMessageFontSize,
            onSizeChanged: notifier.setSecurityMessageFontSize),
        _buildSlider(AppLocalizations.of(context)!.height,
            config.securityMessageHeight, 20, 60, notifier.setSecurityMessageHeight),
        _buildSlider(
            AppLocalizations.of(context)!.containerWidth,
            config.securityMessageContainerWidth,
            100,
            400,
            notifier.setSecurityMessageContainerWidth),
        _buildSlider(
            AppLocalizations.of(context)!.scrollSpeed,
            config.securityMessageScrollSpeed,
            10,
            100,
            notifier.setSecurityMessageScrollSpeed),
        _buildPositionSlider(
            AppLocalizations.of(context)!.messagePosition,
            config.securityMessagePosition,
            notifier.updateSecurityMessagePosition),
      ],
    );
  }

  /// 构建通用的滑块控件
  Widget _buildSlider(String label, double value, double min, double max,
      Function(double) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          SizedBox(
              width: 120,
              child: Text(label, overflow: TextOverflow.ellipsis)),
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

  /// 构建通用的位置(X/Y)滑块控件
  Widget _buildPositionSlider(
      String label, Offset position, Function(Offset) onChanged) {
    return ExpansionTile(
      title: Text(label),
      tilePadding: EdgeInsets.zero,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              _buildSlider(
                'X',
                position.dx,
                -50, // 允许部分移出屏幕
                450, // 允许部分移出屏幕
                (value) => onChanged(Offset(value, position.dy)),
              ),
              _buildSlider(
                'Y',
                position.dy,
                -50,
                350,
                (value) => onChanged(Offset(position.dx, value)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}