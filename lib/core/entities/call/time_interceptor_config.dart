import 'package:equatable/equatable.dart';
import 'package:yourcallyourrule/core/base/base_entity.dart';

class TimeBasedInterceptorConfig extends BaseEntity {
  final Duration duration;
  final bool shouldIntercept;

  const TimeBasedInterceptorConfig({
    super.id = 'time_interceptor_config', // 固定ID
    this.duration = const Duration(minutes: 30),
    this.shouldIntercept = true,
  });

  List<Object> get props => [id, duration, shouldIntercept];}
