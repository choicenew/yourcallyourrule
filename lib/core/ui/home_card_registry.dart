import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 首页卡片模型 (Home Card Item)
class HomeCardItem {
  final String id;
  final int priority;
  final WidgetBuilder builder;

  const HomeCardItem({
    required this.id,
    required this.priority,
    required this.builder,
  });
}

/// 首页动态卡片注册表 (Home Card Registry)
/// 彻底解耦 Home 容器页与子 Feature 视图部件
class HomeCardRegistry {
  final Map<String, HomeCardItem> _cards = {};

  void registerCard(HomeCardItem card) {
    _cards[card.id] = card;
  }

  void unregisterCard(String id) {
    _cards.remove(id);
  }

  List<HomeCardItem> getCards() {
    final list = _cards.values.toList();
    list.sort((a, b) => a.priority.compareTo(b.priority));
    return list;
  }
}

/// 首页卡片注册表 Provider
final homeCardRegistryProvider = Provider<HomeCardRegistry>((ref) {
  return HomeCardRegistry();
});
