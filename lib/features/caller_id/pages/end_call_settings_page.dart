import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';






class EndCallSettingsPage extends StatefulWidget {
  const EndCallSettingsPage({super.key});

  @override
  EndCallSettingsPageState createState() => EndCallSettingsPageState();
}

class EndCallSettingsPageState extends State<EndCallSettingsPage> {
  String? _selectedInterceptAction = 'endCall';

  @override
  void initState() {
    super.initState();
    _loadInterceptAction();
  }

  Future<void> _loadInterceptAction() async {
    SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
    _selectedInterceptAction = await asyncPrefs.getString('intercept_action') ?? 'endCall';
    setState(() {});
  }

  Future<void> _saveInterceptAction(String? newValue) async {
    SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
    await asyncPrefs.setString('intercept_action', newValue!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blocked Call Action'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text(
              'Incoming Call Intercept Action',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            subtitle: const Text('Choose the default intercept action'),
            trailing: DropdownButton<String>(
              value: _selectedInterceptAction,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedInterceptAction = newValue!;
                });
                _saveInterceptAction(newValue);
              },
              items: const <DropdownMenuItem<String>>[
                DropdownMenuItem<String>(
                  value: 'endCall',
                  child: Text('End call immediately'),
                ),
                DropdownMenuItem<String>(
                  value: 'answerThenHangup',
                  child: Text('Answer then hang up'),
                ),
                DropdownMenuItem<String>(
                  value: 'silenceNoAnswer',
                  child: Text('Silence and no answer'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}