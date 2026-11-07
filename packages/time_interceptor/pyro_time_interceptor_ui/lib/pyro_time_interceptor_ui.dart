library pyro_time_interceptor_ui;

import 'package:flutter/material.dart';
import 'package:pyro_time_interceptor_protocol/pyro_time_interceptor_protocol.dart';

/// 时间窗口拦截设置 ListTile 组件
class TimeInterceptorTileView extends StatelessWidget {
  final TimeInterceptorConfig config;

  const TimeInterceptorTileView({
    super.key,
    required this.config,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.timer),
      title: const Text('Time Window Interceptor'),
      subtitle: Text('Duration: ${config.durationMinutes} mins • Intercept: ${config.shouldIntercept}'),
    );
  }
}
