# ProGuard rules for pyro_sim_driver
# Keep Pigeon generated data payloads, interfaces, and companion codecs
-keep class com.pyro.sim.PigeonSimCard { *; }
-keep class com.pyro.sim.PigeonNetworkInfo { *; }
-keep class com.pyro.sim.SimHostApi* { *; }
-keep class com.pyro.sim.FlutterError { *; }
