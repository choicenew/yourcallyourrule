package com.yours.yourcallyourrule

import android.app.Activity
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.content.ServiceConnection
import android.os.IBinder
import android.util.Log


class CallScreeningHelper(private val activity: Activity) {

    private var myServiceConnection: ServiceConnection? = null

    fun bindCallScreeningService() {
        val myCallServiceIntent = Intent(activity, MyCallScreeningService::class.java)
        myServiceConnection = object : ServiceConnection {
            override fun onServiceConnected(componentName: ComponentName, iBinder: IBinder) {
                // 在服务连接成功时执行操作
          //      Log.e("MainActivity", "MyCallScreeningService 服务连接成功")
            }

            override fun onServiceDisconnected(componentName: ComponentName) {
                // 在服务断开连接时执行操作
              //  Log.e("MainActivity", "MyCallScreeningService 服务断开连接")
            }

            override fun onBindingDied(name: ComponentName) {
                // 在绑定失败时执行操作
              //  Log.e("MainActivity", "MyCallScreeningService 绑定失败")
            }
        }

        activity.bindService(
            myCallServiceIntent,
            myServiceConnection!!,
            Context.BIND_AUTO_CREATE
        )
    }

    fun unbindCallScreeningService() {
        myServiceConnection?.let { activity.unbindService(it) }
        myServiceConnection = null
    }
}