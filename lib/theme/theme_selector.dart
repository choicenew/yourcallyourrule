import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yourcallyourrule/theme/theme_provider.dart'; // <- 替换为你的项目名

class ThemeSelector extends ConsumerWidget {
  const ThemeSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. 使用 ref.watch 来获取当前的主题模式。
    // 这能确保当主题模式改变时，这个 Widget 会自动重建以更新UI。
    final currentThemeMode = ref.watch(themeModeProvider);

    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF6C5CE7).withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.palette_rounded, color: Color(0xFF6C5CE7), size: 20),
          ),
          const SizedBox(width: 10),
          const Text(
            'Theme',
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
          ),
        ],
      ),
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: SegmentedButton<ThemeMode>(
          segments: const <ButtonSegment<ThemeMode>>[
            ButtonSegment(
              value: ThemeMode.light,
              label: Text('Light'),
              icon: Icon(Icons.wb_sunny_rounded),
            ),
            ButtonSegment(
              value: ThemeMode.dark,
              label: Text('Dark'),
              icon: Icon(Icons.nightlight_rounded),
            ),
            ButtonSegment(
              value: ThemeMode.system,
              label: Text('System'),
              icon: Icon(Icons.settings_suggest_rounded),
            ),
          ],
          selected: <ThemeMode>{currentThemeMode},
          onSelectionChanged: (Set<ThemeMode> newSelection) {
            ref.read(themeModeProvider.notifier).setThemeMode(newSelection.first);
            Navigator.of(context).pop();
          },
          style: SegmentedButton.styleFrom(
            selectedForegroundColor: Colors.white,
            selectedBackgroundColor: const Color(0xFF6C5CE7),
            backgroundColor: const Color(0xFFF7F5F0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          ),
        ),
      ),
    );
  }
}