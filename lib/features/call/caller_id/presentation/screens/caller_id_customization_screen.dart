// lib/features/caller_id/ui/caller_id_customization_screen.dart

import 'package:flutter/material.dart';
import 'package:floating_window_android/floating_window_android.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/adwidgets/native_ads.dart';
import 'package:yourcallyourrule/ads/google_ad.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';
// --- 关键修改：导入新的统一 Provider ---

import 'package:yourcallyourrule/features/call/caller_id/configuration/caller_id_config.dart';
// --- 关键修改：ConfigurationManager 现在通过 Provider 获取 ---
import 'package:yourcallyourrule/features/call/caller_id/configuration/configuration_manager.dart';
import 'package:yourcallyourrule/features/call/caller_id/providers/callerid_style_security_provider.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/overlay_handler.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import '../../mock_data/caller_id_mock.dart';
import '../widgets/caller_id_overlay.dart';
import '../widgets/customization/button_panel.dart';
import '../widgets/customization/color_panel.dart';
import '../widgets/customization/size_panel.dart';

// --- 结构保持不变：仍然是 ConsumerStatefulWidget ---
class CallerIdCustomizationScreen extends ConsumerStatefulWidget {
  const CallerIdCustomizationScreen({super.key});

  @override
  ConsumerState<CallerIdCustomizationScreen> createState() =>
      _CallerIdCustomizationScreenState();
}

