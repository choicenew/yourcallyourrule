google_sign_in 7.1.0 required serverClientId for Android #172073
Closed
flutter/packages
#9629
Closed
google_sign_in 7.1.0 required serverClientId for Android
#172073
flutter/packages
#9629
@adibzter
Description
adibzter
opened last month
Hello everyone, I just upgraded google_sign_in from 6.2.2 to 7.1.0 and encountered this error:

GoogleSignInException(code GoogleSignInExceptionCode.clientConfigurationError, serverClientId must be provided on Android, null

I managed to fix this issue by providing my web client ID instead of the Android one.

What I don't understand is that in the integration docs, it stated that I don't need serverClientId if I already provided google-services.json

If you are not using google-services.json, you need to pass the client ID of the web application you registered as the serverClientId when initialising the GoogleSignIn instance.

Hope anyone can help me understand more about this issue and clear up any misunderstanding on my side.

Thank you.

Activity
stuartmorgan-g
stuartmorgan-g commented last month
stuartmorgan-g
last month
Contributor
Please provide complete details about your configuration, since without that there's no way for us to know whether that error message is expected or not. In particular:

Had you correctly followed all of these setup instructions?
What was the code that reproduced this error, including setup such as initialize and the call that threw that exception?

stuartmorgan-g
added 
waiting for customer response
The Flutter team cannot make further progress on this issue until the original reporter responds
 last month
adibzter
adibzter commented last month
adibzter
last month · edited by adibzter
Author
Yes, I followed the setup instructions.

The code below is called in the main function

static void initialize() async {
  final GoogleSignIn googleSignIn = GoogleSignIn.instance;
  await googleSignIn.initialize();
  
  googleSignIn.authenticationEvents.listen((
    GoogleSignInAuthenticationEvent event,
  ) {
    if (event is GoogleSignInAuthenticationEventSignIn) {
      String? idToken = event.user.authentication.idToken;
      if (idToken == null) {
        return;
      }
      _handleSessionSignIn(idToken);
    }
  });
}
When the code below is called, the error I mentioned is thrown

static Future<void> signIn() async {
  try {
    final GoogleSignInAccount googleUser = await GoogleSignIn.instance.authenticate();
    final GoogleSignInAuthentication googleAuth = googleUser.authentication;

    await _handleSessionSignIn(googleAuth.idToken as String);
  } catch (e) {
    developer.log(e.toString(), name: 'hehe error signin');
    throw (e.toString());
  }
}
It works if I initialise it with serverClientId

await googleSignIn.initialize(serverClientId: 'xyz.apps.googleusercontent.com');

github-actions
removed 
waiting for customer response
The Flutter team cannot make further progress on this issue until the original reporter responds
 last month
stuartmorgan-g
stuartmorgan-g commented last month
stuartmorgan-g
last month
Contributor
When you do a debug build of your app, do you have a build/app/generated/res/processDebugGoogleServices/values/values.xml containing default_web_client_id?

Also, are you ensuring that your initialize() has completed before calling your signIn() method? You aren't declaring it as returning a Future, which suggests that you aren't awaiting its completion.


stuartmorgan-g
added 
waiting for customer response
The Flutter team cannot make further progress on this issue until the original reporter responds
 last month
maheshj01
maheshj01 commented last month
maheshj01
last month
Member
I ran into this today I was able to solve this by passing the serverClientId (aka client_id from Google cloud console). Anyone running into this issue initlialize the GoogleSignIn instance with a serverClientId before accessing other apis

Go to Google Cloud Console:
Select your project.
Navigate to APIs & Services → Credentials.
Under OAuth 2.0 Client IDs, find the Web client (not Android or iOS).
Copy the Client ID listed there — this is your serverClientId.

 _googleSignIn.initialize(
      serverClientId: <clientId here>
   );
and then use the other apis

  final GoogleSignInAccount result = await _googleSignIn.authenticate();
  final googleKey = result.authentication;
  final GoogleSignInClientAuthorization? authorization =
        await result.authorizationClient.authorizationForScopes(scopes);
...
adibzter
adibzter commented last month
adibzter
last month · edited by adibzter
Author
@stuartmorgan-g I can't find build/app/generated/res/processDebugGoogleServices/values/values.xml in my project.

You are correct that I did not ensure initialize() completed before calling signIn(). So I tried to await the initialisation then immediately call the signIn method and still managed to reproduce the same error

final GoogleSignIn googleSignIn = GoogleSignIn.instance;
await googleSignIn.initialize();
signIn();
GoogleSignInException(code GoogleSignInExceptionCode.clientConfigurationError, serverClientId must be provided on Android, null)


github-actions
removed 
waiting for customer response
The Flutter team cannot make further progress on this issue until the original reporter responds
 last month
stuartmorgan-g
stuartmorgan-g commented last month
stuartmorgan-g
last month
Contributor
I can't find build/app/generated/res/processDebugGoogleServices/values/values.xml in my project.

Are you using Firebase for anything other than the google_sign_in configuration? It sounds like this step may not be configured correctly for your project.


tirth-patel-nc
added 
in triage
Presently being triaged by the triage team
 
waiting for customer response
The Flutter team cannot make further progress on this issue until the original reporter responds
 last month
asadamatic
asadamatic commented last month
asadamatic
last month · edited by asadamatic
I just faced the same issue with version 7.0.1.

( 3879): Error during sign in: GoogleSignInException(code GoogleSignInExceptionCode.clientConfigurationError, serverClientId must be provided on Android, null)
I have the google-services.json file, and I'm using the Google Sign In directly instead of using the Firebase Auth. I have added the iOS and Android OAuth clients, and I do not have a server/website.

adibzter
adibzter commented last month
adibzter
last month
Author
I can't find build/app/generated/res/processDebugGoogleServices/values/values.xml in my project.

Are you using Firebase for anything other than the google_sign_in configuration? It sounds like this step may not be configured correctly for your project.

I also use Firebase for Crashlytics and it works fine.

My project structure looks different from the setup, maybe due to an old project. I will try to reproduce this in a newly created project.


github-actions
removed 
waiting for customer response
The Flutter team cannot make further progress on this issue until the original reporter responds
 last month
asadamatic
asadamatic commented last month
asadamatic
last month
I added a web OAuth client, reconfigured the project with Firebase using flutterfire, which updates the google-services.json and now it works. Strange!

asadamatic
asadamatic commented last month
asadamatic
last month · edited by asadamatic
@adibzter Let us know if you're able to reproduce it.


stuartmorgan-g
added 
platform-android
Android applications specifically
 
p: google_sign_in
The Google Sign-In plugin
 
package
flutter/packages repository. See also p: labels.
 
team-ecosystem
Owned by Ecosystem team
 
P2
Important issues not at the top of the work list
 
triaged-ecosystem
Triaged by Ecosystem team
 and removed 
in triage
Presently being triaged by the triage team
 last month

stuartmorgan-g
self-assigned thislast month
stuartmorgan-g
stuartmorgan-g commented last month
stuartmorgan-g
last month
Contributor
I thought the Firebase configuration automatically created a web client, but it sounds like that's not always the case. I'll clarify in the docs that it's necessary for the google-services.json route.

MichalDanielDobrzanski
MichalDanielDobrzanski commented last month
MichalDanielDobrzanski
last month · Hidden as off-topic
Crucialjun
Crucialjun commented 3 weeks ago
Crucialjun
3 weeks ago · Hidden as duplicate

stuartmorgan-g
mentioned this 3 weeks ago
[google_sign_in] Add more serverClientId info to README flutter/packages#9629
stuartmorgan-g
stuartmorgan-g commented 3 weeks ago
stuartmorgan-g
3 weeks ago
Contributor
I'm using the Google Sign In directly instead of using the Firebase Auth. I have added the iOS and Android OAuth clients, and I do not have a server/website.
[...]
I added a web OAuth client, reconfigured the project with Firebase using flutterfire, which updates the google-services.json and now it works. Strange!

@asadamatic That makes sense; if you didn't follow the Firebase setup for Google Sign In, then it wouldn't have auto-created a web OAuth client, and so the google-services.json wouldn't have had a client ID for serverClientId to default to. Adding a web OAuth client manually would resolve that.

The PR updates the docs to clarify the requirements here.

asadamatic
asadamatic commented 3 weeks ago
asadamatic
3 weeks ago
@stuartmorgan-g Thank you for the clarification

Darius253
Darius253 commented 3 weeks ago
Darius253
3 weeks ago · Hidden as off-topic

auto-submit
closed this as completedin #96292 weeks ago

tirth-patel-nc
added 
r: fixed
Issue is closed as already fixed in a newer version
 2 weeks ago

pull
added a commit that references this issue 2 weeks ago
[google_sign_in] Add more serverClientId info to README (flutter#9629)

Verified
963550c
giorgio79
giorgio79 commented last week
giorgio79
last week
Thank you @maheshj01 for the clear step by step explanations, they solved this error. It is strange we have to hardcode the client id, but if thats the way then so be it.

akurnaz
akurnaz commented last week
akurnaz
last week
If we need to call the initialize method before authenticate, then the code example in this documentation is misleading.

https://firebase.google.com/docs/auth/flutter/federated-auth#google


vashworth
added a commit that references this issue last week
[google_sign_in] Add more serverClientId info to README (flutter#9629)

google_sign_in 7.1.0 required serverClientId for Android #172073
Closed
flutter/packages
#9629
Closed
google_sign_in 7.1.0 required serverClientId for Android
#172073
flutter/packages
#9629
@adibzter
Description
adibzter
opened last month
Hello everyone, I just upgraded google_sign_in from 6.2.2 to 7.1.0 and encountered this error:

GoogleSignInException(code GoogleSignInExceptionCode.clientConfigurationError, serverClientId must be provided on Android, null

I managed to fix this issue by providing my web client ID instead of the Android one.

What I don't understand is that in the integration docs, it stated that I don't need serverClientId if I already provided google-services.json

If you are not using google-services.json, you need to pass the client ID of the web application you registered as the serverClientId when initialising the GoogleSignIn instance.

Hope anyone can help me understand more about this issue and clear up any misunderstanding on my side.

Thank you.

Activity
stuartmorgan-g
stuartmorgan-g commented last month
stuartmorgan-g
last month
Contributor
Please provide complete details about your configuration, since without that there's no way for us to know whether that error message is expected or not. In particular:

Had you correctly followed all of these setup instructions?
What was the code that reproduced this error, including setup such as initialize and the call that threw that exception?

stuartmorgan-g
added 
waiting for customer response
The Flutter team cannot make further progress on this issue until the original reporter responds
 last month
adibzter
adibzter commented last month
adibzter
last month · edited by adibzter
Author
Yes, I followed the setup instructions.

The code below is called in the main function

static void initialize() async {
  final GoogleSignIn googleSignIn = GoogleSignIn.instance;
  await googleSignIn.initialize();
  
  googleSignIn.authenticationEvents.listen((
    GoogleSignInAuthenticationEvent event,
  ) {
    if (event is GoogleSignInAuthenticationEventSignIn) {
      String? idToken = event.user.authentication.idToken;
      if (idToken == null) {
        return;
      }
      _handleSessionSignIn(idToken);
    }
  });
}
When the code below is called, the error I mentioned is thrown

static Future<void> signIn() async {
  try {
    final GoogleSignInAccount googleUser = await GoogleSignIn.instance.authenticate();
    final GoogleSignInAuthentication googleAuth = googleUser.authentication;

    await _handleSessionSignIn(googleAuth.idToken as String);
  } catch (e) {
    developer.log(e.toString(), name: 'hehe error signin');
    throw (e.toString());
  }
}
It works if I initialise it with serverClientId

await googleSignIn.initialize(serverClientId: 'xyz.apps.googleusercontent.com');

github-actions
removed 
waiting for customer response
The Flutter team cannot make further progress on this issue until the original reporter responds
 last month
stuartmorgan-g
stuartmorgan-g commented last month
stuartmorgan-g
last month
Contributor
When you do a debug build of your app, do you have a build/app/generated/res/processDebugGoogleServices/values/values.xml containing default_web_client_id?

Also, are you ensuring that your initialize() has completed before calling your signIn() method? You aren't declaring it as returning a Future, which suggests that you aren't awaiting its completion.


stuartmorgan-g
added 
waiting for customer response
The Flutter team cannot make further progress on this issue until the original reporter responds
 last month
maheshj01
maheshj01 commented last month
maheshj01
last month
Member
I ran into this today I was able to solve this by passing the serverClientId (aka client_id from Google cloud console). Anyone running into this issue initlialize the GoogleSignIn instance with a serverClientId before accessing other apis

Go to Google Cloud Console:
Select your project.
Navigate to APIs & Services → Credentials.
Under OAuth 2.0 Client IDs, find the Web client (not Android or iOS).
Copy the Client ID listed there — this is your serverClientId.

 _googleSignIn.initialize(
      serverClientId: <clientId here>
   );
and then use the other apis

  final GoogleSignInAccount result = await _googleSignIn.authenticate();
  final googleKey = result.authentication;
  final GoogleSignInClientAuthorization? authorization =
        await result.authorizationClient.authorizationForScopes(scopes);
...
adibzter
adibzter commented last month
adibzter
last month · edited by adibzter
Author
@stuartmorgan-g I can't find build/app/generated/res/processDebugGoogleServices/values/values.xml in my project.

You are correct that I did not ensure initialize() completed before calling signIn(). So I tried to await the initialisation then immediately call the signIn method and still managed to reproduce the same error

final GoogleSignIn googleSignIn = GoogleSignIn.instance;
await googleSignIn.initialize();
signIn();
GoogleSignInException(code GoogleSignInExceptionCode.clientConfigurationError, serverClientId must be provided on Android, null)


github-actions
removed 
waiting for customer response
The Flutter team cannot make further progress on this issue until the original reporter responds
 last month
stuartmorgan-g
stuartmorgan-g commented last month
stuartmorgan-g
last month
Contributor
I can't find build/app/generated/res/processDebugGoogleServices/values/values.xml in my project.

Are you using Firebase for anything other than the google_sign_in configuration? It sounds like this step may not be configured correctly for your project.


tirth-patel-nc
added 
in triage
Presently being triaged by the triage team
 
waiting for customer response
The Flutter team cannot make further progress on this issue until the original reporter responds
 last month
asadamatic
asadamatic commented last month
asadamatic
last month · edited by asadamatic
I just faced the same issue with version 7.0.1.

( 3879): Error during sign in: GoogleSignInException(code GoogleSignInExceptionCode.clientConfigurationError, serverClientId must be provided on Android, null)
I have the google-services.json file, and I'm using the Google Sign In directly instead of using the Firebase Auth. I have added the iOS and Android OAuth clients, and I do not have a server/website.

adibzter
adibzter commented last month
adibzter
last month
Author
I can't find build/app/generated/res/processDebugGoogleServices/values/values.xml in my project.

Are you using Firebase for anything other than the google_sign_in configuration? It sounds like this step may not be configured correctly for your project.

I also use Firebase for Crashlytics and it works fine.

My project structure looks different from the setup, maybe due to an old project. I will try to reproduce this in a newly created project.


github-actions
removed 
waiting for customer response
The Flutter team cannot make further progress on this issue until the original reporter responds
 last month
19 remaining items

stuartmorgan-g
self-assigned thislast month
stuartmorgan-g
stuartmorgan-g commented last month
stuartmorgan-g
last month
Contributor
I thought the Firebase configuration automatically created a web client, but it sounds like that's not always the case. I'll clarify in the docs that it's necessary for the google-services.json route.

MichalDanielDobrzanski
MichalDanielDobrzanski commented last month
MichalDanielDobrzanski
last month · Hidden as off-topic
Crucialjun
Crucialjun commented 3 weeks ago
Crucialjun
3 weeks ago · Hidden as duplicate

stuartmorgan-g
mentioned this 3 weeks ago
[google_sign_in] Add more serverClientId info to README flutter/packages#9629
stuartmorgan-g
stuartmorgan-g commented 3 weeks ago
stuartmorgan-g
3 weeks ago
Contributor
I'm using the Google Sign In directly instead of using the Firebase Auth. I have added the iOS and Android OAuth clients, and I do not have a server/website.
[...]
I added a web OAuth client, reconfigured the project with Firebase using flutterfire, which updates the google-services.json and now it works. Strange!

@asadamatic That makes sense; if you didn't follow the Firebase setup for Google Sign In, then it wouldn't have auto-created a web OAuth client, and so the google-services.json wouldn't have had a client ID for serverClientId to default to. Adding a web OAuth client manually would resolve that.

The PR updates the docs to clarify the requirements here.

asadamatic
asadamatic commented 3 weeks ago
asadamatic
3 weeks ago
@stuartmorgan-g Thank you for the clarification

Darius253
Darius253 commented 3 weeks ago
Darius253
3 weeks ago · Hidden as off-topic

auto-submit
closed this as completedin #96292 weeks ago

tirth-patel-nc
added 
r: fixed
Issue is closed as already fixed in a newer version
 2 weeks ago

pull
added a commit that references this issue 2 weeks ago
[google_sign_in] Add more serverClientId info to README (flutter#9629)

Verified
963550c
giorgio79
giorgio79 commented last week
giorgio79
last week
Thank you @maheshj01 for the clear step by step explanations, they solved this error. It is strange we have to hardcode the client id, but if thats the way then so be it.

akurnaz
akurnaz commented last week
akurnaz
last week
If we need to call the initialize method before authenticate, then the code example in this documentation is misleading.

https://firebase.google.com/docs/auth/flutter/federated-auth#google


vashworth
added a commit that references this issue last week
[google_sign_in] Add more serverClientId info to README (flutter#9629)

google_sign_in 7.11 - GoogleSignInExceptionCode.canceled or firebase_auth/network-request-failed #173134
Closed as not planned
@dumabg
Description
dumabg
opened last week
Steps to reproduce
I've upgraded google_sign_in from 6.0.2 to 7.1.1.

After update the code for the new version, Firebase Authentication doesn't works. When signInWithCredential is called, launch the exception I/flutter (25218): [firebase_auth/network-request-failed] A network error (such as timeout, interrupted connection or unreachable host) has occurred.

I've reviewed all the configuration and all seems correct. The app has connection to Internet, it uses the server without problems.

Like I can't found anything, I've created a new Flutter project, and add the Firebase project of my app. Now google_sign_in gives the error on authenticate(), but gives another one: GoogleSignInException(code GoogleSignInExceptionCode.canceled, activity is cancelled by the user., null)

The code is:

  Future<void> login() async {
    final GoogleSignIn googleSignIn = GoogleSignIn.instance;
    await googleSignIn.initialize();
    final GoogleSignInAccount googleUser = await googleSignIn.authenticate();
    final GoogleSignInAuthentication googleAuth = googleUser.authentication;
    final OAuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );
    final auth = FirebaseAuth.instance;
    final UserCredential userCredential = await auth.signInWithCredential(
      credential,
    );
    print(userCredential);
  }
Launched from the floating increment button:

 floatingActionButton: FloatingActionButton(
        // onPressed: _incrementCounter,
        onPressed: login,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      )
In summary:

On my current app, gives the error network-request-failed on auth.signInWithCredential.
On the sample project, gives the error GoogleSignInExceptionCode.canceled on googleSignIn.authenticate().
Expected results
Login with Google without errors.

Actual results
The app can't login with google_sing_in.

Code sample
  Future<void> login() async {
    final GoogleSignIn googleSignIn = GoogleSignIn.instance;
    await googleSignIn.initialize();
    final GoogleSignInAccount googleUser = await googleSignIn.authenticate();
    final GoogleSignInAuthentication googleAuth = googleUser.authentication;
    final OAuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );
    final auth = FirebaseAuth.instance;
    final UserCredential userCredential = await auth.signInWithCredential(
      credential,
    );
    print(userCredential);
  }
Screenshots or Video
Screenshots / Video demonstration
[Upload media here]

Logs
Logs
[Paste your logs here]
Flutter Doctor output
[✓] Flutter (Channel stable, 3.32.6, on Ubuntu 25.04 6.14.0-27-generic, locale es_ES.UTF-8) [70ms]
• Flutter version 3.32.6 on channel stable at /opt/flutter
• Upstream repository https://github.com/flutter/flutter.git
• Framework revision 077b4a4 (hace 3 semanas), 2025-07-08 13:31:08 -0700
• Engine revision 72f2b18
• Dart version 3.8.1
• DevTools version 2.45.1

[✓] Android toolchain - develop for Android devices (Android SDK version 35.0.1) [798ms]
• Android SDK at /opt/android-sdk
• Platform android-35, build-tools 35.0.1
• Java binary at: /opt/android-studio/jbr/bin/java
This is the JDK bundled with the latest Android Studio installation on this machine.
To manually set the JDK path, use: flutter config --jdk-dir="path/to/jdk".
• Java version OpenJDK Runtime Environment (build 21.0.5+-12932927-b750.29)
• All Android licenses accepted.

[✓] Chrome - develop for the web [8ms]
• Chrome at google-chrome

[✓] Linux toolchain - develop for Linux desktop [505ms]
• Ubuntu clang version 20.1.2 (0ubuntu1)
• cmake version 3.31.6
• ninja version 1.12.1
• pkg-config version 1.8.1
• OpenGL core renderer: Mesa Intel(R) Graphics (RPL-P)
• OpenGL core version: 4.6 (Core Profile) Mesa 25.0.7-0ubuntu0.25.04.1
• OpenGL core shading language version: 4.60
• OpenGL ES renderer: Mesa Intel(R) Graphics (RPL-P)
• OpenGL ES version: OpenGL ES 3.2 Mesa 25.0.7-0ubuntu0.25.04.1
• OpenGL ES shading language version: OpenGL ES GLSL ES 3.20
• GL_EXT_framebuffer_blit: yes
• GL_EXT_texture_format_BGRA8888: yes

[✓] Android Studio (version 2024.3) [7ms]
• Android Studio at /opt/android-studio
• Flutter plugin can be installed from:
🔨 https://plugins.jetbrains.com/plugin/9212-flutter
• Dart plugin can be installed from:
🔨 https://plugins.jetbrains.com/plugin/6351-dart
• Java version OpenJDK Runtime Environment (build 21.0.5+-12932927-b750.29)

[✓] VS Code (version unknown) [6ms]
• VS Code at /usr/share/code
• Flutter extension version 3.116.0
✗ Unable to determine VS Code version.

[✓] Connected device (3 available) [163ms]
• SM A225M (mobile) • RX8RB01MDJZ • android-arm64 • Android 13 (API 33)
• Linux (desktop) • linux • linux-x64 • Ubuntu 25.04 6.14.0-27-generic
• Chrome (web) • chrome • web-javascript • Google Chrome 138.0.7204.183

[✓] Network resources [570ms]
• All expected network resources are available.

• No issues found!

Activity

dumabg
changed the title [-]gloogle_sign_in 7.11 - GoogleSignInExceptionCode.canceled or firebase_auth/network-request-failed[/-] [+]google_sign_in 7.11 - GoogleSignInExceptionCode.canceled or firebase_auth/network-request-failed[/+] last week
stuartmorgan-g
stuartmorgan-g commented last week
stuartmorgan-g
last week
Contributor
After update the code for the new version, Firebase Authentication doesn't works. When signInWithCredential is called, launch the exception I/flutter (25218): [firebase_auth/network-request-failed] A network error (such as timeout, interrupted connection or unreachable host) has occurred.

This would need to be reported to firebase_auth, as that's not code we control.

I've created a new Flutter project, and add the Firebase project of my app. Now google_sign_in gives the error on authenticate(), but gives another one: GoogleSignInException(code GoogleSignInExceptionCode.canceled, activity is cancelled by the user., null)

As documented in the README, this indicates a configuration error in your project. That's all the information we get from the SDK, so the plugin can't provide any other information.

Closing as neither of the errors are within the scope of what the plugin can control.

I recently upgraded a Flutter project from version 6.3.0 to 7.0.0and I have to admit, the breaking changes weren't immediately obvious to do. Google Sign-In v7.0 introduced significant breaking changes to improve security, comply with OAuth 2.0 best practices, and provide better platform-specific implementations.

The most notable changes include:

Removal of automatic state tracking (currentUser property)
New authentication flow with authenticate() method
Asynchronous initialization requirement
Simplified authentication token access
Enhanced scope management
Breaking Changes Summary
Removed APIs
// ❌ REMOVED in v7
GoogleSignIn.currentUser  // No longer tracks current user state
googleSignIn.signIn()     // Replaced with authenticate()
googleSignIn.signInSilently() // Replaced with attemptLightweightAuthentication()
googleSignIn.isSignedIn() // No longer available

// ❌ REMOVED async methods that are now synchronous
await googleUser.authentication  // Now synchronous
await googleSignIn.supportsAuthenticate()  // Now synchronous
New APIs
// ✅ NEW in v7
GoogleSignIn.instance.initialize()  // Required async initialization
googleSignIn.authenticate()         // Primary authentication method
googleSignIn.attemptLightweightAuthentication()  // Silent auth replacement
googleSignIn.authorizationClient    // Enhanced scope management
Step-by-Step Migration
Step 1: Update Dependencies
# pubspec.yaml
dependencies:
  google_sign_in: ^7.0.0 # Update to v7
Step 2: Initialize GoogleSignIn Asynchronously
Before (v6)

class AuthService {
  final _googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );

  // Initialization was synchronous
  AuthService() {
    // Ready to use immediately
  }
}
After (v7)

class AuthService {
  final _googleSignIn = GoogleSignIn.instance;
  bool _isGoogleSignInInitialized = false;

  AuthService() {
    _initializeGoogleSignIn();
  }

  Future<void> _initializeGoogleSignIn() async {
    try {
      await _googleSignIn.initialize();
      _isGoogleSignInInitialized = true;
    } catch (e) {
      print('Failed to initialize Google Sign-In: $e');
    }
  }

  /// Always check Google sign in initialization before use
  Future<void> _ensureGoogleSignInInitialized() async {
    if (!_isGoogleSignInInitialized) {
      await _initializeGoogleSignIn();
    }
  }
}
Step 3: Replace signIn() with authenticate()
Before (v6)

Future<GoogleSignInAccount?> signInWithGoogle() async {
  try {
    final GoogleSignInAccount? account = await _googleSignIn.signIn();
    if (account == null) {
      // User cancelled the sign-in
      return null;
    }
    return account;
  } catch (error) {
    print('Google Sign-In failed: $error');
    return null;
  }
}
After (v7)

Future<GoogleSignInAccount> signInWithGoogle() async {
  await _ensureGoogleSignInInitialized();

  try {
    // authenticate() throws exceptions instead of returning null
    final GoogleSignInAccount account = await _googleSignIn.authenticate(
      scopeHint: ['email'],  // Specify required scopes
    );
    return account;
  } on GoogleSignInException catch (e) {
    print('Google Sign In error: code: ${e.code.name} description:${e.description} details:${e.details}', error: e');
    rethrow;
  } catch (error) {
    print('Unexpected Google Sign-In error: $error');
    rethrow;
  }
}
Step 4: Handle Silent Authentication
Before (v6)

Future<GoogleSignInAccount?> silentSignIn() async {
  try {
    return await _googleSignIn.signInSilently();
  } catch (error) {
    return null;
  }
}
After (v7)

Future<GoogleSignInAccount?> attemptSilentSignIn() async {
  await _ensureGoogleSignInInitialized();

  try {
    // attemptLightweightAuthentication can return Future or immediate result
    final result = _googleSignIn.attemptLightweightAuthentication();

    // Handle both sync and async returns
    if (result is Future<GoogleSignInAccount?>) {
      return await result;
    } else {
      return result as GoogleSignInAccount?;
    }
  } catch (error) {
    print('Silent sign-in failed: $error');
    return null;
  }
}
Step 5: Update Authentication Token Access
Before (v6)

Future<GoogleSignInAuthentication> getAuthTokens(GoogleSignInAccount account) async {
  // authentication was async
  return await account.authentication;
}
After (v7)

GoogleSignInAuthentication getAuthTokens(GoogleSignInAccount account) {
  // authentication is now synchronous
  return account.authentication;
}
Step 6: Implement Enhanced Scope Management
Before (v6)

// Scopes were set during initialization only
final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: ['email', 'profile', 'https://www.googleapis.com/auth/drive.file'],
);
After (v7)

Future<String?> getAccessTokenForScopes(List<String> scopes) async {
  await _ensureGoogleSignInInitialized();

  try {
    final authClient = _googleSignIn.authorizationClient;

    // Try to get existing authorization
    var authorization = await authClient.authorizationForScopes(scopes);

    if (authorization == null) {
      // Request new authorization from user
      authorization = await authClient.authorizeScopes(scopes);
    }

    return authorization?.accessToken;
  } catch (error) {
    print('Failed to get access token for scopes: $error');
    return null;
  }
}
Step 7: Remove Current User State Management
Before (v6)

GoogleSignInAccount? get currentUser => _googleSignIn.currentUser;

bool get isSignedIn => _googleSignIn.currentUser != null;

void _setupUserListener() {
  _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
    // Handle user changes
    setState(() {
      _currentUser = account;
    });
  });
}
After (v7)

// Manage user state manually
GoogleSignInAccount? _currentUser;
GoogleSignInAccount? get currentUser => _currentUser;

bool get isSignedIn => _currentUser != null;

Future<void> signIn() async {
  try {
    _currentUser = await signInWithGoogle();
    // Manually notify listeners or update state
    _notifyUserChanged();
  } catch (error) {
    _currentUser = null;
    rethrow;
  }
}

Future<void> signOut() async {
  await _googleSignIn.signOut();
  _currentUser = null;
  _notifyUserChanged();
}
Step 8: Update Firebase Integration
Before (v6)

Future<UserCredential> signInWithGoogleFirebase() async {
  final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

  if (googleUser == null) return null;

  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  return await FirebaseAuth.instance.signInWithCredential(credential);
}
After (v7)

Future<UserCredential> signInWithGoogleFirebase() async {
  await _ensureGoogleSignInInitialized();

  // Authenticate with Google
  final GoogleSignInAccount googleUser = await _googleSignIn.authenticate(
    scopeHint: ['email'],
  );

  // Get authorization for Firebase scopes if needed
  final authClient = _googleSignIn.authorizationClient;
  final authorization = await authClient.authorizationForScopes(['email']);


  final credential = GoogleAuthProvider.credential(
    accessToken: authorization?.accessToken,
    idToken: googleAuth.idToken,
  );

  final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

  // Update local state
  _currentUser = googleUser;

  return userCredential;
}
Web Platform Consideration
Future<void> handleWebPlatform() async {
  if (kIsWeb) {
    // Web has different initialization requirements
    await _googleSignIn.initialize();

    // Web doesn't support all methods
    if (!_googleSignIn.supportsAuthenticate()) {
      throw UnsupportedError('Web platform requires different sign-in flow');
    }
  }
}
Common Migration Issues
Issue 1: “currentUser is null” Error
Problem: Existing code expects currentUser to be automatically populated.

Get Eternity (Isaac Adariku)’s stories in your inbox
Join Medium for free to get updates from this writer.

Enter your email
Subscribe
Solution: Implement manual state management:

class GoogleSignInManager {
  GoogleSignInAccount? _user;
  GoogleSignInAccount? get currentUser => _user;

  final StreamController<GoogleSignInAccount?> _userController =
      StreamController<GoogleSignInAccount?>.broadcast();
  Stream<GoogleSignInAccount?> get userStream => _userController.stream;

  void _updateUser(GoogleSignInAccount? user) {
    _user = user;
    _userController.add(user);
  }
}
Issue 2: “authenticate() not supported” Error
Problem: Platform doesn’t support the authenticate method.

Solution: Add platform checks:

Future<GoogleSignInAccount> platformAwareSignIn() async {
  if (!_googleSignIn.supportsAuthenticate()) {
    if (kIsWeb) {
      // Use web-specific sign-in UI
      throw UnsupportedError('Use Google Sign-In button for web');
    } else {
      throw UnsupportedError('Platform not supported');
    }
  }

  return await _googleSignIn.authenticate(scopeHint: ['email']);
}
Issue 3: Scope Authorization Failures
Problem: Getting access tokens for additional scopes fails.

Solution: Implement proper scope request flow:

Future<String?> requestScopeWithFallback(List<String> scopes) async {
  try {
    final authClient = _googleSignIn.authorizationClient;

    // Try incremental authorization first
    var auth = await authClient.authorizationForScopes(scopes);

    if (auth == null) {
      // Request explicit user consent
      auth = await authClient.authorizeScopes(scopes);
    }

    return auth?.accessToken;
  } catch (error) {
    print('Scope authorization failed: $error');
    return null;
  }
}
Advanced Use Cases
Dependency Injection with Get_it
Future<void> setupDependencyInjection() async {
  // Register GoogleSignIn as a singleton that requires async initialization
  GetIt.instance.registerSingletonAsync<GoogleSignIn>(() async {
    final googleSignIn = GoogleSignIn();
    await googleSignIn.initialize();
    return googleSignIn;
  });

  // Register AuthService that depends on initialized GoogleSignIn
  GetIt.instance.registerSingletonWithDependencies<AuthService>(
    () => AuthService(GetIt.instance<GoogleSignIn>()),
    dependsOn: [GoogleSignIn],
  );

  // Wait for all async singletons to be ready
  await GetIt.instance.allReady();
}
Injectable with @preResolve Pattern
@module
abstract class AppModule {
  // Use @preResolve for async initialization
  @preResolve
  @LazySingleton()
  Future<GoogleSignIn> googleSignIn() async {
    final instance = GoogleSignIn.instance;
    await instance.initialize();
    return instance;
  }
}
State Management with Riverpod
// Provider for GoogleSignIn instance with async initialization
@Riverpod(keepAlive: true)
Future<GoogleSignIn> googleSignIn(GoogleSignInRef ref) async {
  final googleSignIn = GoogleSignIn.instance;
  await googleSignIn.initialize();
  return googleSignIn;
}
Error Handling Best Practices
Use a detailed error-handling exception message with the new exception model.

String? googleSignInExceptionToMessage([dynamic exception]) {
  if (exception is GoogleSignInException) {
    switch (exception.code.name) {
      case 'canceled':
        return 'Sign-in was cancelled. Please try again if you want to continue.';
      case 'interrupted':
        return 'Sign-in was interrupted. Please try again.';
      case 'clientConfigurationError':
        return 'There is a configuration issue with Google Sign-In. Please contact support.';
      case 'providerConfigurationError':
        return 'Google Sign-In is currently unavailable. Please try again later or contact support.';
      case 'uiUnavailable':
        return 'Google Sign-In is currently unavailable. Please try again later or contact support.';
      case 'userMismatch':
        return 'There was an issue with your account. Please sign out and try again.';
      case 'unknownError':
      default:
        return 'An unexpected error occurred during Google Sign-In. Please try again.';
    }
  }
  return null;
}
Migration Checklist
Use this checklist to ensure you’ve completed all necessary steps when migrating. Each item represents a critical change required for the migration to work correctly.

[ ] Updated google_sign_in dependency to v7.0.0+
[ ] Replaced all signIn() calls with authenticate()
[ ] Replaced signInSilently() with attemptLightweightAuthentication()
[ ] Removed all references to currentUser property
[ ] Added async initialization with initialize()
[ ] Updated authentication token access (removed await)
[ ] Implemented manual user state management
[ ] Added proper error handling for new exception types
[ ] Updated scope management to use authorizationClient
[ ] Added platform-specific handling where needed
[ ] Updated unit and integration tests
[ ] Verified Firebase integration works correctly
Additional Resources
Official Google Sign-In v7 Migration Guide
Google Identity Services Documentation
Firebase Auth with Google Sign-In
Conclusion
Migrating to v7 ensures you’re up to date with the latest APIs and security practices. It requires careful attention to the new authentication flow and manual state management. While it involves more boilerplate code, the new version provides better security, clearer error handling, and more control over the authentication process.

The key is to treat authentication as an explicit action that requires proper initialization and error handling, rather than relying on automatic state tracking as in previous versions.

If you’re stuck during migration, feel free to reach out or comment below!

I hope you migrate successfully 😊 Until next time, 💙 Happy Fluttering! 💙

Help contribute to this article by:

📢 Spreading it with your friends, family, and colleagues.

👏🏾 Tapping the clap button below to show your appreciation and motivation.

📝 Sharing your thoughts and inquiries by leaving a comment below.

➕ Follow me on Medium to receive notifications when I release new articles.

😍 Connecting with me on Twitter and LinkedIn and I would be delighted to provide assistance.

📆 Book a 1:1 Session with me! on TopMate

Every day is another opportunity to gain Mastery! 💙 — Isaac Adariku (Eternity)

Google Sign In
Flutter
Migration
Firebase
Oauth2
245


5

Eternity (Isaac Adariku)
Written by Eternity (Isaac Adariku)
280 followers
·
5 following
GDE Flutter & Dart | Software Craftsman | Organizer FlutterKaduna


Follow
Responses (5)

Write a response

What are your thoughts?

Cancel
Respond
Koketso Mashego
Koketso Mashego

Jul 11


If you running into any issues for firebase base logging, this worked for me
Future<UserCredential?> signInWithGoogle() async {
try {
await GoogleSignIn.instance.initialize();
final GoogleSignInAccount googleUser = await GoogleSignIn.instance.authenticate(scopeHint: ['email']);
final GoogleSignInClientAuthorization? authorization;
authorization = await googleUser.authorizationClient.authorizationForScopes(['email']);
final credential = GoogleAuthProvider.credential(
idToken: googleUser.authentication.idToken,
accessToken: authorization?.accessToken,
);
// Firebase sign‑in
return await FirebaseAuth.instance.signInWithCredential(credential);
} on GoogleSignInException catch (e) {
// if (e.code.name == 'canceled') {
// return null;
// }
throw TFirebaseAuthException(e.code.name).message;
} on FirebaseAuthException catch (e) {
throw TFirebaseAuthException(e.code).message;
} on FormatException {
throw const TFormatException();
} on PlatformException catch (e) {
throw TPlatformException(e.code).message;
} catch (e) {
throw 'An unexpected error occurred. Please try again';
}
}
2

Reply

VISHNU PRABHAKARAN
VISHNU PRABHAKARAN

Jul 28


import 'dart:developer';
import 'package:google_sign_in/google_sign_in.dart';
class TestGoogleSignIn {
final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
bool _initialized = false;
Future<void> initialize() async {
if (!_initialized) {
await _googleSignIn.initialize(
serverClientId:
"126711910940-.apps.googleusercontent.com",
);
_initialized = true;
}
}
Future<void> signInAndGetServerAuthCode() async {
await initialize();
try {
// Trigger the full authentication flow
final GoogleSignInAccount user = await _googleSignIn.authenticate();
// Immediately request a server auth code
final GoogleSignInServerAuthorization? serverAuth =
await user.authorizationClient.authorizeServer(
[
"https://www.googleapis.com/auth/business.manage",
"openid",
"email",
"profile",
],
);
log("--- User Authentication Details ---");
log("ID Token : ${user.authentication.idToken}");
log("Photo URL : ${user.photoUrl}");
log("Display Name : ${user.displayName}");
log("Email : ${user.email}");
log("User ID : ${user.id}");
log("------------------------------------");
final code = serverAuth?.serverAuthCode;
if (code != null) {
log("serverAuthCode: $code");
// send code to your backend
} else {
log("serverAuthCode was null");
}
} on GoogleSignInException catch (e) {
log("Sign-in failed: ${e.code} ${e.description}");
} catch (error) {
log("Unexpected Google Sign-In error: $error");
}
}
}
This is my current code. I am trying to implement the Google sign-in with version 7.1.1. I am facing an error that says, "Unhandled Exception: GoogleSignInException(code GoogleSignInExceptionCode.unknownError, [28444] Developer console is not set up correctly., null)." The backend needs a client ID and client secret. So I created it using the Google Cloud Console. Within the documentation, it is saying that I need to add the client ID; whatever is getting within the Cloud console needs to be serverClientId. After that I am getting the above error. How can I fix it?

1 reply

Reply

Edouard Kerhir
Edouard Kerhir

Jul 3 (edited)




[google_sign_in and googleapis] Not able to access Google Drive API after updating Google Sign in to V7 #173407
Not planned
Not planned
[google_sign_in and googleapis] Not able to access Google Drive API after updating Google Sign in to V7
#173407
@sagarehs
Description
sagarehs
opened yesterday · edited by sagarehs
Steps to reproduce
Hello Everyone, Not able to access Google Drive API after updating google_sign_in: ^7.1.1

Google Sing-in is working fine for me using firebase auth and google-service.json but there is one issue regarding to access google drive API in flutter app

when I login using v7 not able to read or write google drive file

API Key is restricted for Android using package and sha1

For you kind information File read and write is working fine with v6

Expected results
I want to read and write file with Google Drive using googleapis flutter package

Actual results
Got Error in Google Drive API

DetailedApiRequestError(status: 403, message: Method doesn't allow unregistered callers (callers without established identity). Please use API Key or other form of API consumer identity to call this API.)

Code sample
Code sample
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: [
    'https://www.googleapis.com/auth/drive.appdata',
    'https://www.googleapis.com/auth/drive.file'
  ]);

 @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    _initializeGoogleSignIn();
  }

