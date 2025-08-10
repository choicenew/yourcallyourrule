import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;

// 定义应用需要的权限范围
const List<String> _scopes = <String>[
  drive.DriveApi.driveFileScope,
];














class GoogleSignInTestPage extends StatefulWidget {
  const GoogleSignInTestPage({super.key});
  @override
  State<GoogleSignInTestPage> createState() => _GoogleSignInTestPageState();
}

class _GoogleSignInTestPageState extends State<GoogleSignInTestPage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  final List<String> _logMessages = [];

  GoogleSignInAccount? _currentUser;
  bool _isAuthorized = false;
  String _accessTokenInfo = '';
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _log('initState: Setting up GoogleSignIn...');
    
    // 初始化并监听事件，但不再尝试自动登录
    unawaited(_googleSignIn.initialize(
      //serverClientId: 'YOUR_WEB_CLIENT_ID.apps.googleusercontent.com', // 强烈建议填入您的 Web Client ID
    ).then((_) {
      _log('initialize() complete.');
      _googleSignIn.authenticationEvents
          .listen(_handleAuthenticationEvent, onError: _handleAuthenticationError);

      // ***************************************************************
      // *** 核心修正：移除了这里的自动登录尝试 ***
      // _log('Attempting lightweight authentication...');
      // _googleSignIn.attemptLightweightAuthentication();
      // ***************************************************************
      _log('App is ready for user-initiated sign-in.');

    }));
  }

  // 事件回调，只负责更新状态
  Future<void> _handleAuthenticationEvent(
      GoogleSignInAuthenticationEvent event) async {
    _log('Auth event received: ${event.runtimeType}');
    
    GoogleSignInAccount? user;
    if (event is GoogleSignInAuthenticationEventSignIn) {
      user = event.user;
    } else {
      user = null;
    }

    setState(() {
      _currentUser = user;
      _isAuthorized = false; 
      _accessTokenInfo = '';
      _errorMessage = '';
    });
    
    if (user != null) {
      _log('User is signed in: ${user.email}. Ready for explicit authorization.');
    } else {
      _log('User is now signed out.');
    }
  }

  Future<void> _handleAuthenticationError(Object e) async {
    _log('Authentication Error: $e');
  }

  // 按钮回调：交互式登录
  Future<void> _handleAuthenticate() async {
    _log('Button pressed: SIGN IN');
    try {
      // 只有在这里，才真正发起登录请求
      await _googleSignIn.authenticate();
    } catch (e) {
      _log('authenticate() failed: $e');
    }
  }

  // 按钮回调：交互式请求权限
  Future<void> _handleAuthorizeScopes() async {
    final user = _currentUser;
    if (user == null) return;
    
    _log('Button pressed: REQUEST PERMISSIONS');
    try {
      final auth = await user.authorizationClient.authorizeScopes(_scopes);
      
      _log('authorizeScopes() successful.');
      
      setState(() {
        _isAuthorized = true;
        _accessTokenInfo = 'Token acquired: ${auth.accessToken.substring(0,20)}...';
        _errorMessage = '';
      });

    } catch (e) {
       _log('authorizeScopes() failed: $e');
       setState(() {
         _isAuthorized = false;
         _errorMessage = 'Authorization Error: $e';
       });
    }
  }

  Future<void> _handleSignOut() async {
    await _googleSignIn.disconnect();
  }

  // --- UI 部分 (保持不变) ---
  void _log(String message) {
    print('[GoogleSignInTest] $message');
    if (mounted) {
      setState(() {
        _logMessages.insert(0, '${DateTime.now().toIso8601String()}: $message');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Google Sign-In Demo')),
      body: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: Column(
          children: [
            _buildBody(),
            if (_errorMessage.isNotEmpty) 
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(_errorMessage, style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
              ),
            _buildLogView(),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    final user = _currentUser;
    if (user != null) {
      return _buildAuthenticatedWidgets(user);
    } else {
      return _buildUnauthenticatedWidgets();
    }
  }

  Widget _buildAuthenticatedWidgets(GoogleSignInAccount user) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          ListTile(
            leading: GoogleUserCircleAvatar(identity: user),
            title: Text(user.displayName ?? ''),
            subtitle: Text(user.email),
          ),
          const Text('Signed in successfully.'),
          const SizedBox(height: 16),
          if (_isAuthorized)
            Column(
              children: [
                const Text('You have authorized access to Google Drive.'),
                if (_accessTokenInfo.isNotEmpty) Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(_accessTokenInfo),
                ),
              ],
            )
          else
            Column(
              children: [
                const Text('Authorization needed to access Google Drive.'),
                ElevatedButton(
                  onPressed: _handleAuthorizeScopes,
                  child: const Text('REQUEST PERMISSIONS'),
                ),
              ],
            ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _handleSignOut,
            child: const Text('SIGN OUT & DISCONNECT'),
          ),
        ],
      ),
    );
  }

  Widget _buildUnauthenticatedWidgets() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text('You are not currently signed in.'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _handleAuthenticate,
            child: const Text('SIGN IN'),
          ),
        ],
      ),
    );
  }

  Widget _buildLogView() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Logs:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const Divider(),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ListView.builder(
                  itemCount: _logMessages.length,
                  itemBuilder: (context, index) => Text(_logMessages[index],
                    style: const TextStyle(fontFamily: 'monospace', fontSize: 12)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}