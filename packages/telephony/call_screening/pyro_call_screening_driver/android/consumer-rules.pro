# 精准保留 Pigeon 跨端通信数据模型与接口，释放其余业务代码供 R8 深度优化
-keep class com.pyro.call_screening.*Request { *; }
-keep class com.pyro.call_screening.*Decision { *; }
-keep class com.pyro.call_screening.*Api* { *; }
-keep class com.pyro.call_screening.FlutterError { *; }

