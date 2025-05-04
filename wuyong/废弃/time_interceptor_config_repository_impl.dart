import 'package:yourcallyourrule/data/repositories/call/time_interceptor_config.dart';
import 'package:yourcallyourrule/data/models/call/time_interceptor_config_model.dart';
import 'package:yourcallyourrule/core/repositories/base_repository.dart';
import 'package:yourcallyourrule/data/repositories/base_repository_impl.dart';

class TimeInterceptorConfigRepositoryImpl
    extends BaseRepositoryImpl<TimeBasedInterceptorConfig, TimeInterceptorConfigModel, String>
    implements BaseRepository<TimeBasedInterceptorConfig, String> {
  TimeInterceptorConfigRepositoryImpl(super.dataSource);

  @override
  TimeInterceptorConfigModel toModel(TimeBasedInterceptorConfig entity) {
    return TimeInterceptorConfigModel.fromEntity(entity);
  }

  @override
  TimeBasedInterceptorConfig toEntity(TimeInterceptorConfigModel model) {
    return model.toEntity();
  }

  // region Missing Implementations
  @override
  Future<int> count() async {
    return dataSource.count();
  }

  @override
  TimeBasedInterceptorConfig fromMap(Map<String, dynamic> map) {
    return TimeInterceptorConfigModel(
      id: map['id'] as String,
      duration: Duration(minutes: map['durationInMinutes'] as int),
      shouldIntercept: map['shouldIntercept'] as bool,
    ).toEntity();
  }

  @override
  Future<TimeBasedInterceptorConfig> update(TimeBasedInterceptorConfig entity) async {
    final model = toModel(entity);
    final updatedModel = await dataSource.update(model);
    return toEntity(updatedModel);
  }
  // endregion
}