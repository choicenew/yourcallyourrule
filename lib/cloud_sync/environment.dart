/// Class that helps easy access to the environment variables.
class Environment {
  Environment._();

  // MSAL Configuration (OneDrive)
  static const msalClientId = String.fromEnvironment('MSAL_CLIENT_ID', 
      defaultValue: 'b08dc19f-e5f4-4203-bf20-2fd4cf2a4206');
  
  static const msalAndroidRedirectUri = String.fromEnvironment('MSAL_ANDROID_REDIRECT_URI',
      defaultValue: "msauth://com.yours.yourcallyourrule/vTPqTKTC03RK8cQfxyK0j3CRkJs%3D");
  
  static const msalIosAuthority = String.fromEnvironment('MSAL_IOS_AUTHORITY',
      defaultValue: 'https://login.microsoftonline.com/common/oauth2/v2.0/authorize');
  
  // Google Drive Configuration
  static const googleServerClientId = String.fromEnvironment(
      'GOOGLE_SERVER_CLIENT_ID',
      defaultValue: '213507864895-hdmhkq2mbss9mlretgdt6nldil85hdqi.apps.googleusercontent.com');

  // Add other environment configurations as needed
}