/// Class that helps easy access to the environment variables.
class Environment {
  Environment._();

  // MSAL Configuration (OneDrive)
  static const msalClientId = String.fromEnvironment('MSAL_CLIENT_ID', 
      defaultValue: 'your-client-id');
  
  static const msalAndroidRedirectUri = String.fromEnvironment('MSAL_ANDROID_REDIRECT_URI',
      defaultValue: "msauth://com.yours.yourcallyourrule/vTPqTKTC03RK8cQfxyK0j3CRkJs%3D");
  
  static const msalIosAuthority = String.fromEnvironment('MSAL_IOS_AUTHORITY',
      defaultValue: 'https://login.microsoftonline.com/common/oauth2/v2.0/authorize');
  
  // Google Drive Configuration is not needed as it uses app signature for authentication
  
  // Add other environment configurations as needed
}