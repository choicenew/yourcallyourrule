import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  final String? payload;

  const TestPage({Key? key, this.payload}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Page'),
      ),
      body: Center(
        child: Text('Payload: ${payload ?? 'No payload'}'),
      ),
    );
  }
}