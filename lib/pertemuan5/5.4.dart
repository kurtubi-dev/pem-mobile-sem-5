import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contoh Animasi Transisi Navigasi',
      home: HalamanUtama(),
    );
  }
}

class HalamanUtama extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Halaman Utama')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 1. Slide Transition (Default)
            ElevatedButton(
              child: Text('Slide Transition (Default)'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HalamanBaru()),
                );
              },
            ),
            SizedBox(height: 12),

            // 2. Fade Transition (Latihan 5.4)
            ElevatedButton(
              child: Text('Fade Transition'),
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        HalamanBaru(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                  ),
                );
              },
            ),
            SizedBox(height: 12),

            // 3. Scale Transition (Latihan 5.5)
            ElevatedButton(
              child: Text('Scale Transition'),
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        HalamanBaru(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return ScaleTransition(
                        scale: CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeInOut,
                        ),
                        child: child,
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class HalamanBaru extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Halaman Baru')),
      body: Center(
        child: ElevatedButton(
          child: Text('Kembali'),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }
}