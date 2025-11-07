// lib/features/call/live_activities/ui/live_notification_customization_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/ads/adwidgets/native_ads.dart';
import 'package:yourcallyourrule/features/call/caller_id/presentation/widgets/customization/color_panel.dart';
import 'package:yourcallyourrule/features/call/caller_id/presentation/widgets/customization/size_panel.dart';
import 'package:yourcallyourrule/features/call/live_activities/live_activity_config/live_notification_config.dart';
import 'package:yourcallyourrule/features/call/live_activities/presentation/widgets/live_notification_preview.dart.dart';
import 'package:yourcallyourrule/features/call/live_activities/providers/live_notification_config_provider.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';






class LiveNotificationCustomizationScreen extends ConsumerStatefulWidget {
  const LiveNotificationCustomizationScreen({super.key});

  @override
  ConsumerState<LiveNotificationCustomizationScreen> createState() =>
      _LiveNotificationCustomizationScreenState();
}

class _LiveNotificationCustomizationScreenState
    extends ConsumerState<LiveNotificationCustomizationScreen> {
  final List<bool> _isExpanded = List.generate(5, (_) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.liveActivitiesSettingsTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'reset') {
                ref.read(liveNotificationConfigProvider.notifier).resetToDefaults();
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'reset',
                child: Text(AppLocalizations.of(context)!.reset),
              ),
            ],
          ),
        ],
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final asyncConfig = ref.watch(liveNotificationConfigProvider);

          return asyncConfig.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text('Error: $err')),
            data: (config) {
              return Column(
                children: [
                  LiveNotificationPreview(config: config),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(16),
                      children: [
                        _buildExpansionTile(
                          AppLocalizations.of(context)!.elementsSettingsTitle, 0,
                          _buildElementsVisibility(config),
                        ),
                        _buildExpansionTile(
                          AppLocalizations.of(context)!.textColorsSetting, 1,
                          _buildTextColors(config),
                        ),
                        _buildExpansionTile(
                          AppLocalizations.of(context)!.fontSizesSetting, 2,
                          _buildFontSizes(config),
                        ),
                        _buildExpansionTile(
                          AppLocalizations.of(context)!.avatarIconSizesSetting, 3,
                          _buildAvatarAndIconStyles(config),
                        ),
                        _buildExpansionTile(
                          AppLocalizations.of(context)!.elementPositionsSetting, 4,
                          _buildElementPositions(config),
                        ),
                                 nativeAdWidgetMedium(adWidth: 320, adHeight: 320),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
  
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
  
  Widget _buildElementsVisibility(LiveNotificationConfig config) {
      final notifier = ref.read(liveNotificationConfigProvider.notifier);
      return Column(
          children: [
              SwitchListTile(title: Text(AppLocalizations.of(context)!.avatar), value: config.avatar.visible, onChanged: (val) => notifier.updateElementVisibility('avatar', val)),
              SwitchListTile(title: Text(AppLocalizations.of(context)!.name), value: config.name.visible, onChanged: (val) => notifier.updateElementVisibility('name', val)),
              SwitchListTile(title: Text(AppLocalizations.of(context)!.phoneNumber), value: config.number.visible, onChanged: (val) => notifier.updateElementVisibility('number', val)),
              SwitchListTile(title: Text(AppLocalizations.of(context)!.location), value: config.location.visible, onChanged: (val) => notifier.updateElementVisibility('location', val)),
              SwitchListTile(title: Text(AppLocalizations.of(context)!.carrier), value: config.carrier.visible, onChanged: (val) => notifier.updateElementVisibility('carrier', val)),
              SwitchListTile(title: Text(AppLocalizations.of(context)!.country), value: config.countryName.visible, onChanged: (val) => notifier.updateElementVisibility('countryName', val)),
              SwitchListTile(title: Text(AppLocalizations.of(context)!.labels), value: config.labels.visible, onChanged: (val) => notifier.updateElementVisibility('labels', val)),
              SwitchListTile(title: Text(AppLocalizations.of(context)!.markCounts), value: config.count.visible, onChanged: (val) => notifier.updateElementVisibility('count', val)),
              SwitchListTile(title: Text(AppLocalizations.of(context)!.phoneNumberType), value: config.numberType.visible, onChanged: (val) => notifier.updateElementVisibility('numberType', val)),
              SwitchListTile(title: Text(AppLocalizations.of(context)!.stirVerificationTitle), value: config.stir.visible, onChanged: (val) => notifier.updateElementVisibility('stir', val)),
              SwitchListTile(title: Text(AppLocalizations.of(context)!.simCardTitle), value: config.simCard.visible, onChanged: (val) => notifier.updateElementVisibility('simCard', val)),
              SwitchListTile(title: Text(AppLocalizations.of(context)!.callType), value: config.callType.visible, onChanged: (val) => notifier.updateElementVisibility('callType', val)),
              SwitchListTile(title: Text(AppLocalizations.of(context)!.securityMessage), value: config.securityMessage.visible, onChanged: (val) => notifier.updateElementVisibility('securityMessage', val)),
          ],
      );
  }

  Widget _buildTextColors(LiveNotificationConfig config) {
    final notifier = ref.read(liveNotificationConfigProvider.notifier);
    Color colorFromHex(String hex) => Color(int.parse(hex.replaceFirst('#', '0x')));
    String colorToHex(Color color) => '#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}';
    return Column(
      children: [
        ColorPanel(title: AppLocalizations.of(context)!.nameColor, currentColor: colorFromHex(config.name.color), onColorChanged: (color) => notifier.updateTextStyle('name', color: colorToHex(color))),
        ColorPanel(title: AppLocalizations.of(context)!.numberColor, currentColor: colorFromHex(config.number.color), onColorChanged: (color) => notifier.updateTextStyle('number', color: colorToHex(color))),
        ColorPanel(title: AppLocalizations.of(context)!.locationColor, currentColor: colorFromHex(config.location.color), onColorChanged: (color) => notifier.updateTextStyle('location', color: colorToHex(color))),
        ColorPanel(title: AppLocalizations.of(context)!.carrierColor, currentColor: colorFromHex(config.carrier.color), onColorChanged: (color) => notifier.updateTextStyle('carrier', color: colorToHex(color))),
        ColorPanel(title: AppLocalizations.of(context)!.countryNameColor, currentColor: colorFromHex(config.countryName.color), onColorChanged: (color) => notifier.updateTextStyle('countryName', color: colorToHex(color))),
        ColorPanel(title: AppLocalizations.of(context)!.labelsColor, currentColor: colorFromHex(config.labels.color), onColorChanged: (color) => notifier.updateTextStyle('labels', color: colorToHex(color))),
        ColorPanel(title: AppLocalizations.of(context)!.countColor, currentColor: colorFromHex(config.count.color), onColorChanged: (color) => notifier.updateTextStyle('count', color: colorToHex(color))),
        ColorPanel(title: AppLocalizations.of(context)!.numberTypeColor, currentColor: colorFromHex(config.numberType.color), onColorChanged: (color) => notifier.updateTextStyle('numberType', color: colorToHex(color))),
        ColorPanel(title: AppLocalizations.of(context)!.stirColor, currentColor: colorFromHex(config.stir.color), onColorChanged: (color) => notifier.updateTextStyle('stir', color: colorToHex(color))),
        ColorPanel(title: AppLocalizations.of(context)!.simCardColor, currentColor: colorFromHex(config.simCard.color), onColorChanged: (color) => notifier.updateTextStyle('simCard', color: colorToHex(color))),
        ColorPanel(title: AppLocalizations.of(context)!.avatarBorderColor, currentColor: colorFromHex(config.avatar.borderColor), onColorChanged: (color) => notifier.updateAvatarConfig(borderColor: colorToHex(color))),
        ColorPanel(title: AppLocalizations.of(context)!.callTypeIconColor, currentColor: colorFromHex(config.callType.color), onColorChanged: (color) => notifier.updateIconConfig(color: colorToHex(color))),
        // 安全消息颜色设置
        ColorPanel(title: AppLocalizations.of(context)!.messageColor, currentColor: colorFromHex(config.securityMessage.color), onColorChanged: (color) => notifier.updateSecurityMessageStyle(color: colorToHex(color))),
        ColorPanel(title: AppLocalizations.of(context)!.messageBackgroundColor, currentColor: colorFromHex(config.securityMessage.backgroundColor), onColorChanged: (color) => notifier.updateSecurityMessageStyle(backgroundColor: colorToHex(color))),
      ],
    );
  }

  Widget _buildFontSizes(LiveNotificationConfig config) {
    final notifier = ref.read(liveNotificationConfigProvider.notifier);
    return Column(
      children: [
        SizePanel(label: AppLocalizations.of(context)!.nameFontSize, currentSize: config.name.fontSize, onSizeChanged: (size) => notifier.updateTextStyle('name', fontSize: size)),
        SizePanel(label: AppLocalizations.of(context)!.numberFontSize, currentSize: config.number.fontSize, onSizeChanged: (size) => notifier.updateTextStyle('number', fontSize: size)),
        SizePanel(label: AppLocalizations.of(context)!.locationFontSize, currentSize: config.location.fontSize, onSizeChanged: (size) => notifier.updateTextStyle('location', fontSize: size)),
        SizePanel(label: AppLocalizations.of(context)!.carrierFontSize, currentSize: config.carrier.fontSize, onSizeChanged: (size) => notifier.updateTextStyle('carrier', fontSize: size)),
        SizePanel(label: AppLocalizations.of(context)!.countryNameFontSize, currentSize: config.countryName.fontSize, onSizeChanged: (size) => notifier.updateTextStyle('countryName', fontSize: size)),
        SizePanel(label: AppLocalizations.of(context)!.labelsFontSize, currentSize: config.labels.fontSize, onSizeChanged: (size) => notifier.updateTextStyle('labels', fontSize: size)),
        SizePanel(label: AppLocalizations.of(context)!.countFontSize, currentSize: config.count.fontSize, onSizeChanged: (size) => notifier.updateTextStyle('count', fontSize: size)),
        SizePanel(label: AppLocalizations.of(context)!.numberTypeFontSize, currentSize: config.numberType.fontSize, onSizeChanged: (size) => notifier.updateTextStyle('numberType', fontSize: size)),
        SizePanel(label: AppLocalizations.of(context)!.stirFontSize, currentSize: config.stir.fontSize, onSizeChanged: (size) => notifier.updateTextStyle('stir', fontSize: size)),
        SizePanel(label: AppLocalizations.of(context)!.simCardFontSize, currentSize: config.simCard.fontSize, onSizeChanged: (size) => notifier.updateTextStyle('simCard', fontSize: size)),
        // 安全消息字号设置
        SizePanel(label: AppLocalizations.of(context)!.messageFontSize, currentSize: config.securityMessage.fontSize, onSizeChanged: (size) => notifier.updateSecurityMessageStyle(fontSize: size)),
      ],
    );
  }

  Widget _buildAvatarAndIconStyles(LiveNotificationConfig config) {
    final notifier = ref.read(liveNotificationConfigProvider.notifier);
    return Column(
      children: [
        _buildSlider(AppLocalizations.of(context)!.avatarSize, config.avatar.size, 30, 80, (value) => notifier.updateAvatarConfig(size: value)),
        _buildSlider(AppLocalizations.of(context)!.avatarBorderSize, config.avatar.borderWidth, 0, 10, (value) => notifier.updateAvatarConfig(borderWidth: value)),
        _buildSlider(AppLocalizations.of(context)!.iconSize, config.callType.size, 16, 32, (value) => notifier.updateIconConfig(size: value)),
        // 安全消息容器尺寸设置
        _buildSlider(AppLocalizations.of(context)!.height, config.securityMessage.height, 20, 60, (value) => notifier.updateSecurityMessageStyle(height: value)),
        _buildSlider(AppLocalizations.of(context)!.containerWidth, config.securityMessage.containerWidth, 100, 400, (value) => notifier.updateSecurityMessageStyle(containerWidth: value)),
      ],
    );
  }
  
  Widget _buildElementPositions(LiveNotificationConfig config) {
    final notifier = ref.read(liveNotificationConfigProvider.notifier);
    return Column(
      children: [
        _buildPositionSlider(AppLocalizations.of(context)!.avatarPosition, Offset(config.avatar.position.x, config.avatar.position.y), (pos) => notifier.updateElementPosition('avatar', pos)),
        _buildPositionSlider(AppLocalizations.of(context)!.namePosition, Offset(config.name.position.x, config.name.position.y), (pos) => notifier.updateElementPosition('name', pos)),
        _buildPositionSlider(AppLocalizations.of(context)!.numberPosition, Offset(config.number.position.x, config.number.position.y), (pos) => notifier.updateElementPosition('number', pos)),
        _buildPositionSlider(AppLocalizations.of(context)!.locationPosition, Offset(config.location.position.x, config.location.position.y), (pos) => notifier.updateElementPosition('location', pos)),
        _buildPositionSlider(AppLocalizations.of(context)!.carrierPosition, Offset(config.carrier.position.x, config.carrier.position.y), (pos) => notifier.updateElementPosition('carrier', pos)),
        _buildPositionSlider(AppLocalizations.of(context)!.countryRegionNamePosition, Offset(config.countryName.position.x, config.countryName.position.y), (pos) => notifier.updateElementPosition('countryName', pos)),
        _buildPositionSlider(AppLocalizations.of(context)!.labelsPosition, Offset(config.labels.position.x, config.labels.position.y), (pos) => notifier.updateElementPosition('labels', pos)),
        _buildPositionSlider(AppLocalizations.of(context)!.countPosition, Offset(config.count.position.x, config.count.position.y), (pos) => notifier.updateElementPosition('count', pos)),
        _buildPositionSlider(AppLocalizations.of(context)!.numberTypePosition, Offset(config.numberType.position.x, config.numberType.position.y), (pos) => notifier.updateElementPosition('numberType', pos)),
        _buildPositionSlider(AppLocalizations.of(context)!.stirPosition, Offset(config.stir.position.x, config.stir.position.y), (pos) => notifier.updateElementPosition('stir', pos)),
        _buildPositionSlider(AppLocalizations.of(context)!.simCardPosition, Offset(config.simCard.position.x, config.simCard.position.y), (pos) => notifier.updateElementPosition('simCard', pos)),
        _buildPositionSlider(AppLocalizations.of(context)!.callTypePosition, Offset(config.callType.position.x, config.callType.position.y), (pos) => notifier.updateElementPosition('callType', pos)),
        _buildPositionSlider(AppLocalizations.of(context)!.messagePosition, Offset(config.securityMessage.position.x, config.securityMessage.position.y), (pos) => notifier.updateElementPosition('securityMessage', pos)),
      ],
    );
  }

  Widget _buildSlider(String label, double value, double min, double max, Function(double) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          SizedBox(width: 120, child: Text(label, overflow: TextOverflow.ellipsis)),
          Expanded(child: Slider(value: value, min: min, max: max, onChanged: onChanged)),
          SizedBox(width: 50, child: Text(value.toStringAsFixed(1))),
        ],
      ),
    );
  }

  Widget _buildPositionSlider(String label, Offset position, Function(Offset) onChanged) {
    return ExpansionTile(
      title: Text(label),
      tilePadding: EdgeInsets.zero,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              _buildSlider('X', position.dx, 0, 400, (value) => onChanged(Offset(value, position.dy))),
              _buildSlider('Y', position.dy, 0, 250, (value) => onChanged(Offset(position.dx, value))),
            ],
          ),
        ),
      ],
    );
  }
}