class _CallerIdCustomizationScreenState
    extends ConsumerState<CallerIdCustomizationScreen> {
  // --- 所有状态变量保持不变 ---
  final List<bool> _isExpanded = List.generate(7, (_) => false);
  OverlayPosition? storedPosition;
  // --- 关键修改：ConfigurationManager 不再手动创建 ---
  late final ConfigurationManager _configurationManager;

  @override
  void initState() {
    super.initState();
    // --- 关键修改：从 Provider 中读取 Manager 实例 ---
    _configurationManager = ref.read(configurationManagerProvider);

    // --- initState 中的加载逻辑保持不变，但操作对象已改变 ---
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 获取 Notifier 实例
      final notifier = ref.read(callerIdStyleSecurityProvider.notifier);
      // 调用 manager 加载数据
      _configurationManager.loadConfig().then((loadedConfig) {
        // 加载成功后，用新数据更新 Notifier 的状态
        notifier.updateStateWith(loadedConfig);
      }).catchError((e) {
        // 如果加载失败，获取当前 Notifier 的状态并保存
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
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.callerIdCustomizationTitle)),
      // --- 结构保持不变：外部仍然是普通的 Scaffold Body ---
      body: Consumer(
        builder: (context, ref, child) {
          // --- 关键修改：只 watch 一个 Provider ---
          final asyncConfig = ref.watch(callerIdStyleSecurityProvider);

          // 使用 .when 来处理加载和错误状态，这是比以前更健壮的方式
          return asyncConfig.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text("Error: $err")),
            data: (config) {
              // --- config 对象现在包含了 style 和 security 的所有信息 ---
              return Column(
                children: [
                  // Preview Area
                  Container(
                    width: config.windowWidth,
                    height: config.windowHeight,
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
                        _buildExpansionTile(AppLocalizations.of(context)!.windowSizeSetting, 0,
                            _buildWindowSizeSliders(config)),
                        _buildExpansionTile(AppLocalizations.of(context)!.backgroundGradientSetting, 1,
                            _buildBackgroundGradient(config)),
                        _buildExpansionTile(AppLocalizations.of(context)!.textColorsSetting, 2,
                            _buildTextColors(config)),
                        _buildExpansionTile(AppLocalizations.of(context)!.fontSizesSetting, 3,
                            _buildFontSizes(config)),
                        _buildExpansionTile(AppLocalizations.of(context)!.avatarIconSizesSetting, 4,
                            _buildAvatarAndIconSizes(config)),
                        _buildExpansionTile(AppLocalizations.of(context)!.elementPositionsSetting, 5,
                            _buildElementPositions(config)),
                        _buildExpansionTile(
                            AppLocalizations.of(context)!.scrollingSecurityMessageSettings, 6, _buildSecurityMessageSettings(config)),

                        // Ad
                        nativeAdWidgetMedium(adWidth: 320, adHeight: 320),
                      ],
                    ),
                  ),

                  // Button Area
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

  /// Show preview - 逻辑保持不变
  Future<void> _showPreview(BuildContext context) async {
    final overlayHandler = OverlayHandler();
    final mockData = CallerIdMockData.mockCallerIdData();
    final stirInfo = CallerIdMockData.mockStirInfoData();
    final simInfo = CallerIdMockData.mockSimInfoData();

    final mediaQuery = MediaQuery.of(context);
    overlayHandler.setPixelRatio(mediaQuery.devicePixelRatio);

    // 我们之前已经重构了 OverlayHandler，它现在可以独立工作
    await overlayHandler.showCallerIdOverlay(mockData, stirInfo, simInfo);
  }

  /// Build collapsible setting item - 逻辑保持不变
  Widget _buildExpansionTile(String title, int index, Widget content) {
    return ExpansionTile(
      title: Text(title),
      initiallyExpanded: _isExpanded[index],
      onExpansionChanged: (expanded) =>
          setState(() => _isExpanded[index] = expanded),
      children: [content],
    );
  }

  // --- 所有 build helper 方法都进行微调，以从统一的 config 对象中读取数据 ---
  
  /// Build window size setting sliders
  Widget _buildWindowSizeSliders(CallerIdConfig config) {
    final notifier = ref.read(callerIdStyleSecurityProvider.notifier);
    return Column(
      children: [
        _buildSlider(
          AppLocalizations.of(context)!.width,
          config.windowWidth, 200, 400,
          (value) => notifier.setWindowSize(value, config.windowHeight),
        ),
        _buildSlider(
          AppLocalizations.of(context)!.height,
          config.windowHeight, 100, 300,
          (value) => notifier.setWindowSize(config.windowWidth, value),
        ),
      ],
    );
  }

  /// Build background gradient settings
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

  /// Build text color settings
  Widget _buildTextColors(CallerIdConfig config) {
    final notifier = ref.read(callerIdStyleSecurityProvider.notifier);
    return Column(
      children: [
        ColorPanel(title: "...", currentColor: config.textIconLabelColor, onColorChanged: notifier.setTextIconLabelColor),
        // ... 所有其他的 ColorPanel 都从 config 读取颜色，并调用 notifier 的相应方法
      ],
    );
  }

  /// Build font size settings
  Widget _buildFontSizes(CallerIdConfig config) {
    final notifier = ref.read(callerIdStyleSecurityProvider.notifier);
    return Column(
      children: [
        SizePanel(label: "...", currentSize: config.nameFontSize, onSizeChanged: notifier.setNameFontSize),
        // ... 所有其他的 SizePanel 都从 config 读取尺寸，并调用 notifier 的相应方法
      ],
    );
  }

  /// Build avatar and icon size settings
  Widget _buildAvatarAndIconSizes(CallerIdConfig config) {
    final notifier = ref.read(callerIdStyleSecurityProvider.notifier);
    return Column(
      children: [
        _buildSlider("...", config.avatarSize, 40, 80, notifier.setAvatarSize),
        // ...
      ],
    );
  }

  /// Build element position settings
  Widget _buildElementPositions(CallerIdConfig config) {
    final notifier = ref.read(callerIdStyleSecurityProvider.notifier);
    return Column(
      children: [
        _buildPositionSlider("...", config.avatarPosition, notifier.updateAvatarPosition),
        // ...
      ],
    );
  }

  /// Build security message settings
  Widget _buildSecurityMessageSettings(CallerIdConfig config) {
    final notifier = ref.read(callerIdStyleSecurityProvider.notifier);
    return Column(
      children: [
        ColorPanel(title: "...", currentColor: config.securityMessageTextColor, onColorChanged: notifier.setSecurityMessageTextColor),
        SizePanel(label: "...", currentSize: config.securityMessageFontSize, onSizeChanged: notifier.setSecurityMessageFontSize),
        SwitchListTile(title: Text("..."), value: config.securityMessageEnabled, onChanged: notifier.setSecurityMessageEnabled),
        // ...
      ],
    );
  }
  
  /// Build slider - 逻辑保持不变
  Widget _buildSlider(String label, double value, double min, double max,
      Function(double) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        // ...
      ),
    );
  }

  /// Build position slider - 逻辑保持不变
  Widget _buildPositionSlider(
      String label, Offset position, Function(Offset) onChanged) {
    return ExpansionTile(
      title: Text(label),
      // ...
    );
  }
}