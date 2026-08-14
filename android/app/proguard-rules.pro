#====================================================================================
#== Flutter & Android Core Rules (ABSOLUTELY NECESSARY)
#====================================================================================

# Flutter's default rules to protect the engine and its plugins.
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.plugins.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.embedding.**  { *; }
-dontwarn io.flutter.embedding.**

# Keep all implementations of FlutterPlugin to prevent stripping by R8
-keep class * implements io.flutter.embedding.engine.plugins.FlutterPlugin { *; }

# Keep specific plugins that don't follow the io.flutter naming convention
-keep class sk.fourq.calllog.** { *; }
-keep class com.nh97.advanced_call_log.** { *; }
-keep class com.pichillilorenzo.flutter_inappwebview.** { *; }
-keep class com.dexterous.flutterlocalnotifications.** { *; }
-keep class com.yours.live_updates.** { *; }
-keep class com.haygcao.floating_window_android.** { *; }

# This rule is CRITICAL for preventing UnsatisfiedLinkError on JNI calls.
-keepclasseswithmembernames class * {
    native <methods>;
}

# Keep common Android components (entry points) from being stripped away.
# This includes the BroadcastReceiver you mentioned.
-keep public class * extends android.app.Activity
-keep public class * extends android.app.Application
-keep public class * extends android.app.Service
-keep public class * extends android.content.BroadcastReceiver
-keep public class * extends android.content.ContentProvider
-keep public class * extends android.view.View

# Keep Parcelable classes and their CREATOR field, essential for data transfer.
-keepnames class * implements android.os.Parcelable
-keepclassmembers class * implements android.os.Parcelable {
  public static final android.os.Parcelable$Creator CREATOR;
}

# Keep attributes required for reflection by many libraries.
-keepattributes Signature, *Annotation*

#====================================================================================
#== AndroidX & Common Jetpack Library Rules (Keep if you use these libraries)
#====================================================================================

# For AndroidX WorkManager.
-keep class androidx.work.** { *; }
-dontwarn androidx.work.**

# For AndroidX WindowManager extensions.
-keep class androidx.window.extensions.** { *; }
-keep class androidx.window.sidecar.** { *; }
-keep interface androidx.window.extensions.** { *; }
-keep interface androidx.window.sidecar.** { *; }
-dontwarn androidx.window.extensions.**
-dontwarn androidx.window.sidecar.**

#====================================================================================
#== Your Specific Third-Party Library Rules (Based on your feedback)
#====================================================================================

# Rules for libraries that might use Gson for JSON serialization (safe to keep).
-keep class com.google.gson.stream.** { *; }
-keep class * implements com.google.gson.TypeAdapterFactory
-keep class * implements com.google.gson.JsonSerializer
-keep class * implements com.google.gson.JsonDeserializer

# For Microsoft MSAL library (as you confirmed you are using it).
-keep class com.microsoft.identity.client.** { *; }
-dontwarn com.microsoft.identity.client.**

#====================================================================================
#== Suppress Warnings (Safe to keep, makes build logs cleaner)
#====================================================================================
-dontwarn org.bouncycastle.**
-dontwarn edu.umd.cs.findbugs.annotations.**

#====================================================================================
#== Android Default Optimize Rules (Merged to bypass AGP getDefaultProguardFile bug)
#====================================================================================
-allowaccessmodification
-keepattributes AnnotationDefault, EnclosingMethod, InnerClasses, RuntimeVisibleAnnotations, RuntimeVisibleParameterAnnotations, RuntimeVisibleTypeAnnotations, Signature
-keep public class com.google.vending.licensing.ILicensingService
-keep public class com.android.vending.licensing.ILicensingService
-dontnote com.android.vending.licensing.ILicensingService
-dontnote com.google.vending.licensing.ILicensingService
-dontnote android.support.**
-dontnote androidx.**
-dontwarn android.support.**
-dontwarn androidx.**
-keep class android.support.annotation.Keep
-keep @android.support.annotation.Keep class * {*;}
-keepclasseswithmembers class * {
    @android.support.annotation.Keep <methods>;
}
-keepclasseswithmembers class * {
    @android.support.annotation.Keep <fields>;
}
-keepclasseswithmembers class * {
    @android.support.annotation.Keep <init>(...);
}
-dontnote org.apache.http.**
-dontnote android.net.http.**
-dontnote java.lang.invoke.**
