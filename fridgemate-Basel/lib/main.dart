import 'package:flutter/material.dart';
import 'screens/auth_screen.dart';
import 'screens/home_screen.dart'; // Import HomeScreen
import 'screens/settings_screen.dart';
import 'screens/add_item_screen.dart';
import 'screens/my_items_screen.dart' as my_items; // Import MyItemsScreen with alias

void main() => runApp(FridgeMateApp());

class FridgeMateApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FridgeMate',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const AuthScreen(),
        '/home': (context) => const HomeScreen(),
        '/settings': (context) => SettingsScreen(),
        '/addItem': (context) => const AddItemScreen(),
        '/myItems': (context) => const my_items.MyItemsScreen(), // Use alias to avoid conflicts
      },
    );
  }
}
