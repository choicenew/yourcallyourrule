// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get cloudSettingsTitle => '클라우드 및 동기화 설정';

  @override
  String get encryptionTitle => '종단간 암호화 (E2EE)';

  @override
  String get encryptionSubtitle => '업로드 전 모든 백업을 AES-256으로 암호화';

  @override
  String get encryptionEnabled => '사용 함 (AES-256)';

  @override
  String get encryptionDisabled => '사용 안 함';

  @override
  String get configuredDrives => '설정된 클라우드 드라이브';

  @override
  String get noDrivesRegistered => '연결된 클라우드 드라이브 없음';

  @override
  String get cancel => '취소';

  @override
  String get save => '저장';

  @override
  String get saveAndEnable => '저장 및 활성화';

  @override
  String get setPasswordTitle => 'E2EE 마스터 비밀번호 설정';

  @override
  String get setPasswordDescription => '백업은 업로드 전 AES-256으로 암호화됩니다.';

  @override
  String get masterPasswordLabel => '마스터 비밀번호';

  @override
  String get passwordEmptyError => '비밀번호는 비워둘 수 없습니다';

  @override
  String get syncNow => '지금 동기화';

  @override
  String get settings => '설정';

  @override
  String get connected => '연결됨';

  @override
  String get disconnected => '연결 끊김';

  @override
  String lastSynced(String time) {
    return '마지막 동기화: $time';
  }
}
