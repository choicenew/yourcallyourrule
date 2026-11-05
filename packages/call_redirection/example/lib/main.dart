import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pyro_telephony_connector/pyro_telephony_connector.dart';
import 'package:pyro_call_redirection_connector/pyro_call_redirection_connector.dart';
import 'package:pyro_sms_connector/pyro_sms_connector.dart';
import 'package:pyro_sms_protocol/pyro_sms_protocol.dart';

import 'package:pyro_sim_driver/pyro_sim_driver.dart';
import 'package:pyro_stir_driver/pyro_stir_driver.dart';
import 'package:pyro_tile_driver/pyro_tile_driver.dart';

import 'package:pyro_call_redirection_driver/pyro_call_redirection_driver.dart';
import 'package:pyro_call_screening_driver/pyro_call_screening_driver.dart';
import 'package:pyro_sms_driver_notification_listener/pyro_sms_driver_notification_listener.dart';
import 'package:pyro_sms_driver_telephony_fallback/pyro_sms_driver_telephony_fallback.dart';
import 'package:pyro_sms_driver_keyword_bloom_filter/pyro_sms_driver_keyword_bloom_filter.dart';
import 'package:pyro_sms_driver_otp_guard/pyro_sms_driver_otp_guard.dart';
import 'package:pyro_call_policy/pyro_call_policy.dart';

class TestCallPolicyEvaluator implements ICallPolicyEvaluator {
  @override
  String get providerId => 'test_call_policy_evaluator';

  @override
  Future<CallPolicyVerdict> evaluateCall(CallPolicyContext context) async {
    final number = context.phoneNumber;
    if (number.contains('18005550199')) {
      return const CallPolicyVerdict(
        action: CallActionType.reject,
        reason: 'Blocked by Test Evaluator (Spam Blacklist)',
      );
    }
    if (number.contains('18005550200')) {
      return const CallPolicyVerdict(
        action: CallActionType.silence,
        reason: 'Silenced by Test Evaluator',
      );
    }
    if (number.contains('18005550201')) {
      return const CallPolicyVerdict(
        action: CallActionType.answerThenHangup,
        reason: 'AnswerThenHangup by Test Evaluator',
      );
    }
    return CallPolicyVerdict.allow;
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Mount All Self-Registering Package Suite Connectors
  TelephonyConnectors.ensureMounted();
  CallRedirectionConnectors.ensureMounted();
  SmsConnectors.ensureMounted();

  SimDriver.register();
  StirDriver.register();
  TileDriver.register();

  // Register Test Policy Evaluator
  CallPolicyEngine.registerEvaluator(TestCallPolicyEvaluator());

  runApp(const ProviderScope(child: UnifiedPackageTestSuiteApp()));
}

class UnifiedPackageTestSuiteApp extends StatelessWidget {
  const UnifiedPackageTestSuiteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pyro Package Suite Automated E2E Tester',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const TestDashboardPage(),
    );
  }
}

class TestDashboardPage extends StatefulWidget {
  const TestDashboardPage({super.key});

  @override
  State<TestDashboardPage> createState() => _TestDashboardPageState();
}

class _TestDashboardPageState extends State<TestDashboardPage> {
  String _logs = 'App started. Connectors mounted.\n';

  void _addLog(String msg) {
    setState(() {
      _logs = '[${DateTime.now().toString().split('.').first}] $msg\n$_logs';
    });
  }

  // --- Test 1: SIM Reader ---
  Future<void> _testSimReader() async {
    _addLog('Testing SimDriver.getActiveSimCards()...');
    final driver = SimDriver();
    final cards = await driver.getActiveSimCards();
    final hasSim = await driver.hasSimCard();
    final netInfo = await driver.getNetworkInfo();
    _addLog('SIM Result: count=${cards.length}, hasSim=$hasSim, net=${netInfo?.networkOperatorName}');
  }

  // --- Test 2: STIR Verification ---
  Future<void> _testStir() async {
    _addLog('Testing StirDriver.checkStirStatus()...');
    final driver = StirDriver();
    final result = await driver.checkStirStatus('+18005550199');
    _addLog('STIR Result: status=${result?.status}, isVerified=${result?.isVerified}');
  }

  // --- Test 3: Quick Tile ---
  Future<void> _testTile() async {
    _addLog('Testing TileDriver...');
    final driver = TileDriver();
    final ok1 = await driver.updateTileState(TileStateType.active, subtitle: 'Protection Active');
    final ok2 = await driver.requestAddTile();
    _addLog('Tile Result: updateTileState=$ok1, requestAddTile=$ok2');
  }

