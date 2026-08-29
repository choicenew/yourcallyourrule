package com.yours.yourcallyourrule

import android.app.Application
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor

/*
class MyApplication : FlutterApplication() {
    lateinit var flutterEngine: FlutterEngine

    override fun onCreate() {
        super.onCreate()
        flutterEngine = FlutterEngine(this)
        flutterEngine.dartExecutor.executeDartEntrypoint(DartExecutor.DartEntrypoint.createDefault())
    }
}
*/


class MyApplication : Application() {
  var flutterEngine : FlutterEngine? = null

  override fun onCreate() {
    super.onCreate()
    // 移除在 Application.onCreate 中的主线程同步预热，由 MainActivity 正常生命周期接管
  }
}