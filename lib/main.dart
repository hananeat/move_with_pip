import 'package:flutter/material.dart';

// Sul nostro branch partiamo direttamente dalla login
// la splash screen è sul branch della compagna
import 'screens/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Move with Pip',
      debugShowCheckedModeBanner: false,

      // Partiamo dalla LoginPage
      home: const LoginPage(),
    );
  }
}