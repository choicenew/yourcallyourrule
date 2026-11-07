import 'dart:async';

/// 长驻重型资源引擎 Actor 契约 (DedicatedActorWorker)
///
/// 针对 ONNX Runtime 推理引擎、河图脚本 VM 等初始化极其昂贵、
/// 包含 C++ 底层指针不能频繁短生命周期创建/销毁的常驻资源。
abstract class DedicatedActorWorker<Req, Resp> {
  final String actorName;

  DedicatedActorWorker({required this.actorName});

  /// 在专属后台副线程内部执行的完整初始化逻辑
  Future<void> onInitialize();

  /// 在副线程内部处理收到的异步请求并返回响应
  Future<Resp> onHandleMessage(Req message);

  /// 释放副线程内资源
  Future<void> onDispose();
}

/// 外部与长驻 Actor 交互的通信句柄
abstract class ActorHandle<Req, Resp> {
  /// 向长驻 Actor 发送请求并异步获取结果
  Future<Resp> send(Req message);

  /// 销毁长驻 Actor 线程
  Future<void> dispose();
}
