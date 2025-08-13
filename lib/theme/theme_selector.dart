import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yourcallyourrule/theme/theme_provider.dart'; // <- 替换为你的项目名

class ThemeSelector extends ConsumerWidget {
  const ThemeSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. 使用 ref.watch 来获取当前的主题模式。
    // 这能确保当主题模式改变时，这个 Widget 会自动重建以更新UI。
    final currentThemeMode = ref.watch(themeModeNotifierProvider);

    return SegmentedButton<ThemeMode>(
      // 定义按钮的各个部分
      segments: const <ButtonSegment<ThemeMode>>[
        // 亮色模式按钮
        ButtonSegment(
          value: ThemeMode.light,
          label: Text('Light'),
          icon: Icon(Icons.wb_sunny_outlined),
        ),
        // 暗色模式按钮
        ButtonSegment(
          value: ThemeMode.dark,
          label: Text('Dark'),
          icon: Icon(Icons.nightlight_outlined),
        ),
        // 跟随系统按钮
        ButtonSegment(
          value: ThemeMode.system,
          label: Text('System'),
          icon: Icon(Icons.settings_suggest_outlined),
        ),
      ],
      
      // `selected` 需要一个 Set，它包含了当前被选中的值。
      // 我们用 `currentThemeMode` 来初始化这个 Set。
      selected: <ThemeMode>{currentThemeMode},

      // 当用户点击一个新的选项时，这个回调函数会被触发。
      onSelectionChanged: (Set<ThemeMode> newSelection) {
        // 2. 使用 ref.read 来调用 Notifier 中的方法。
        // 我们用 .notifier 来获取 StateNotifier 的实例。
        // newSelection.first 会获取用户点击的那个唯一的选项。
        ref.read(themeModeNotifierProvider.notifier)
           .setThemeMode(newSelection.first);
      },
      
      // (可选) 增加一些样式让它更好看
      style: SegmentedButton.styleFrom(
        // 选中项的背景色，会使用主题的 secondaryContainer 颜色
        selectedForegroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
        selectedBackgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      ),
    );
  }
}