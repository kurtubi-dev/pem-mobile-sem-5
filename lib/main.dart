import 'package:flutter/material.dart';

// Pertemuan 4
import 'pertemuan4/4.1.dart' as p41;
import 'pertemuan4/4.2.dart' as p42;
import 'pertemuan4/4.3.dart' as p43;
import 'pertemuan4/4.4.dart' as p44;
import 'pertemuan4/4.5.dart' as p45;

// Pertemuan 5
import 'pertemuan5/5.1.dart' as p51;
import 'pertemuan5/5.2.dart' as p52;
import 'pertemuan5/5.3.dart' as p53;
import 'pertemuan5/5.4.dart' as p54;
import 'pertemuan5/5.6.dart' as p56;
import 'pertemuan5/5.7.dart' as p57;
import 'pertemuan5/5.8.dart' as p58;
import 'pertemuan5/5.9.dart' as p59;
import 'pertemuan5/5.10.dart' as p510;
import 'pertemuan5/studikasus.dart' as studikasus;

// Pertemuan 6
import 'pertemuan6/latihan6.1.dart' as p61;
import 'pertemuan6/latihan6.2.dart' as p62;
import 'pertemuan6/latihan6.3.dart' as p63;
import 'pertemuan6/latihan6.4.dart' as p64;
import 'pertemuan6/latihan6.5.dart' as p65;
import 'pertemuan6/latihan6.6.dart' as p66;
import 'pertemuan6/latihan6.7.dart' as p67;
import 'pertemuan6/latihan6.8.dart' as p68;
import 'pertemuan6/latihan6.9.dart' as p69;
import 'pertemuan6/kampusku_app.dart';

// Pertemuan 7
import 'pertemuan7/latihan7.1.dart' as p71;
import 'pertemuan7/latihan7.2.dart' as p72;
import 'pertemuan7/latihan7.3.dart' as p73;
import 'pertemuan7/latihan7.4.dart' as p74;
import 'pertemuan7/latihan7.5.dart' as p75;
import 'pertemuan7/latihan7.6.dart' as p76;
import 'pertemuan7/latihan7.7.dart' as p77;
import 'pertemuan7/latihan7.8.dart' as p78;
import 'pertemuan7/latihan7.9.dart' as p79;
import 'pertemuan7/latihan7.10.dart' as p710;
import 'pertemuan7/latihan7.11.dart' as p711;

// UTS Praktikum
import 'uts-praktikum/login_screen.dart' as uts;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigasi Praktikum',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: false),
      home: const MenuUtama(),
      // Peta rute wajib didefinisikan agar Latihan 5.6 & 5.7 (Named Routes) tidak error
      routes: {
        '/second': (context) => const p56.SecondPage(),
        '/detail': (context) => const p57.DetailPage(),
        '/shopping': (context) => const p57.ShoppingPage(),
      },
    );
  }
}

class MenuUtama extends StatelessWidget {
  const MenuUtama({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, List<Map<String, dynamic>>> listPertemuan = {
      'Pertemuan 4': [
        {'title': 'Latihan 4.1', 'page': p41.MyApp()},
        {'title': 'Latihan 4.2', 'page': p42.MyApp()},
        {'title': 'Latihan 4.3', 'page': p43.MyApp()},
        {'title': 'Latihan 4.4', 'page': p44.MyApp()},
        {'title': 'Latihan 4.5', 'page': p45.MyApp()},
      ],
      'Pertemuan 5': [
        {'title': 'Latihan 5.1 - Push Navigation', 'page': p51.HalamanUtama()},
        {'title': 'Latihan 5.2 - Pop Navigation', 'page': p52.HalamanUtama()},
        {'title': 'Latihan 5.3 - Push Replacement', 'page': p53.HalamanLogin()},
        {
          'title': 'Latihan 5.4 - Custom Transitions',
          'page': p54.HalamanUtama(),
        },
        {'title': 'Latihan 5.6 - Named Routes', 'page': const p56.FirstPage()},
        {
          'title': 'Latihan 5.7 - Kitchen Stories App',
          'page': const p57.HomePage(),
        },
        {'title': 'Latihan 5.8 - TabBar Demo', 'page': const p58.TabBarDemo()},
        {
          'title': 'Latihan 5.9 - Passing Data (RouteSettings)',
          'page': p59.TodosScreen(
            todos: List.generate(
              20,
              (i) => p59.Todo('Todo $i', 'Deskripsi tugas ke-$i'),
            ),
          ),
        },
        {
          'title': 'Latihan 5.10 - Send & Return Data',
          'page': const p510.Screen0(),
        },
        {
          'title': 'Latihan 5.11 - Studi kasus: konversi suhu',
          'page': const studikasus.Screen0(),
        },
      ],
      'Pertemuan 6': [
        {'title': 'Latihan 6.1', 'page': p61.MyApp()},
        {'title': 'Latihan 6.2', 'page': p62.MyApp()},
        {'title': 'Latihan 6.3', 'page': p63.MyApp()},
        {'title': 'Latihan 6.4', 'page': p64.MyApp()},
        {'title': 'Latihan 6.5', 'page': p65.Home()},
        {'title': 'Latihan 6.6', 'page': p66.MyApp()},
        {'title': 'Latihan 6.7', 'page': p67.MyApp()},
        {'title': 'Latihan 6.8', 'page': p68.MyApp()},
        {'title': 'Latihan 6.9', 'page': p69.MyApp()},
        {'title': 'Studi Kasus - KampusKu App', 'page': const KampusKuApp()},
      ],
      'Pertemuan 7': [
        {'title': 'Latihan 7.1 - Input Data (TextField)', 'page': p71.MyApp()},
        {
          'title': 'Latihan 7.2 - Checkbox & Radio Buttons',
          'page': p72.MyApp(),
        },
        {'title': 'Latihan 7.3 - Date Picker', 'page': p73.MyApp()},
        {'title': 'Latihan 7.4 - Time Picker', 'page': p74.MyApp()},
        {'title': 'Latihan 7.5 - Slider Widget', 'page': p75.MyApp()},
        {'title': 'Latihan 7.6 - Switch Widget', 'page': p76.MyApp()},
        {'title': 'Latihan 7.7 - Alert Dialog', 'page': p77.MyApp()},
        {'title': 'Latihan 7.8 - Bottom Sheet', 'page': p78.MyApp()},
        {'title': 'Latihan 7.9 - Expansion Tile Widget', 'page': p79.MyApp()},
        {'title': 'Latihan 7.10 - Snack Bar Widget', 'page': p710.MyApp()},
        {
          'title': 'Latihan 7.11 - Snack Bar Custom (Notification)',
          'page': p711.MyApp(),
        },
      ],
      'UTS Praktikum': [
        {
          'title': 'PAKET A - Jualle POS App',
          'page': const uts.LoginScreen(),
        },
      ],
    };

    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Praktikum'), centerTitle: true),
      body: ListView.builder(
        itemCount: listPertemuan.length,
        itemBuilder: (context, index) {
          String key = listPertemuan.keys.elementAt(index);
          List<Map<String, dynamic>> latihans = listPertemuan[key]!;

          return ExpansionTile(
            title: Text(
              key,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            children: latihans.map((item) {
              return ListTile(
                title: Text(item['title']),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => item['page'] as Widget,
                    ),
                  );
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
