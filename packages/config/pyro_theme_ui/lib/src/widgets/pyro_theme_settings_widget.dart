import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:pyro_theme/pyro_theme.dart';

import 'package:pyro_theme_ui/src/l10n/generated/app_localizations.dart';
import '../l10n/generated/app_localizations_en.dart';
import 'liquid_glass_card.dart';

/// 1:1 对齐 GitHub 开源权威 glassmorphism 标准、外壳全量 LiquidGlassCard 响应的主题配置面板
class PyroThemeSettingsWidget extends ConsumerStatefulWidget {
  final List<Locale>? supportedLocales;
  final Locale? currentLocale;
  final void Function(Locale locale)? onLocaleChanged;
  final String Function(Locale? locale)? languageNativeNameResolver;

  const PyroThemeSettingsWidget({
    super.key,
    this.supportedLocales,
    this.currentLocale,
    this.onLocaleChanged,
    this.languageNativeNameResolver,
  });

  @override
  ConsumerState<PyroThemeSettingsWidget> createState() => _PyroThemeSettingsWidgetState();
}

class _PyroThemeSettingsWidgetState extends ConsumerState<PyroThemeSettingsWidget> {
  bool _isExpanded = false;

  Widget _buildIconCapsule(IconData icon, ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(
        icon,
        color: colorScheme.primary,
        size: 18,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations) ?? AppLocalizationsEn();

    final themeMode = ref.watch(themePreferenceProvider);
    final currentScheme = ref.watch(flexSchemeProvider);
    final isTrueBlack = ref.watch(isTrueBlackProvider);
    final isHighContrast = ref.watch(isHighContrastProvider);
    final useDynamicColor = ref.watch(useDynamicColorProvider);
    final isPrimarySwapped = ref.watch(isPrimarySwappedProvider);
    final customSeedColor = ref.watch(customSeedColorProvider);
    final glassBlur = ref.watch(glassBlurProvider);
    final glassOpacity = ref.watch(glassOpacityProvider);
    final currentFontFamily = ref.watch(fontFamilyProvider);
    final currentTextScale = ref.watch(textScaleFactorProvider);

    final theme = Theme.of(context);
    final glassExt = theme.extension<GlassmorphicThemeExtension>() ?? GlassmorphicThemeExtension.light;
    final designExt = theme.extension<DesignTokensThemeExtension>() ?? DesignTokensThemeExtension.light;

    // 当前色彩引擎描述
    final String activeEngineModeText = (customSeedColor != null)
        ? l10n.modeCustomSeed
        : (useDynamicColor
            ? l10n.modeDynamicWallpaper
            : '${l10n.modeFlexSchemePreset} (${currentScheme.name.toUpperCase()})');

    final bool hasColorTint = useDynamicColor || customSeedColor != null;

    return LiquidGlassCard(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: EdgeInsets.zero,
      borderRadius: 16.0,
      child: Theme(
        data: theme.copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: _isExpanded,
          onExpansionChanged: (val) => setState(() => _isExpanded = val),
          leading: _buildIconCapsule(Icons.palette_rounded, theme.colorScheme),
          title: Text(
            l10n.themeSettingsExpansionTitle,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
          subtitle: Text(
            '${themeMode.name.toUpperCase()} · $activeEngineModeText',
            style: TextStyle(
              fontSize: 12,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          childrenPadding: const EdgeInsets.only(bottom: 12, left: 4, right: 4),
          children: [
            // 1. 主题模式选择 (System / Light / Dark)
            ListTile(
              leading: _buildIconCapsule(Icons.brightness_medium_rounded, theme.colorScheme),
              title: Text(
                l10n.selectThemeModeTitle,
                style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w600, color: theme.colorScheme.onSurface),
              ),
              subtitle: Text(
                themeMode.name.toUpperCase(),
                style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurfaceVariant),
              ),
              trailing: Icon(Icons.chevron_right_rounded, size: 20, color: theme.colorScheme.onSurfaceVariant),
              onTap: () => _showThemeModeDialog(context, ref, themeMode, l10n),
            ),

            const Divider(indent: 16, endIndent: 16, height: 16),

            // 2. Android 12+ 动态壁纸取色 (Dynamic Color) 开关
            SwitchListTile(
              secondary: _buildIconCapsule(Icons.wallpaper_rounded, theme.colorScheme),
              title: Text(
                l10n.dynamicColorTitle,
                style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w600, color: theme.colorScheme.onSurface),
              ),
              subtitle: Text(
                l10n.dynamicColorSubtitle,
                style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurfaceVariant),
              ),
              value: useDynamicColor && customSeedColor == null,
              activeColor: theme.colorScheme.primary,
              onChanged: (val) {
                if (val) {
                  ref.read(customSeedColorProvider.notifier).setSeedColor(null);
                  ref.read(useDynamicColorProvider.notifier).toggleDynamicColor(true);
                } else {
                  ref.read(useDynamicColorProvider.notifier).toggleDynamicColor(false);
                }
              },
            ),

            // 3. 40+ 种 FlexScheme 美学高定色盘预设
            ListTile(
              leading: _buildIconCapsule(Icons.color_lens_outlined, theme.colorScheme),
              title: Text(
                l10n.flexSchemePresetTitle,
                style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w600, color: theme.colorScheme.onSurface),
              ),
              subtitle: Text(
                currentScheme.name.toUpperCase(),
                style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurfaceVariant),
              ),
              trailing: Icon(Icons.chevron_right_rounded, size: 20, color: theme.colorScheme.onSurfaceVariant),
              onTap: () => _showFlexSchemeDialog(context, ref, currentScheme, l10n),
            ),

            // 4. 自定义 Seed Color
            ListTile(
              leading: _buildIconCapsule(Icons.colorize_rounded, theme.colorScheme),
              title: Text(
                l10n.pickCustomThemeColorTitle,
                style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w600, color: theme.colorScheme.onSurface),
              ),
              subtitle: Text(
                customSeedColor != null
                    ? 'Custom Seed Active (#${customSeedColor.toARGB32().toRadixString(16).substring(2).toUpperCase()})'
                    : 'Default Palette',
                style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurfaceVariant),
              ),
              trailing: Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: customSeedColor ?? theme.colorScheme.primary,
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
              onTap: () => _showSeedColorDialog(context, ref, customSeedColor, l10n),
            ),

            const Divider(indent: 16, endIndent: 16, height: 16),

            // 5. OLED True Black (#000000) 纯黑模式
            SwitchListTile(
              secondary: _buildIconCapsule(Icons.contrast_rounded, theme.colorScheme),
              title: Text(
                l10n.oledTrueBlackTitle,
                style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w600, color: theme.colorScheme.onSurface),
              ),
              subtitle: Text(
                l10n.oledTrueBlackSubtitle,
                style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurfaceVariant),
              ),
              value: isTrueBlack,
              activeColor: theme.colorScheme.primary,
              onChanged: (val) {
                ref.read(isTrueBlackProvider.notifier).toggleTrueBlack(val);
              },
            ),

            // 6. 无障碍高对比度 (High Contrast) 模式
            SwitchListTile(
              secondary: _buildIconCapsule(Icons.accessibility_new_rounded, theme.colorScheme),
              title: Text(
                l10n.highContrastTitle,
                style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w600, color: theme.colorScheme.onSurface),
              ),
              subtitle: Text(
                l10n.highContrastSubtitle,
                style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurfaceVariant),
              ),
              value: isHighContrast,
              activeColor: theme.colorScheme.primary,
              onChanged: (val) {
                ref.read(isHighContrastProvider.notifier).toggleHighContrast(val);
              },
            ),

            // 7. 主辅色颠倒 (Primary Swap)
            SwitchListTile(
              secondary: _buildIconCapsule(Icons.swap_horiz_rounded, theme.colorScheme),
              title: Text(
                l10n.primarySwapTitle,
                style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w600, color: theme.colorScheme.onSurface),
              ),
              subtitle: Text(
                l10n.primarySwapSubtitle,
                style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurfaceVariant),
              ),
              value: isPrimarySwapped,
              activeColor: theme.colorScheme.primary,
              onChanged: (val) {
                ref.read(isPrimarySwappedProvider.notifier).togglePrimarySwap(val);
              },
            ),

            const Divider(indent: 16, endIndent: 16, height: 16),

            // 8. 字体 Family & Text Scale 缩放度微调
            ListTile(
              leading: _buildIconCapsule(Icons.font_download_rounded, theme.colorScheme),
              title: const Text(
                'Typography Font & Scale',
                style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                'Font: ${currentFontFamily ?? "System"} · Scale: ${currentTextScale.toStringAsFixed(2)}x',
                style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurfaceVariant),
              ),
              trailing: Icon(Icons.chevron_right_rounded, size: 20, color: theme.colorScheme.onSurfaceVariant),
              onTap: () => _showTypographyDialog(context, ref, currentFontFamily, currentTextScale),
            ),

            const Divider(indent: 16, endIndent: 16, height: 16),

            // 9. 液态高斯玻璃拟态 (Glassmorphism) 模糊度与不透明度微调控
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _buildIconCapsule(Icons.blur_on_rounded, theme.colorScheme),
                      const SizedBox(width: 12),
                      Text(
                        l10n.glassmorphismSectionTitle,
                        style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w600, color: theme.colorScheme.onSurface),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // 9a. 高斯模糊度 Slider (0 ~ 30px)
                  Row(
                    children: [
                      SizedBox(
                        width: 140,
                        child: Text(
                          '${l10n.glassBlurTitle}: ${glassBlur.toInt()}px',
                          style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurfaceVariant),
                        ),
                      ),
                      Expanded(
                        child: Slider(
                          value: glassBlur,
                          min: 0.0,
                          max: 30.0,
                          divisions: 30,
                          activeColor: theme.colorScheme.primary,
                          onChanged: (val) {
                            ref.read(glassBlurProvider.notifier).setBlur(val);
                          },
                        ),
                      ),
                    ],
                  ),

                  // 9b. 玻璃层不透明度 Slider (0.30 ~ 0.95)
                  Row(
                    children: [
                      SizedBox(
                        width: 140,
                        child: Text(
                          '${l10n.glassOpacityTitle}: ${(glassOpacity * 100).toInt()}%',
                          style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurfaceVariant),
                        ),
                      ),
                      Expanded(
                        child: Slider(
                          value: glassOpacity.clamp(0.30, 0.95),
                          min: 0.30,
                          max: 0.95,
                          divisions: 65,
                          activeColor: theme.colorScheme.primary,
                          onChanged: (val) {
                            ref.read(glassOpacityProvider.notifier).setOpacity(val);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // 10. 语言选择
            if (widget.supportedLocales != null && widget.supportedLocales!.isNotEmpty)
              ListTile(
                leading: _buildIconCapsule(Icons.language_outlined, theme.colorScheme),
                title: Text(
                  l10n.appDisplayLanguageTitle,
                  style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w600, color: theme.colorScheme.onSurface),
                ),
                subtitle: Text(
                  widget.languageNativeNameResolver?.call(widget.currentLocale) ??
                      widget.currentLocale?.languageCode.toUpperCase() ??
                      'Default',
                  style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurfaceVariant),
                ),
                trailing: Icon(Icons.chevron_right_rounded, size: 20, color: theme.colorScheme.onSurfaceVariant),
                onTap: () => _showAllSupportedLocalesDialog(context, ref, l10n),
              ),

            const SizedBox(height: 12),

            // 11. PyroTheme Design Tokens 液态高斯玻璃 (Liquid Glass) 权威预览卡片
            // 遵守 Flutter 3.47+ Material & Cupertino 解耦手册规约
            // 外圈内嵌 1.2px 极窄半透明高斯折射边框，实时与 AppBottomNavigationBar 共享 GlassmorphicThemeExtension Design Tokens
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Stack(
                children: [
                  if (hasColorTint)
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(glassExt.borderRadius),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              theme.colorScheme.primary.withValues(alpha: 0.85),
                              theme.colorScheme.secondary.withValues(alpha: 0.70),
                              theme.colorScheme.tertiary.withValues(alpha: 0.80),
                            ],
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              margin: const EdgeInsets.only(left: 20),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white30,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              width: 80,
                              height: 80,
                              margin: const EdgeInsets.only(right: 30),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white24,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  Container(
                    width: double.infinity,
                    height: 84,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(glassExt.borderRadius),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: hasColorTint
                            ? [
                                Colors.white.withValues(alpha: glassExt.opacity * 1.2),
                                Colors.white.withValues(alpha: glassExt.opacity * 0.4),
                              ]
                            : [
                                theme.brightness == Brightness.dark
                                    ? Colors.white.withValues(alpha: glassExt.opacity * 0.4)
                                    : Colors.white.withValues(alpha: glassExt.opacity * 0.8),
                                theme.brightness == Brightness.dark
                                    ? Colors.white.withValues(alpha: glassExt.opacity * 0.1)
                                    : Colors.white.withValues(alpha: glassExt.opacity * 0.2),
                              ],
                      ),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.55),
                        width: 1.2,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: hasColorTint
                                  ? Colors.white.withValues(alpha: 0.35)
                                  : theme.colorScheme.primaryContainer,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: hasColorTint
                                    ? Colors.white.withValues(alpha: 0.6)
                                    : theme.colorScheme.primary.withValues(alpha: 0.3),
                              ),
                            ),
                            child: Icon(
                              Icons.auto_awesome_rounded,
                              color: hasColorTint ? Colors.white : theme.colorScheme.primary,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  l10n.designTokensPreviewTitle,
                                  style: TextStyle(
                                    color: hasColorTint ? Colors.white : theme.colorScheme.onSurface,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    shadows: hasColorTint
                                        ? const [
                                            Shadow(
                                              color: Colors.black38,
                                              blurRadius: 4,
                                              offset: Offset(0, 1),
                                            ),
                                          ]
                                        : null,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  'Blur: ${glassExt.blur}px | Opacity: ${(glassExt.opacity * 100).toInt()}% | Spacing: ${designExt.spacingMd}px',
                                  style: TextStyle(
                                    color: hasColorTint
                                        ? Colors.white.withValues(alpha: 0.9)
                                        : theme.colorScheme.onSurfaceVariant,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showThemeModeDialog(
    BuildContext context,
    WidgetRef ref,
    ThemeMode current,
    AppLocalizations l10n,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(l10n.selectThemeModeTitle, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<ThemeMode>(
                title: Text(l10n.themeAuto, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                value: ThemeMode.system,
                groupValue: current,
                onChanged: (val) {
                  if (val != null) {
                    ref.read(themePreferenceProvider.notifier).setThemeMode(val);
                    Navigator.pop(context);
                  }
                },
              ),
              RadioListTile<ThemeMode>(
                title: Text(l10n.themeLight, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                value: ThemeMode.light,
                groupValue: current,
                onChanged: (val) {
                  if (val != null) {
                    ref.read(themePreferenceProvider.notifier).setThemeMode(val);
                    Navigator.pop(context);
                  }
                },
              ),
              RadioListTile<ThemeMode>(
                title: Text(l10n.themeDark, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                value: ThemeMode.dark,
                groupValue: current,
                onChanged: (val) {
                  if (val != null) {
                    ref.read(themePreferenceProvider.notifier).setThemeMode(val);
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showFlexSchemeDialog(
    BuildContext context,
    WidgetRef ref,
    FlexScheme current,
    AppLocalizations l10n,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(l10n.selectFlexSchemeDialogTitle, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          content: SizedBox(
            width: double.maxFinite,
            height: 360,
            child: ListView.builder(
              itemCount: FlexScheme.values.length,
              itemBuilder: (context, index) {
                final scheme = FlexScheme.values[index];
                return RadioListTile<FlexScheme>(
                  title: Text(scheme.name.toUpperCase(), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                  value: scheme,
                  groupValue: current,
                  onChanged: (val) {
                    if (val != null) {
                      ref.read(customSeedColorProvider.notifier).setSeedColor(null);
                      ref.read(useDynamicColorProvider.notifier).toggleDynamicColor(false);
                      ref.read(flexSchemeProvider.notifier).setFlexScheme(val);
                      Navigator.pop(context);
                    }
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _showSeedColorDialog(
    BuildContext context,
    WidgetRef ref,
    Color? current,
    AppLocalizations l10n,
  ) {
    final colors = [
      PaletteTokens.dopaminePeach,
      const Color(0xFFFF4081),
      Colors.cyanAccent,
      Colors.deepOrange,
      Colors.purpleAccent,
      Colors.tealAccent,
      Colors.indigoAccent,
      Colors.greenAccent,
      Colors.amberAccent,
      Colors.deepPurple,
      Colors.lightBlue,
      Colors.lime,
    ];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(l10n.pickCustomThemeColorTitle, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          content: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: colors.map((c) {
              return GestureDetector(
                onTap: () {
                  ref.read(useDynamicColorProvider.notifier).toggleDynamicColor(false);
                  ref.read(customSeedColorProvider.notifier).setSeedColor(c);
                  Navigator.pop(context);
                },
                child: Container(
                  width: 42,
                  height: 40,
                  decoration: BoxDecoration(
                    color: c,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: current == c ? Colors.white : Colors.transparent,
                      width: 3,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  void _showTypographyDialog(
    BuildContext context,
    WidgetRef ref,
    String? currentFont,
    double currentScale,
  ) {
    final fonts = ['System', 'Roboto', 'NotoSans', 'SF ProDisplay', 'PingFang SC'];
    double tempScale = currentScale;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              title: const Text('Typography & Scale', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Font Family', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 8,
                    children: fonts.map((f) {
                      final isSelected = (currentFont == null && f == 'System') || currentFont == f;
                      return ChoiceChip(
                        label: Text(f),
                        selected: isSelected,
                        onSelected: (selected) {
                          if (selected) {
                            ref.read(fontFamilyProvider.notifier).setFontFamily(f == 'System' ? null : f);
                            Navigator.pop(context);
                          }
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  Text('Text Scale Factor: ${tempScale.toStringAsFixed(2)}x', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                  Slider(
                    value: tempScale,
                    min: 0.85,
                    max: 1.35,
                    divisions: 10,
                    onChanged: (val) {
                      setDialogState(() => tempScale = val);
                      ref.read(textScaleFactorProvider.notifier).setTextScaleFactor(val);
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(AppLocalizations.of(context)?.closeButton ?? 'Close'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showAllSupportedLocalesDialog(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
  ) {
    final supportedLocales = widget.supportedLocales ?? [];
    final currentLocale = widget.currentLocale;
    String searchQuery = '';

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            final filteredLocales = supportedLocales.where((loc) {
              final name = (widget.languageNativeNameResolver?.call(loc) ?? loc.languageCode).toLowerCase();
              final code = loc.languageCode.toLowerCase();
              final query = searchQuery.toLowerCase();
              return name.contains(query) || code.contains(query);
            }).toList();

            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              title: Text(l10n.selectAppLanguageTitle, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              content: SizedBox(
                width: double.maxFinite,
                height: 400,
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        hintText: l10n.searchLanguageHint,
                        prefixIcon: const Icon(Icons.search_rounded, size: 20),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onChanged: (query) {
                        setDialogState(() => searchQuery = query);
                      },
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        itemCount: filteredLocales.length,
                        itemBuilder: (context, index) {
                          final loc = filteredLocales[index];
                          final isSelected = currentLocale?.languageCode == loc.languageCode &&
                              (currentLocale?.countryCode == loc.countryCode || loc.countryCode == null);

                          return RadioListTile<Locale>(
                            title: Text(
                              widget.languageNativeNameResolver?.call(loc) ?? loc.languageCode.toUpperCase(),
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                            subtitle: Text('${loc.languageCode}${loc.countryCode != null ? '_${loc.countryCode}' : ''}'),
                            value: loc,
                            groupValue: currentLocale,
                            selected: isSelected,
                            onChanged: (val) {
                              if (val != null) {
                                widget.onLocaleChanged?.call(val);
                                Navigator.pop(context);
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
