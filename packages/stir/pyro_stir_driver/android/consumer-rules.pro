# 精准保留 Pigeon 跨端通信数据模型与接口，释放其余业务代码供 R8 深度优化
-keep class com.pyro.stir.*Request { *; }
-keep class com.pyro.stir.*Response { *; }
-keep class com.pyro.stir.*Api* { *; }
-keep class com.pyro.stir.FlutterError { *; }

