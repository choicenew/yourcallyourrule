/// 悬浮窗原生平台 Driver 抽象接口契约 (PhoneOverlayDriver)
abstract class PhoneOverlayDriver {
  Future<void> showOverlay(String phoneNumber, String info);
  Future<void> closeOverlay();
}
