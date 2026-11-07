import 'dart:async';
import 'task.dart';
import 'actor.dart';
import 'default_dispatcher.dart';

/// 全局工作线程调度中枢接口 (WorkerDispatcher)
abstract class WorkerDispatcher {
  static WorkerDispatcher _instance = DefaultAdaptiveWorkerDispatcher();

  /// 获取当前活跃的调度器实例
  static WorkerDispatcher get instance => _instance;

  /// 允许主 App 在启动时注入高阶调度器（如设备感知长驻线程池）
  static void setInstance(WorkerDispatcher custom) {
    _instance = custom;
  }

  /// 执行一过性纯计算任务
  Future<Output> execute<Input, Output>(WorkerTask<Input, Output> task, Input input);

  /// 启动并挂载一个长驻 Actor
  Future<ActorHandle<Req, Resp>> spawnActor<Req, Resp>(DedicatedActorWorker<Req, Resp> actor);
}
