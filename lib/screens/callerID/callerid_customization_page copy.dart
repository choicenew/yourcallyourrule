import 'package:dlibphonenumber/dlibphonenumber.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../screens/callerID/callerid_overlay.dart';
import '../../services/caller_id_service.dart';
import '../../utils/ad_manager.dart';
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
        print('Error loading configuration: $e');
        // Create and save a default configuration
        ConfigurationManager.saveConfiguration(styleProvider);
      }
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
              const SizedBox(height: 10),
              // 预览区域
              SizedBox(
                //height: 200,
                child: CallerIdOverlay(
                  callerIdData: _mockCallerIdData(),
                  onDismiss: () {},
                  isDismissible: false,
                ),
              ),
                      const Divider(),
                              FutureBuilder<Widget>(
                  future:
                      Future.value(const GoogleAdWidget(adInfo: AdManager.bannerAd)),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      return snapshot.data!;
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              const Divider(),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    // 样式设置项
                    _buildExpansionTile('Window Size', 0,
                        _buildWindowSizeSliders(styleProvider), styleProvider),
                    _buildExpansionTile('Background Gradient', 1,
                        _buildBackgroundGradient(styleProvider), styleProvider),
                    _buildExpansionTile('Text & Label Colors', 2,
                        _buildTextColors(styleProvider), styleProvider),
                    _buildExpansionTile('Font Sizes', 3,
                        _buildFontSizes(styleProvider), styleProvider),
                    _buildExpansionTile('Avatar and Icon Sizes', 4,
                        _buildAvatarAndIconSizes(styleProvider), styleProvider),
                    _buildExpansionTile('Element Positions', 5,
                        _buildElementPositions(styleProvider), styleProvider),
          //广告代码
          nativeAdWidgetMedium(adWidth: 320, adHeight: 320),
                  ],                  
                ),                
              ),

              
              // 按钮区域
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          ConfigurationManager.importConfiguration(
                              context, styleProvider);
                          // 显示 SnackBar
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Configuration imported Successfully')),
                          );
                        } catch (e) {
                          // 处理 JSON 解析错误
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Invalid JSON format')),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                      ),
                      child: const Text('Import'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await ConfigurationManager.exportConfiguration(
                            styleProvider);
                        // 显示 SnackBar
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Configuration exported to file!')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[400],
                      ),
                      child: const Text('Export'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        // 保存配置 (此处仅为示例，实际保存逻辑需根据应用需求实现)
                        await ConfigurationManager.saveConfiguration(
                            styleProvider);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Configuration Saved!')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink[300],
                      ),
                      child: const Text('Save'),
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
            'Width',
            styleProvider.windowWidth,
            200,
            400,
            (value) =>
                styleProvider.setWindowSize(value, styleProvider.windowHeight)),
        _buildSlider(
            'Height',
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
        _buildColorPicker('Start Color', styleProvider.backgroundColorStart,
            (color) => styleProvider.setBackgroundColorStart(color)),
        _buildColorPicker('End Color', styleProvider.backgroundColorEnd,
            (color) => styleProvider.setBackgroundColorEnd(color)),
      ],
    );
  }

  // 构建文字颜色设置
  Widget _buildTextColors(CallerIdStyleProvider styleProvider) {
    return Column(
      children: [
        _buildColorPicker('Label Icon Color', styleProvider.textIconLabelColor,
            (color) => styleProvider.setTextIconLabelColor(color)),
        _buildColorPicker('Location Icon Color', styleProvider.textIconLocationColor,
            (color) => styleProvider.setTextIconLocationColor(color)),
        _buildColorPicker('Avatar Border Color', styleProvider.avatarBorderColor,
            (color) => styleProvider.setAvatarBorderColor(color)),

        _buildColorPicker('Name Color', styleProvider.textNameColor,
            (color) => styleProvider.setTextNameColor(color)),
        _buildColorPicker('Number Color', styleProvider.textNumberColor,
            (color) => styleProvider.setTextNumberColor(color)),
        _buildColorPicker('Location Color', styleProvider.textLocationColor,
            (color) => styleProvider.setTextLocationColor(color)),
        _buildColorPicker('Carrier Color', styleProvider.textCarrierColor,
            (color) => styleProvider.setTextCarrierColor(color)),
        _buildColorPicker(
            'Country Name Color',
            styleProvider.textCountryNameColor,
            (color) => styleProvider.setTextCountryNameColor(color)),
    //    _buildColorPicker('Region Color', styleProvider.textRegionColor,
     //       (color) => styleProvider.setTextRegionColor(color)),

        _buildColorPicker('Labels Color', styleProvider.textLabelsColor,
            (color) => styleProvider.setTextLabelsColor(color)),
        _buildColorPicker('Count Color', styleProvider.textCountColor,
            (color) => styleProvider.setTextCountColor(color)),
        _buildColorPicker(
            'Number Type Color',
            styleProvider.textNumberTypeColor,
            (color) => styleProvider.setTextNumberTypeColor(color)),
      ],
    );
  }

  // 构建字体大小设置
  Widget _buildFontSizes(CallerIdStyleProvider styleProvider) {
    return Column(
      children: [
        _buildSlider('Name Font Size', styleProvider.nameFontSize, 12, 24,
            (value) => styleProvider.setNameFontSize(value)),
        _buildSlider('Carrier Font Size', styleProvider.carrierFontSize, 12, 24,
            (value) => styleProvider.setCarrierFontSize(value)),
        _buildSlider(
            'Country Name Font Size',
            styleProvider.countryNameFontSize,
            12,
            24,
            (value) => styleProvider.setCountryNameFontSize(value)),
        _buildSlider('Labels Font Size', styleProvider.labelsFontSize, 12, 24,
            (value) => styleProvider.setLabelsFontSize(value)),
        _buildSlider('Count Font Size', styleProvider.countFontSize, 12, 24,
            (value) => styleProvider.setCountFontSize(value)),
        _buildSlider('Number Type Font Size', styleProvider.numberTypeFontSize,
            12, 24, (value) => styleProvider.setNumberTypeFontSize(value)),
        _buildSlider('Number Font Size', styleProvider.numberFontSize, 12, 24,
            (value) => styleProvider.setNumberFontSize(value)),
        _buildSlider('Location Font Size', styleProvider.locationFontSize, 12, 24,
            (value) => styleProvider.setLocationFontSize(value)),
      ],
    );
  }

  // 构建头像和图标大小设置
  Widget _buildAvatarAndIconSizes(CallerIdStyleProvider styleProvider) {
    return Column(
      children: [
        _buildSlider('Avatar Size', styleProvider.avatarSize, 40, 80,
            (value) => styleProvider.setAvatarSize(value)),
        _buildSlider('Avatar Border Size', styleProvider.avatarBorderSize, 40, 80,
            (value) => styleProvider.setAvatarBorderSize(value)),            
        _buildSlider('Icon Size', styleProvider.iconSize, 16, 32,
            (value) => styleProvider.setIconSize(value)),
      ],
    );
  }

  // 构建元素位置设置
