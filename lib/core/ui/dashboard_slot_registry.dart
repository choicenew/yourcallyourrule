import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 仪表盘 Tab 插槽项 (Dashboard Tab Item)
class DashboardTabItem {
  final String id;
  final String title;
  final IconData icon;
  final WidgetBuilder builder;

  const DashboardTabItem({
    required this.id,
    required this.title,
    required this.icon,
    required this.builder,
  });
}

/// 仪表盘插槽注册表 (Dashboard Slot Registry)
/// 彻底解耦 Dashboard 页面容器与子 Feature 统计组件
class DashboardSlotRegistry {
  final Map<String, DashboardTabItem> _tabs = {};

  void registerTab(DashboardTabItem tab) {
    _tabs[tab.id] = tab;
  }

  void unregisterTab(String id) {
    _tabs.remove(id);
  }

  List<DashboardTabItem> getTabs() {
    return _tabs.values.toList();
  }
}

/// 仪表盘插槽注册表 Provider
final dashboardSlotRegistryProvider = Provider<DashboardSlotRegistry>((ref) {
  return DashboardSlotRegistry();
});
