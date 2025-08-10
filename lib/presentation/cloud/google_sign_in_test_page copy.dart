import 'dart:async';
import 'dart:convert' show json;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:yourcallyourrule/cloud_sync/environment.dart';

const List<String> _scopes = <String>[
  'email',
  'https://www.googleapis.com/auth/drive.file',
];

class GoogleSignInTestPage extends StatefulWidget {
  const GoogleSignInTestPage({super.key});

  @override
  State<GoogleSignInTestPage> createState() => _GoogleSignInTestPageState();
}

class _GoogleSignInTestPageState extends State<GoogleSignInTestPage> {
  GoogleSignInAccount? _currentUser;
  bool _isAuthorized = false;
  String _contactText = '';
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();

    final GoogleSignIn signIn = GoogleSignIn.instance;
    unawaited(signIn
        .initialize(serverClientId: Environment.googleServerClientId)
        .then((_) {
      signIn.authenticationEvents
          .listen(_handleAuthenticationEvent)
          .onError(_handleAuthenticationError);
      signIn.attemptLightweightAuthentication();
    }));
  }

  Future<void> _handleAuthenticationEvent(
      GoogleSignInAuthenticationEvent event) async {
    final GoogleSignInAccount? user = switch (event) {
      GoogleSignInAuthenticationEventSignIn() => event.user,
      GoogleSignInAuthenticationEventSignOut() => null,
    };

    final GoogleSignInClientAuthorization? authorization =
        await user?.authorizationClient.authorizationForScopes(_scopes);

    setState(() {
      _currentUser = user;
      _isAuthorized = authorization != null;
      _errorMessage = '';
    });

    if (user != null && authorization != null) {
      unawaited(_handleGetContact(user));
    }
  }

  void _handleAuthenticationError(Object error) {
    setState(() {
      _currentUser = null;
      _isAuthorized = false;
      _errorMessage = error is GoogleSignInException
          ? 'Google Sign In Error: ${error.code}: ${error.description}'
          : 'Unknown error: $error';
    });
  }

  Future<void> _handleGetContact(GoogleSignInAccount user) async {
    setState(() {
      _contactText = 'Loading contact info...';
    });
    final Map<String, String>? headers = await user.authorizationClient.authorizationHeaders(_scopes);
    if (headers == null) {
      setState(() {
        _contactText = '';
        _errorMessage = 'Failed to construct authorization headers.';
      });
      return;
    }

    final http.Response response = await http.get(
      Uri.parse('https://www.googleapis.com/drive/v3/about?fields=user'),
      headers: headers,
    );

    if (response.statusCode != 200) {
      if (response.statusCode == 401 || response.statusCode == 403) {
        setState(() {
          _isAuthorized = false;
          _errorMessage = 'API gave a ${response.statusCode} response. Please re-authorize access.';
        });
      } else {
        print('API ${response.statusCode} response: ${response.body}');
        setState(() {
          _contactText = 'API gave a ${response.statusCode} response. Check logs for details.';
        });
      }
      return;
    }
    final Map<String, dynamic> data = json.decode(response.body) as Map<String, dynamic>;
    final String email = data['user']['emailAddress'];
    setState(() {
      _contactText = 'Successfully connected to Drive API for user: $email';
    });
  }

  Future<void> _handleAuthorizeScopes(GoogleSignInAccount user) async {
    try {
      await user.authorizationClient.authorizeScopes(_scopes);
      setState(() {
        _isAuthorized = true;
        _errorMessage = '';
      });
      unawaited(_handleGetContact(user));
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to authorize scopes: $e';
      });
    }
  }

  Future<void> _handleSignOut() async {
    await GoogleSignIn.instance.disconnect();
  }

  Widget _buildBody() {
    final GoogleSignInAccount? user = _currentUser;
    if (user != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ListTile(
            leading: GoogleUserCircleAvatar(identity: user),
            title: Text(user.displayName ?? ''),
            subtitle: Text(user.email),
          ),
          const Text('Signed in successfully.'),
          if (_isAuthorized)
            Text(_contactText),
          if (!_isAuthorized)
            Column(
              children: [
                const Text('Additional permissions needed to access Drive.'),
                ElevatedButton(
                  onPressed: () => _handleAuthorizeScopes(user),
                  child: const Text('AUTHORIZE'),
                ),
              ],
            ),
          ElevatedButton(
            onPressed: _handleSignOut,
            child: const Text('SIGN OUT'),
          ),
          if (_errorMessage.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(_errorMessage, style: const TextStyle(color: Colors.red)),
            ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('You are not currently signed in.'),
          ElevatedButton(
            onPressed: () async {
              try {
                await GoogleSignIn.instance.authenticate();
              } on GoogleSignInException catch (e) {
                _errorMessage = 'Google Sign In Error: ${e.code}: ${e.description}';
              } catch (e) {
                _errorMessage = 'Unknown error: $e';
              }
            },
            child: const Text('SIGN IN'),
          ),
          if (_errorMessage.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(_errorMessage, style: const TextStyle(color: Colors.red)),
            ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Sign In Test'),
      ),
      body: Center(
        child: _buildBody(),
      ),
    );
  }
}