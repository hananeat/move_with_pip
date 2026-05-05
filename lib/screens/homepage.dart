import 'package:flutter/material.dart';

// Questa è una homepage SEGNAPOSTO
// per ora serve solo per far funzionare il bottone login
// la schermata vera verrà sviluppata dopo
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFDE7),
      body: const Center(
        child: Text(
          'Homepage 🐥',
          style: TextStyle(
            fontSize: 32,
            color: Color(0xFF2A2859),
          ),
        ),
      ),
    );
  }
}
