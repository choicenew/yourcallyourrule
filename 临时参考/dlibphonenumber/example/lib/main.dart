
import 'package:flutter/material.dart';
import 'package:dlibphonenumber/dlibphonenumber.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dlibphonenumber Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      home: const PhoneNumberScreen(),
    );
  }
}

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({Key? key}) : super(key: key);

  @override
  _PhoneNumberScreenState createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  final TextEditingController _numberController = TextEditingController(text: '15662327825');
  final TextEditingController _countryController = TextEditingController(text: 'CN');
  final TextEditingController _languageController = TextEditingController(text: 'zh');
  String _result = 'Enter number, country, and language, then press "Parse and Validate".';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _parsePhoneNumber();
    });
  }

  void _parsePhoneNumber() async {
    final String phoneNumberInput = _numberController.text;
    final String countryCode = _countryController.text;
    final String languageCode = _languageController.text.isNotEmpty ? _languageController.text : 'en';

    if (phoneNumberInput.isEmpty || countryCode.isEmpty) {
      setState(() {
        _result = 'Please enter a phone number and country code.';
      });
      return;
    }

    setState(() {
      _result = 'Parsing and fetching geocoding data...';
    });

    final PhoneNumberUtil phoneUtil = PhoneNumberUtil.instance;
    
    try {
      final PhoneNumber phoneNumber = phoneUtil.parse(phoneNumberInput, countryCode);
      final bool isValid = phoneUtil.isValidNumber(phoneNumber);
      final String e164 = phoneUtil.format(phoneNumber, PhoneNumberFormat.e164);
      final String international = phoneUtil.format(phoneNumber, PhoneNumberFormat.international);
      final String national = phoneUtil.format(phoneNumber, PhoneNumberFormat.national);
      final PhoneNumberType type = phoneUtil.getNumberType(phoneNumber);
      final String? region = phoneUtil.getRegionCodeForNumber(phoneNumber);
      
      final geocoder = PhoneNumberOfflineGeocoder.instance;
      
      // CRITICAL FIX: Use the correct Locale constructor with named parameters.
      final locale = Locale(language: languageCode, country: countryCode);
      
      final String description = await geocoder.getDescriptionForNumber(phoneNumber, locale);
      final String validNumberDescription = await geocoder.getDescriptionForValidNumber(phoneNumber, locale);

      final List<String> timezones = PhoneNumberToTimeZonesMapper.instance.getTimeZonesForNumber(phoneNumber);
      final String carrier = PhoneNumberToCarrierMapper.instance.getNameForNumber(phoneNumber, locale);

      setState(() {
        _result = """
Success!
--------------------
Is Valid: $isValid
E.164 Format: $e164
International: $international
National Format: $national
Number Type: $type
Region Code: $region

✅ Geocode (Full): $description
✅ Geocode (Valid Number): $validNumberDescription
📡 Carrier: $carrier
🕰 Timezones: ${timezones.join(', ')}
""";
      });
    } catch (e) {
      setState(() {
        _result = 'Error: ${e.toString()}\n\nThis might happen if the geocoding data for the specified language (\'$languageCode\') or country (\'$countryCode\') is not available.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dlibphonenumber Interactive Test'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _numberController,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                hintText: 'e.g., 15662327825',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _countryController,
              decoration: const InputDecoration(
                labelText: '2-Letter Country Code',
                hintText: 'e.g., CN, US',
                border: OutlineInputBorder(),
              ),
              maxLength: 2,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _languageController,
              decoration: const InputDecoration(
                labelText: 'Language Code',
                hintText: 'e.g., zh, en, fr',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _parsePhoneNumber,
              child: const Text('Parse and Validate'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: SelectableText(
                _result,
                style: const TextStyle(fontFamily: 'monospace', fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
