package com.yours.yourcallyourrule

import android.Manifest
import android.app.Activity
import android.content.Context
import android.content.pm.PackageManager
import android.os.Build
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat

class PermissionsHelper(private val context: Context) {

    val requestPermissionsCode = 1001


    // 需要请求的权限数组
    private val requiredPermissions = arrayOf(
        Manifest.permission.ANSWER_PHONE_CALLS,
        Manifest.permission.READ_PHONE_NUMBERS,
        Manifest.permission.READ_PHONE_STATE,
      //  Manifest.permission.RECEIVE_SMS,
        Manifest.permission.READ_CONTACTS,
        Manifest.permission.READ_CALL_LOG
    )

    // 检查是否已获得所有需要的权限
    fun hasAllPermissions(): Boolean {
        return requiredPermissions.all {
            ContextCompat.checkSelfPermission(context, it) == PackageManager.PERMISSION_GRANTED
        }
    }

    fun requestAppPermissions(activity: Activity, requestCode: Int) {
        ActivityCompat.requestPermissions(activity, requiredPermissions, requestCode)
    }

    //  existing SMS-related methods
    fun hasSmsReceivePermission(): Boolean =
        ContextCompat.checkSelfPermission(
            context,
            Manifest.permission.RECEIVE_SMS
        ) == PackageManager.PERMISSION_GRANTED

    // Call Permission Handling
    fun hasCallPhonePermission(): Boolean =
        ContextCompat.checkSelfPermission(
            context,
            Manifest.permission.CALL_PHONE
        ) == PackageManager.PERMISSION_GRANTED

    fun hasReadPhoneStatePermission(): Boolean =
        ContextCompat.checkSelfPermission(
            context,
            Manifest.permission.READ_PHONE_STATE
        ) == PackageManager.PERMISSION_GRANTED

    fun hasReadPhoneNumbersPermission(): Boolean =
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            ContextCompat.checkSelfPermission(
                context,
                Manifest.permission.READ_PHONE_NUMBERS
            ) == PackageManager.PERMISSION_GRANTED
        } else {
            true
        }

    fun hasRequiredCallPermissions(): Boolean =
        hasCallPhonePermission() &&
                hasReadPhoneStatePermission() &&
                (Build.VERSION.SDK_INT < Build.VERSION_CODES.O || hasReadPhoneNumbersPermission())
}