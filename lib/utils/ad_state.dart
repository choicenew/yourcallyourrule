// ad_state.dart
import 'package:flutter/foundation.dart';

class AdState with ChangeNotifier {
  bool _isAdEnabled = true;

  bool get isAdEnabled => _isAdEnabled;

  void disableAds() {
    _isAdEnabled = false;
    notifyListeners(); // 通知监听器状态已更新
  }
    void enableAds() { // 添加 enableAds 方法
    _isAdEnabled = true;
    notifyListeners();
  }
}