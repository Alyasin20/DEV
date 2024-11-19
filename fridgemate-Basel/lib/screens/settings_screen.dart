import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: const Color(0xFF1E1E2C),
      ),
      body: const Center(
        child: Text(
          "Settings Page",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
