import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Screen0());
  }
}

// Layar Pertama (Screen 0)
class Screen0 extends StatefulWidget {
  const Screen0({super.key});

  @override
  State<Screen0> createState() => _Screen0State();
}

class _Screen0State extends State<Screen0> {
  String nama = "Budi"; // Variabel yang dikirim
  int umur = 21;
  String statusBalikan = ""; // Menampung balikan data dari Screen 1

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Screen 0'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Nama: $nama, Umur: $umur',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              onPressed: () async {
                // Kirim variabel ke Screen 1 & tunggu hasil kembalian
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Screen1(nama: nama, umur: umur),
                  ),
                );

                // Terima hasil balikan dari Screen 1
                if (result != null) {
                  setState(() {
                    statusBalikan = result;
                  });
                }
              },
              child: const Text('Kirim Data ke Screen 1'),
            ),
            const SizedBox(height: 20),
            Text(
              'Status balikan dari Screen 1: $statusBalikan',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

// Layar Kedua (Screen 1)
class Screen1 extends StatefulWidget {
  final String nama;
  final int umur;

  const Screen1({super.key, required this.nama, required this.umur});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  final TextEditingController statusController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Screen 1'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Data dari Screen 0:', style: const TextStyle(fontSize: 16)),
            Text(
              'Nama: ${widget.nama}, Umur: ${widget.umur}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: statusController,
              decoration: const InputDecoration(
                labelText: 'Masukkan status balikan',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {
                // Ambil variabel dari input
                String status = statusController.text.isEmpty
                    ? "Belum ada status"
                    : statusController.text;

                // Kirim balikan ke Screen 0
                Navigator.pop(context, status);
              },
              child: const Text('Kembalikan Data ke Screen 0'),
            ),
          ],
        ),
      ),
    );
  }
}
