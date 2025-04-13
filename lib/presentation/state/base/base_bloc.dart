import 'package:flutter_bloc/flutter_bloc.dart';

/// 事件基类
abstract class BaseEvent {}

/// 状态基类
abstract class BaseState {}

/// 初始状态
class InitialState extends BaseState {}

/// 加载中状态
class LoadingState extends BaseState {}

/// 加载成功状态
class LoadedState<T> extends BaseState {
  final T data;

  LoadedState(this.data);
}

/// 错误状态
class ErrorState extends BaseState {
  final String message;

  ErrorState(this.message);
}

/// 基础Bloc类
/// 所有Bloc状态管理类都应该继承自这个基类
abstract class BaseBloc<E extends BaseEvent, S extends BaseState>
    extends Bloc<E, S> {
  BaseBloc(S initialState) : super(initialState);

  /// 处理异常
  void handleException(dynamic exception) {
    debugPrint('Bloc异常: $exception');
  }
}
