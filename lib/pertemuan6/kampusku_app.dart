import 'package:flutter/material.dart';
import 'kampusku/login_screen.dart';

class KampusKuApp extends StatelessWidget {
  const KampusKuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KampusKu App',
      theme: ThemeData(primarySwatch: Colors.deepPurple, useMaterial3: false),
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
