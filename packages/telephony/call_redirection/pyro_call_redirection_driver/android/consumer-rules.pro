# 精准保留 Pigeon 跨端通信数据模型与接口，释放其余业务代码供 R8 深度优化
-keep class com.pyro.call_redirection.*Request { *; }
-keep class com.pyro.call_redirection.*Decision { *; }
-keep class com.pyro.call_redirection.*Api* { *; }
-keep class com.pyro.call_redirection.FlutterError { *; }

