# ProGuard rules for pyro_sms_driver_notification_listener
# Keep Pigeon generated data payloads, interfaces, and companion codecs
-keep class com.pyro.sms_notification_listener.PigeonSmsNotificationPayload { *; }
-keep class com.pyro.sms_notification_listener.PigeonSmsEvidencePayload { *; }
-keep class com.pyro.sms_notification_listener.SmsNotificationListenerHostApi* { *; }
-keep class com.pyro.sms_notification_listener.SmsNotificationListenerFlutterApi* { *; }
-keep class com.pyro.sms_notification_listener.FlutterError { *; }