Future<void> _initializeGoogleSignIn() async {
    try {
      await _googleSignIn.initialize(serverClientId: '263300586130-0fjelbeit8a27e7pb3maauh1t9dcdrvc.apps.googleusercontent.com');
      _isGoogleSignInInitialized = true;
    } catch (e) {
      print('Failed to initialize Google Sign-In: $e');
    }
  }

  /// Always check Google sign in initialization before use
  Future<void> _ensureGoogleSignInInitialized() async {
    if (!_isGoogleSignInInitialized) {
      await _initializeGoogleSignIn();
    }
  }
  Future<GoogleSignInAccount> signInWithGoogle() async {
    await _ensureGoogleSignInInitialized();

    try {
      // authenticate() throws exceptions instead of returning null
      final GoogleSignInAccount account = await _googleSignIn.authenticate(
        scopeHint: ['email','https://www.googleapis.com/auth/drive.appdata','https://www.googleapis.com/auth/drive.file'],  // Specify required scopes
      );
      return account;
    } on GoogleSignInException catch (e) {
      print('Google Sign In error: code: ${e.code.name} description:${e.description} details:${e.details}');
      rethrow;
    } catch (error) {
      print('Unexpected Google Sign-In error: $error');
      rethrow;
    }
  }

//OnClick of Download File
      _currentUser = await signInWithGoogle();
      var client = GoogleHttpClient(await _currentUser!.authorizationClient.authorizationHeaders(['https://www.googleapis.com/auth/drive.appdata','https://www.googleapis.com/auth/drive.file']));