// 构建元素位置设置 (重新添加)
  Widget _buildElementPositions(CallerIdStyleProvider styleProvider) {
    return Column(
      children: [
        _buildPositionSlider('Avatar Position', styleProvider.avatarPosition,
            (offset) => styleProvider.updateAvatarPosition(offset)),
        _buildPositionSlider('Name Position', styleProvider.namePosition,
            (offset) => styleProvider.updateNamePosition(offset)),
        _buildPositionSlider('Carrier Position', styleProvider.carrierPosition,
            (offset) => styleProvider.updateCarrierPosition(offset)),
        _buildPositionSlider(
            'Country Name Position',
            styleProvider.countryNamePosition,
            (offset) => styleProvider.updateCountryNamePosition(offset)),
        _buildPositionSlider('Labels Position', styleProvider.labelsPosition,
            (offset) => styleProvider.updateLabelsPosition(offset)),
        _buildPositionSlider('Count Position', styleProvider.countPosition,
            (offset) => styleProvider.updateCountPosition(offset)),
        _buildPositionSlider(
            'Number Type Position',
            styleProvider.numberTypePosition,
            (offset) => styleProvider.updateNumberTypePosition(offset)),
        _buildPositionSlider('Number Position', styleProvider.numberPosition,
            (offset) => styleProvider.updateNumberPosition(offset)),
        _buildPositionSlider(
            'Location Position',
            styleProvider.locationPosition,
            (offset) => styleProvider.updateLocationPosition(offset)),
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
/*
  // 构建颜色选择器
  Widget _buildColorPicker(
      String label, Color color, Function(Color) onChanged) {
    return Row(
      children: [
        Expanded(child: Text(label)),
        SizedBox(
          width: 200,
          height: 200,
          child: HSVColorPicker(
            pickerColor: color,
            onColorChanged: onChanged,
          ),
        ),
      ],
    );
  }
*/
/*
Widget _buildColorPicker(String label, Color color, Function(Color) onChanged) {
  return Row(
    children: [
      Expanded(child: Text(label)),
      ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                titlePadding: const EdgeInsets.all(0),
                contentPadding: const EdgeInsets.all(0),
                content: SingleChildScrollView(
                  child: ColorPicker(
                    pickerColor: color,
                    onColorChanged: onChanged,
                    colorPickerWidth: 300,
                    pickerAreaHeightPercent: 0.7,
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
        child: const Text('Select Color'),
      ),
    ],
  );
}
*/

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
          child: const Text('Select Color'),
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

/*
  // 导出配置
  Future<void> _exportConfiguration(CallerIdStyleProvider styleProvider) async {
    final config = {
      'backgroundColorStart': styleProvider.backgroundColorStart.value,
      'backgroundColorEnd': styleProvider.backgroundColorEnd.value,
      'textNameColor': styleProvider.textNameColor.value,
      'textNumberColor': styleProvider.textNumberColor.value,
      'textLocationColor': styleProvider.textLocationColor.value,
      'textCarrierColor': styleProvider.textCarrierColor.value,
      'textCountryNameColor': styleProvider.textCountryNameColor.value,
      'textLabelsColor': styleProvider.textLabelsColor.value,
      'textCountColor': styleProvider.textCountColor.value,
      'textNumberTypeColor': styleProvider.textNumberTypeColor.value,
      'nameFontSize': styleProvider.nameFontSize,
      'numberFontSize': styleProvider.numberFontSize,
      'locationFontSize': styleProvider.locationFontSize,
      'carrierFontSize': styleProvider.carrierFontSize,
      'countryNameFontSize': styleProvider.countryNameFontSize,
      'labelsFontSize': styleProvider.labelsFontSize,
      'countFontSize': styleProvider.countFontSize,
      'numberTypeFontSize': styleProvider.numberTypeFontSize,
      'avatarSize': styleProvider.avatarSize,
      'iconSize': styleProvider.iconSize,
      'windowWidth': styleProvider.windowWidth,
      'windowHeight': styleProvider.windowHeight,
      'avatarPosition': {
        'dx': styleProvider.avatarPosition.dx,
        'dy': styleProvider.avatarPosition.dy,
      },
      'namePosition': {
        'dx': styleProvider.namePosition.dx,
        'dy': styleProvider.namePosition.dy,
      },
      'carrierPosition': {
        'dx': styleProvider.carrierPosition.dx,
        'dy': styleProvider.carrierPosition.dy,
      },
      'countryNamePosition': {
        'dx': styleProvider.countryNamePosition.dx,
        'dy': styleProvider.countryNamePosition.dy,
      },
      'labelsPosition': {
        'dx': styleProvider.labelsPosition.dx,
        'dy': styleProvider.labelsPosition.dy,
      },
      'countPosition': {
        'dx': styleProvider.countPosition.dx,
        'dy': styleProvider.countPosition.dy,
      },
      'numberTypePosition': {
        'dx': styleProvider.numberTypePosition.dx,
        'dy': styleProvider.numberTypePosition.dy,
      },
      'numberPosition': {
        'dx': styleProvider.numberPosition.dx,
        'dy': styleProvider.numberPosition.dy,
      },
      'locationPosition': {
        'dx': styleProvider.locationPosition.dx,
        'dy': styleProvider.locationPosition.dy,
      },
    };
    final jsonString = json.encode(config);
    // 将 jsonString 复制到剪贴板或保存到文件等操作
    // 选择保存路径
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

    if (selectedDirectory != null) {
      final file = File('$selectedDirectory/caller_id_config.json');
      await file.writeAsString(jsonString);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Configuration exported to file!')),
      );
    }
  }

// 显示导入对话框
  void _showImportDialog(
      BuildContext context, CallerIdStyleProvider styleProvider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Import Configuration'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () async {
                // 从文件导入
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['json'],
                );
                if (result != null) {
                  File file = File(result.files.single.path!);
                  final jsonString = await file.readAsString();
                  _importConfigurationFromJson(jsonString, styleProvider);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Import from file'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // 粘贴文本导入
                _showPasteDialog(context, styleProvider);
              },
              child: const Text('Paste JSON'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

// 显示粘贴对话框
  void _showPasteDialog(
      BuildContext context, CallerIdStyleProvider styleProvider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Paste JSON Configuration'),
        content: TextField(
          decoration: const InputDecoration(hintText: 'Paste JSON here'),
          maxLines: null,
          onChanged: (text) {
            _importConfigurationFromJson(text, styleProvider);
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Configuration imported')),
              );
            },
            child: const Text('Import'),
          ),
        ],
      ),
    );
  }

// 从 JSON 字符串导入配置
  void _importConfigurationFromJson(
      String jsonString, CallerIdStyleProvider styleProvider) {
    try {
      final config = json.decode(jsonString);
      // ... 与之前相同的配置更新逻辑
      styleProvider
          .setBackgroundColorStart(Color(config['backgroundColorStart']));
      styleProvider.setBackgroundColorEnd(Color(config['backgroundColorEnd']));
      styleProvider.setTextNameColor(Color(config['textNameColor']));
      styleProvider.setTextNumberColor(Color(config['textNumberColor']));
      styleProvider.setTextLocationColor(Color(config['textLocationColor']));
      styleProvider.setTextCarrierColor(Color(config['textCarrierColor']));
      styleProvider
          .setTextCountryNameColor(Color(config['textCountryNameColor']));
      styleProvider.setTextLabelsColor(Color(config['textLabelsColor']));
      styleProvider.setTextCountColor(Color(config['textCountColor']));
      styleProvider
          .setTextNumberTypeColor(Color(config['textNumberTypeColor']));
      styleProvider.setNameFontSize(config['nameFontSize']);
      styleProvider.setNumberFontSize(config['numberFontSize']);
      styleProvider.setLocationFontSize(config['locationFontSize']);
      styleProvider.setCarrierFontSize(config['carrierFontSize']);
      styleProvider.setCountryNameFontSize(config['countryNameFontSize']);
      styleProvider.setLabelsFontSize(config['labelsFontSize']);
      styleProvider.setCountFontSize(config['countFontSize']);
      styleProvider.setNumberTypeFontSize(config['numberTypeFontSize']);
      styleProvider.setAvatarSize(config['avatarSize']);
      styleProvider.setIconSize(config['iconSize']);
      styleProvider.setWindowSize(
          config['windowWidth'], config['windowHeight']);
      styleProvider.updateAvatarPosition(Offset(
          config['avatarPosition']['dx'], config['avatarPosition']['dy']));
      styleProvider.updateNamePosition(
          Offset(config['namePosition']['dx'], config['namePosition']['dy']));
      styleProvider.updateCarrierPosition(Offset(
          config['carrierPosition']['dx'], config['carrierPosition']['dy']));
      styleProvider.updateCountryNamePosition(Offset(
          config['countryNamePosition']['dx'],
          config['countryNamePosition']['dy']));
      styleProvider.updateLabelsPosition(Offset(
          config['labelsPosition']['dx'], config['labelsPosition']['dy']));
      styleProvider.updateCountPosition(
          Offset(config['countPosition']['dx'], config['countPosition']['dy']));
      styleProvider.updateNumberTypePosition(Offset(
          config['numberTypePosition']['dx'],
          config['numberTypePosition']['dy']));
      styleProvider.updateNumberPosition(Offset(
          config['numberPosition']['dx'], config['numberPosition']['dy']));
      styleProvider.updateLocationPosition(Offset(
          config['locationPosition']['dx'], config['locationPosition']['dy']));
    } catch (e) {
      // 处理 JSON 解析错误
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid JSON format')),
      );
    }
  }
*/
  // 模拟 CallerIdData 数据
  CallerIdData _mockCallerIdData() {
    return CallerIdData(
      phoneNumber: '+1 234 567 8900',
      countryName: 'United States',
      region: 'New York',
      carrier: 'Example Carrier',
      numberType: PhoneNumberType.mobile,
      labels: [Label(label: 'Other')],
      name: 'John Doe',
      avatar: 'assets/avatars/Unknown.png',
      count: 5,
    );
  }
}
