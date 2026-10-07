import 'package:flutter/material.dart';
import 'beranda_tab.dart';
import 'artikel_tab.dart';
import 'akun_tab.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: TabBar(
          labelColor: Colors.deepPurple,
          unselectedLabelColor: Colors.grey,
          tabs: [
            Tab(text: 'Beranda'),
            Tab(text: 'Artikel'),
            Tab(text: 'Akun'),
          ],
        ),
        body: TabBarView(
          children: [
            BerandaTab(),
            ArtikelTab(),
            AkunTab(),
          ],
        ),
      ),
    );
  }
}
