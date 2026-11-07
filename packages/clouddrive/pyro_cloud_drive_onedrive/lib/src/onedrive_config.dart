class OneDriveConfig {
  static const String defaultClientId = String.fromEnvironment(
    'MSAL_CLIENT_ID',
    defaultValue: '889a210d-4125-4f87-9937-cd8ae28aa1fd',
  );

  static const String defaultIosAuthority = String.fromEnvironment(
    'MSAL_IOS_AUTHORITY',
    defaultValue: 'https://login.microsoftonline.com/common/oauth2/v2.0/authorize',
  );
}
