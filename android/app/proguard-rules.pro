#====================================================================================
#== Flutter & Android Core Rules (ABSOLUTELY NECESSARY)
#====================================================================================

# Flutter's default rules to protect the engine and its plugins.
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.embedding.**  { *; }
-dontwarn io.flutter.embedding.**

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