  // --- Test 4: Call Redirection Role ---
  Future<void> _testCallRedirection() async {
    _addLog('Testing CallRedirectionDriver.isRoleGranted()...');
    final driver = CallRedirectionDriver();
    final granted = await driver.isRoleGranted();
    _addLog('CallRedirection Role Granted=$granted');
    if (!granted) {
      _addLog('Requesting CallRedirection role...');
      await driver.requestRole();
    }
  }

  // --- Test 5: Notification Listener Permission ---
  Future<void> _testNotificationListener() async {
    _addLog('Testing SmsNotificationListenerDriver.isPermissionGranted()...');
    final driver = SmsNotificationListenerDriver();
    final granted = await driver.isPermissionGranted();
    _addLog('Notification Listener Permission Granted=$granted');
    if (!granted) {
      _addLog('Requesting Notification Listener permission...');
      await driver.requestPermission();
    }
  }

  // --- Test 6: SMS Telephony Fallback Permission ---
  Future<void> _testSmsFallback() async {
    _addLog('Testing TelephonyFallbackDriver.isSmsPermissionGranted()...');
    final driver = TelephonyFallbackDriver();
    final granted = await driver.isSmsPermissionGranted();
    _addLog('SMS Receive Permission Granted=$granted');
  }

  // --- Test 7: Keyword Bloom Filter & AC Automaton ---
  Future<void> _testBloomFilter() async {
    _addLog('Testing KeywordBloomFilterDriver...');
    final driver = KeywordBloomFilterDriver(keywords: ['lottery', 'winner', '博彩']);
    final msg = SmsMessageEntity(
      id: 'msg_1',
      sender: 'Spammer',
      body: 'Congratulations! You won the casino lottery!',
      timestamp: DateTime.now(),
    );
    final result = await driver.screenMessage(msg);
    _addLog('Bloom Filter Result: riskLevel=${result?.riskLevel.name}, reasoning=${result?.reasoning}');
  }

  // --- Test 8: OTP Privacy Guard ---
  Future<void> _testOtpGuard() async {
    _addLog('Testing OtpGuardDriver...');
    final driver = OtpGuardDriver();
    final sanitized = driver.sanitizeSmsBody('Your verification code is 849201. Do not share.');
    _addLog('OTP Guard Sanitized Body: "$sanitized"');
  }

  // --- Test 9: Call Screening Role ---
  Future<void> _testCallScreeningRole() async {
    _addLog('Testing CallScreeningDriver.isRoleGranted()...');
    final driver = CallScreeningDriver();
    final granted = await driver.isRoleGranted();
    _addLog('Call Screening Role Granted=$granted');
    if (!granted) {
      _addLog('Requesting Call Screening role...');
      await driver.requestRole();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pyro Package Suite E2E Tester'),
        backgroundColor: theme.colorScheme.primaryContainer,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                Text('Native Driver Hardware & Channel Verification:', style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _testSimReader,
                      icon: const Icon(Icons.sim_card),
                      label: const Text('Test SIM Reader'),
                    ),
                    ElevatedButton.icon(
                      onPressed: _testStir,
                      icon: const Icon(Icons.verified_user),
                      label: const Text('Test STIR Auth'),
                    ),
                    ElevatedButton.icon(
                      onPressed: _testTile,
                      icon: const Icon(Icons.dashboard_customize),
                      label: const Text('Test Quick Tile'),
                    ),
                    ElevatedButton.icon(
                      onPressed: _testCallRedirection,
                      icon: const Icon(Icons.call_made),
                      label: const Text('Test Redirection Role'),
                    ),
                    ElevatedButton.icon(
                      onPressed: _testCallScreeningRole,
                      icon: const Icon(Icons.shield),
                      label: const Text('Test Screening Role'),
                    ),
                    ElevatedButton.icon(
                      onPressed: _testNotificationListener,
                      icon: const Icon(Icons.notifications_active),
                      label: const Text('Test Notification Listener'),
                    ),
                    ElevatedButton.icon(
                      onPressed: _testSmsFallback,
                      icon: const Icon(Icons.sms),
                      label: const Text('Test SMS Receiver'),
                    ),
                    ElevatedButton.icon(
                      onPressed: _testBloomFilter,
                      icon: const Icon(Icons.filter_alt),
                      label: const Text('Test Bloom Filter'),
                    ),
                    ElevatedButton.icon(
                      onPressed: _testOtpGuard,
                      icon: const Icon(Icons.lock),
                      label: const Text('Test OTP Guard'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Container(
            height: 220,
            width: double.infinity,
            color: Colors.black87,
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Text(
                _logs,
                style: const TextStyle(
                  color: Colors.greenAccent,
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
