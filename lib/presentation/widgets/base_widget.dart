import 'package:flutter/material.dart';

/// 组件基类
/// 所有自定义组件都应该继承自这个基类
abstract class BaseWidget extends StatelessWidget {
  const BaseWidget({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context);
}

/// 有状态组件基类
/// 所有有状态自定义组件都应该继承自这个基类
abstract class BaseStatefulWidget extends StatefulWidget {
  const BaseStatefulWidget({Key? key}) : super(key: key);
}

/// 有状态组件状态基类
abstract class BaseStatefulWidgetState<T extends BaseStatefulWidget> extends State<T> {
  @override
  Widget build(BuildContext context);
}

/// 通用加载指示器组件
class LoadingIndicator extends BaseWidget {
  final String? message;
  
  const LoadingIndicator({Key? key, this.message}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          if (message != null)
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(message!),
            ),
        ],
      ),
    );
  }
}

/// 通用错误显示组件
class ErrorDisplay extends BaseWidget {
  final String message;
  final VoidCallback? onRetry;
  
  const ErrorDisplay({
    Key? key,
    required this.message,
    this.onRetry,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 48,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(message),
          ),
          if (onRetry != null)
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ElevatedButton(
                onPressed: onRetry,
                child: const Text('重试'),
              ),
            ),
        ],
      ),
    );
  }
}