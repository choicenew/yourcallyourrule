# Please add these rules to your existing keep rules in order to suppress warnings.
# This is generated automatically by the Android Gradle plugin.
-dontwarn edu.umd.cs.findbugs.annotations.NonNull
-dontwarn edu.umd.cs.findbugs.annotations.Nullable
-dontwarn edu.umd.cs.findbugs.annotations.SuppressFBWarnings
-dontwarn org.bouncycastle.asn1.ASN1Encodable
-dontwarn org.bouncycastle.asn1.pkcs.PrivateKeyInfo
-dontwarn org.bouncycastle.asn1.x509.AlgorithmIdentifier
-dontwarn org.bouncycastle.asn1.x509.SubjectPublicKeyInfo
-dontwarn org.bouncycastle.cert.X509CertificateHolder
-dontwarn org.bouncycastle.cert.jcajce.JcaX509CertificateHolder
-dontwarn org.bouncycastle.crypto.BlockCipher
-dontwarn org.bouncycastle.crypto.CipherParameters
-dontwarn org.bouncycastle.crypto.InvalidCipherTextException
-dontwarn org.bouncycastle.crypto.engines.AESEngine
-dontwarn org.bouncycastle.crypto.modes.GCMBlockCipher
-dontwarn org.bouncycastle.crypto.params.AEADParameters
-dontwarn org.bouncycastle.crypto.params.KeyParameter
-dontwarn org.bouncycastle.jcajce.provider.BouncyCastleFipsProvider
-dontwarn org.bouncycastle.jce.provider.BouncyCastleProvider
-dontwarn org.bouncycastle.openssl.PEMKeyPair
-dontwarn org.bouncycastle.openssl.PEMParser
-dontwarn org.bouncycastle.openssl.jcajce.JcaPEMKeyConverter
-keep class androidx.window.extensions.** { *; }
-keep class androidx.window.sidecar.** { *; }
-keep interface androidx.window.extensions.** { *; }
-keep interface androidx.window.sidecar.** { *; }
-dontwarn androidx.window.extensions.**
-dontwarn androidx.window.sidecar.**
#====================================================================================
#== Flutter Core Rules (ABSOLUTELY NECESSARY)
#== These rules protect the Flutter engine itself from being obfuscated.
#====================================================================================
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.embedding.**  { *; }
-keep class io.flutter.embedding.android.**  { *; }
-dontwarn io.flutter.embedding.android.FlutterFragment
-keep class **.R$* {
    <fields>;
}

#====================================================================================
#== Common Firebase Rules
#== Add these if you use any Firebase plugins (Auth, Firestore, Crashlytics, etc.)
#====================================================================================
-keep public class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }
-dontwarn com.google.android.gms.**
-keepattributes Signature
-keepattributes *Annotation*
-keep class com.google.firebase.messaging.** { *; }

#====================================================================================
#== Google Mobile Ads (AdMob) Rules
#== Add these if you use the google_mobile_ads plugin.
#====================================================================================
-keep public class com.google.android.gms.ads.** {
   public *;
}
-keep class com.google.ads.mediation.** {
    *;
}

#====================================================================================
#== Microsoft MSAL Rules (Based on your AndroidManifest.xml)
#== Since you have BrowserTabActivity from MSAL, these are likely needed.
#====================================================================================
-keep class com.microsoft.identity.client.** { *; }
-dontwarn com.microsoft.identity.client.**

#====================================================================================
#== Other common plugins (add if you use them)
#====================================================================================

# For flutter_local_notifications
-keep class com.dexterous.flutterlocalnotifications.** { *; }

# For webview_flutter or flutter_inappwebview
-keep public class * extends android.webkit.WebViewClient {
    public *;
}
-keep public class * extends android.webkit.WebChromeClient {
    public *;
}

# For libraries using Gson for JSON serialization
-keep class com.google.gson.stream.** { *; }
-keep class * implements com.google.gson.TypeAdapterFactory
-keep class * implements com.google.gson.JsonSerializer
-keep class * implements com.google.gson.JsonDeserializer

#====================================================================================
#== Google Play Core Library Rules
#== Required by Flutter engine for deferred components support.
#====================================================================================
-keep class com.google.android.play.core.** { *; }
-dontwarn com.google.android.play.core.**