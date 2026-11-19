# ProGuard rules for pyro_sms_driver_telephony_fallback
# Keep Pigeon generated data payloads, interfaces, and companion codecs
-keep class com.pyro.sms_telephony_fallback.PigeonTelephonySmsPayload { *; }
-keep class com.pyro.sms_telephony_fallback.TelephonyFallbackHostApi* { *; }
-keep class com.pyro.sms_telephony_fallback.TelephonyFallbackFlutterApi* { *; }
-keep class com.pyro.sms_telephony_fallback.FlutterError { *; }

