// ignore: unused_import
import 'package:flutter/cupertino.dart' show CupertinoTextField;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

// Just an example of how to use/interpret/format text input's result.
void copyToClipboard(String input) {
  String textToCopy = input.replaceFirst('#', '').toUpperCase();
  if (textToCopy.startsWith('FF') && textToCopy.length == 8) {
    textToCopy = textToCopy.replaceFirst('FF', '');
  }
  Clipboard.setData(ClipboardData(text: '#$textToCopy'));
}

class HSVColorPicker extends StatefulWidget {
  const HSVColorPicker({
    super.key,
    required this.pickerColor,
    required this.onColorChanged,
    this.colorHistory,
    this.onHistoryChanged,
  });

  final Color pickerColor;
  final ValueChanged<Color> onColorChanged;
  final List<Color>? colorHistory;
  final ValueChanged<List<Color>>? onHistoryChanged;

  @override
  State<HSVColorPicker> createState() => _HSVColorPickerState();
}

class _HSVColorPickerState extends State<HSVColorPicker> {
  // Picker 1
  PaletteType _paletteType = PaletteType.hsl;
  bool _enableAlpha = true;
  bool _displayThumbColor = true;
  final List<ColorLabelType> _labelTypes = [
    ColorLabelType.hsl,
    ColorLabelType.hsv
  ];
  bool _displayHexInputBar = true;
  bool _isHueRingPickerExpanded =
      false; // Track expansion state of HueRingPicker
  bool _isMaterialPickerExpanded =
      false; // Track expansion state of MaterialPicker
  bool _enableLabel = true;
  bool _portraitOnly = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 20),
        // Directly display the ColorPicker with Slider
        ColorPicker(
          pickerColor: widget.pickerColor,
          onColorChanged: widget.onColorChanged,
          colorPickerWidth: 300,
          pickerAreaHeightPercent: 0.7,
          enableAlpha: _enableAlpha,
          labelTypes: _labelTypes,
          displayThumbColor: _displayThumbColor,
          paletteType: _paletteType,
          pickerAreaBorderRadius: const BorderRadius.only(
            topLeft: Radius.circular(2),
            topRight: Radius.circular(2),
          ),
          hexInputBar: _displayHexInputBar,
          colorHistory: widget.colorHistory,
          onHistoryChanged: widget.onHistoryChanged,
        ),
        const SizedBox(height: 10),
        ExpansionTile(
          title: const Text('HueRingPicker'),
          initiallyExpanded: _isHueRingPickerExpanded, // Initially collapsed
          onExpansionChanged: (bool expanded) {
            setState(() {
              _isHueRingPickerExpanded = expanded;
            });
          },
          children: [
            HueRingPicker(
              pickerColor: widget.pickerColor,
              onColorChanged: widget.onColorChanged,
              enableAlpha: _enableAlpha,
              displayThumbColor: _displayThumbColor,
            ),
          ],
        ),

        const SizedBox(height: 10),
        // Added MaterialPicker with ExpansionTile
        ExpansionTile(
          title: const Text('Material Color Picker'),
          initiallyExpanded: _isMaterialPickerExpanded, // Initially collapsed
          onExpansionChanged: (bool expanded) {
            setState(() {
              _isMaterialPickerExpanded = expanded;
            });
          },
          children: [
            MaterialPicker(
              pickerColor: widget.pickerColor,
              onColorChanged: widget.onColorChanged,
              enableLabel: _enableLabel,
              portraitOnly: _portraitOnly,
            ),
          ],
        ),
        const SizedBox(height: 10),
        // Configuration Options
        SwitchListTile(
          title: const Text('Enable Alpha Slider'),
          subtitle: const Text('Display alpha slider & label text'),
          value: _enableAlpha,
          onChanged: (bool value) =>
              setState(() => _enableAlpha = !_enableAlpha),
        ),
        SwitchListTile(
          title: const Text('Display Thumb Color in slider'),
          value: _displayThumbColor,
          onChanged: (bool value) =>
              setState(() => _displayThumbColor = !_displayThumbColor),
        ),
        ListTile(
          title: const Text('Palette Type'),
          trailing: DropdownButtonHideUnderline(
            child: DropdownButton(
              value: _paletteType,
              onChanged: (PaletteType? type) {
                if (type != null) setState(() => _paletteType = type);
              },
              items: [
                for (PaletteType type in PaletteType.values)
                  DropdownMenuItem(
                    value: type,
                    child: SizedBox(
                      width: 150,
                      child: Text(type.toString().split('.').last,
                          textAlign: TextAlign.end),
                    ),
                  )
              ],
            ),
          ),
        ),
        ExpansionTile(
          title:
              Text(_labelTypes.isNotEmpty ? 'Display Label' : 'Disable Label'),
          subtitle: Text(
            _labelTypes.isNotEmpty
                ? _labelTypes
                    .map((e) => e.toString().split('.').last.toUpperCase())
                    .toString()
                : '',
          ),
          children: [
            SwitchListTile(
              title: const Text('    Display HEX Label Text'),
              value: _labelTypes.contains(ColorLabelType.hex),
              onChanged: (bool value) => setState(
                () => value
                    ? _labelTypes.add(ColorLabelType.hex)
                    : _labelTypes.remove(ColorLabelType.hex),
              ),
              dense: true,
            ),
            SwitchListTile(
              title: const Text('    Display RGB Label Text'),
              value: _labelTypes.contains(ColorLabelType.rgb),
              onChanged: (bool value) => setState(
                () => value
                    ? _labelTypes.add(ColorLabelType.rgb)
                    : _labelTypes.remove(ColorLabelType.rgb),
              ),
              dense: true,
            ),
            SwitchListTile(
              title: const Text('    Display HSV Label Text'),
              value: _labelTypes.contains(ColorLabelType.hsv),
              onChanged: (bool value) => setState(
                () => value
                    ? _labelTypes.add(ColorLabelType.hsv)
                    : _labelTypes.remove(ColorLabelType.hsv),
              ),
              dense: true,
            ),
            SwitchListTile(
              title: const Text('    Display HSL Label Text'),
              value: _labelTypes.contains(ColorLabelType.hsl),
              onChanged: (bool value) => setState(
                () => value
                    ? _labelTypes.add(ColorLabelType.hsl)
                    : _labelTypes.remove(ColorLabelType.hsl),
              ),
              dense: true,
            ),
          ],
        ),
        SwitchListTile(
          title: const Text('Display Hex Input Bar'),
          value: _displayHexInputBar,
          onChanged: (bool value) =>
              setState(() => _displayHexInputBar = !_displayHexInputBar),
        ),

        SwitchListTile(
          title: const Text('Enable Label in Portrait Mode'),
          value: _enableLabel,
          onChanged: (bool value) =>
              setState(() => _enableLabel = !_enableLabel),
        ),
        SwitchListTile(
          title: const Text('Apply Portrait layout to Landscape Mode'),
          value: _portraitOnly,
          onChanged: (bool value) =>
              setState(() => _portraitOnly = !_portraitOnly),
        ),
        const Divider(),
      ],
    );
  }
}
