import 'package:equatable/equatable.dart';
import 'package:yourcallyourrule/core/entities/call/time_interceptor_config.dart';
import '../base_model.dart';

class TimeInterceptorConfigModel extends BaseModel<TimeBasedInterceptorConfig> {
  final Duration duration;
  final bool shouldIntercept;

  const TimeInterceptorConfigModel({
    required super.id,  // 新增id参数
    required this.duration,
    required this.shouldIntercept,
  });  // 传递id到基类

  factory TimeInterceptorConfigModel.fromEntity(TimeBasedInterceptorConfig entity) {
    return TimeInterceptorConfigModel(
      id: entity.id,  // 使用实体id
      duration: entity.duration,
      shouldIntercept: entity.shouldIntercept,
    );
  }

  @override
  TimeBasedInterceptorConfig toEntity() {
    return TimeBasedInterceptorConfig(
      id: id,  // Add id from model
      duration: duration,
      shouldIntercept: shouldIntercept,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'durationInMinutes': duration.inMinutes,
      'shouldIntercept': shouldIntercept,
    };
  }
}