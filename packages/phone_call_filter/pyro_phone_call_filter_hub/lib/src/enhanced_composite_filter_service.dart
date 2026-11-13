import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_phone_call_filter_protocol/pyro_phone_call_filter_protocol.dart';

part 'enhanced_composite_filter_service.g.dart';

@Riverpod(keepAlive: true)
EnhancedCompositeFilterService enhancedCompositeFilterService(Ref ref) {
  return EnhancedCompositeFilterService(filters: []);
}

/// 增强版组合过滤器服务中枢 (EnhancedCompositeFilterService)
class EnhancedCompositeFilterService implements CallFilterInterface {
  static final EnhancedCompositeFilterService instance = EnhancedCompositeFilterService();

  final List<CallFilterInterface> _filters = [];

  EnhancedCompositeFilterService({List<CallFilterInterface>? filters}) {
    if (filters != null) {
      _filters.addAll(filters);
    }
  }

  void registerFilter(CallFilterInterface filter) {
    _filters.removeWhere((f) => f.filterType == filter.filterType);
    _filters.add(filter);
  }

  List<CallFilterInterface> get filters => List.unmodifiable(_filters);

  @override
  CallFilterType get filterType => CallFilterType.basicRule;

  @override
  Future<bool> shouldAcceptCall(String phoneNumber) async {
    for (final filter in _filters) {
      if (!await filter.shouldAcceptCall(phoneNumber)) {
        debugPrint('[CallFilterHub] 过滤器 ${filter.filterType.id} 拒绝接听: $phoneNumber');
        return false;
      }
    }
    return true;
  }

  @override
  Future<void> initialize() async {
    for (final filter in _filters) {
      await filter.initialize();
    }
  }
}
