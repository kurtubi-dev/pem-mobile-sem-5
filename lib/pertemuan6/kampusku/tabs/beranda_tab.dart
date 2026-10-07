import 'package:flutter/material.dart';

class BerandaTab extends StatelessWidget {
  const BerandaTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: SelectableText(
          'Selamat datang di KampusKu!\n\n'
          'Aplikasi ini menampilkan contoh penggunaan widget Flutter '
          'yang dipelajari pada pertemuan 6.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
