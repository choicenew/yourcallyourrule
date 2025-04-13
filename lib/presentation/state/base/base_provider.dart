import 'package:flutter/foundation.dart';

/// 基础Provider类
/// 所有Provider状态管理类都应该继承自这个基类
abstract class BaseProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  
  /// 是否正在加载
  bool get isLoading => _isLoading;
  
  /// 错误信息
  String? get errorMessage => _errorMessage;
  
  /// 设置加载状态
  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
  
  /// 设置错误信息
  void setError(String? error) {
    _errorMessage = error;
    notifyListeners();
  }
  
  /// 清除错误信息
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
  
  /// 处理异常
  void handleException(dynamic exception) {
    setLoading(false);
    setError(exception.toString());
    debugPrint('Provider异常: $exception');
  }
}