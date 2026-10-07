import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

class UTSPaketAApp extends StatelessWidget {
  const UTSPaketAApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jualle POS App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: const Color(0xFF007A15),
        useMaterial3: false,
      ),
      home: const LoginScreen(),
    );
  }
}