var _drive = v3.DriveApi(client);
      v3.FileList parentlist = new v3.FileList();
      v3.FileList csvFile = new v3.FileList();

class GoogleHttpClient extends IOClient {
  Map<String, String>? _headers;

  GoogleHttpClient(this._headers) : super();

  @override
  Future<IOStreamedResponse> send(http.BaseRequest request) {
    // TODO: implement send
    return super.send(request..headers.addAll(_headers!));
  }
}
Activity
stuartmorgan-g
stuartmorgan-g commented yesterday
stuartmorgan-g
yesterday
Contributor
Please see the documentation comment for authorizationHeaders; the code you have provided here is never requesting authorization, it is only returning existing authorization if it has already been requested. The expected behavior of the provided code is to send null headers with the API request, so the error is not surprising.

Closing as this is an error in the client code, not the plugin.

(In the future, when providing sample code, please provide a complete, compilable sample. The code here is partial, and part of it is for version 6.x of the plugin so can't be part of an actual 7.x repro case.)


stuartmorgan-g
closed this as not plannedyesterday

stuartmorgan-g
added 
r: invalid
Issue is closed as not valid
 yesterday
sagarehs
sagarehs commented 10 hours ago
sagarehs
10 hours ago
Author
@stuartmorgan-g Thanks for the quick response.

If possible, could you please share any documentation links or code examples for accessing the Google Drive API using Google Sign-In v7?
Alternatively, I’d really appreciate it if you could review my code and suggest improvements.

I’ve updated my code as follows, but I’m still encountering an error: "DetailedApiRequestError(status: 401, message: Request had invalid authentication credentials. Expected OAuth 2 access token, login cookie or other valid authentication credential. See https://developers.google.com/identity/sign-in/web/devconsole-project.)"

`
var client = GoogleHttpClient(await _currentUser!.authentication.idToken);

class GoogleHttpClient extends IOClient {
String? _headers;

GoogleHttpClient(this._headers) : super();

@OverRide
Future send(http.BaseRequest request) {
// TODO: implement send
if (_headers != null) {
request.headers.addIf(true, 'Authorization','Bearer $_headers');
}
return super.send(request);
}
}
`

stuartmorgan-g
stuartmorgan-g commented 2 hours ago
stuartmorgan-g
2 hours ago
Contributor
If possible, could you please share any documentation links or code examples for accessing the Google Drive API using Google Sign-In v7?

The google_sign_in example app shows an example of correctly requesting authorization for scopes and then constructing headers from it.

Alternatively, I’d really appreciate it if you could review my code and suggest improvements.

The Flutter issue tracker is not a support forum for client code; if you have questions about your own code, a resource like Stack Overflow would be the place for that.

