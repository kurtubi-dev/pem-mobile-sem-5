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

// Layar Pertama (Screen 0) - Input Suhu
class Screen0 extends StatefulWidget {
  const Screen0({super.key});

  @override
  State<Screen0> createState() => _Screen0State();
}

class _Screen0State extends State<Screen0> {
  final TextEditingController suhuController = TextEditingController();
  String jenisSuhu = "Celcius"; // Variabel jenis suhu asal

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Aplikasi Konversi Suhu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: suhuController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Masukkan Nilai Suhu',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            DropdownButtonFormField<String>(
              value: jenisSuhu,
              decoration: const InputDecoration(
                labelText: 'Pilih Suhu Asal',
                border: OutlineInputBorder(),
              ),
              items: ['Celcius', 'Fahrenheit', 'Kelvin', 'Reamur']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (val) {
                if (val != null) setState(() => jenisSuhu = val);
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              onPressed: () {
                double nilai = double.tryParse(suhuController.text) ?? 0;

                // Kirim nilai & jenis suhu ke Screen 1
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Screen1(
                      nilaiSuhu: nilai,
                      jenisSuhu: jenisSuhu,
                    ),
                  ),
                );
              },
              child: const Text('Kirim & Lihat Hasil'),
            ),
          ],
        ),
      ),
    );
  }
}

// Layar Kedua (Screen 1) - Hasil Suhu
class Screen1 extends StatelessWidget {
  final double nilaiSuhu;
  final String jenisSuhu;

  const Screen1({super.key, required this.nilaiSuhu, required this.jenisSuhu});

  @override
  Widget build(BuildContext context) {
    // Logika rumus hitungan suhu
    double c = 0;
    if (jenisSuhu == 'Celcius') c = nilaiSuhu;
    if (jenisSuhu == 'Fahrenheit') c = (nilaiSuhu - 32) * 5 / 9;
    if (jenisSuhu == 'Kelvin') c = nilaiSuhu - 273.15;
    if (jenisSuhu == 'Reamur') c = nilaiSuhu * 5 / 4;

    double f = (c * 9 / 5) + 32;
    double k = c + 273.15;
    double r = c * 4 / 5;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Hasil Konversi Suhu'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Suhu Asal: $nilaiSuhu °$jenisSuhu',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            if (jenisSuhu != 'Celcius')
              Text('Celcius: ${c.toStringAsFixed(2)} °C', style: const TextStyle(fontSize: 16)),
            if (jenisSuhu != 'Fahrenheit')
              Text('Fahrenheit: ${f.toStringAsFixed(2)} °F', style: const TextStyle(fontSize: 16)),
            if (jenisSuhu != 'Kelvin')
              Text('Kelvin: ${k.toStringAsFixed(2)} °K', style: const TextStyle(fontSize: 16)),
            if (jenisSuhu != 'Reamur')
              Text('Reamur: ${r.toStringAsFixed(2)} °R', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {
                Navigator.pop(context); // Kembali ke Screen 0
              },
              child: const Text('Kembali'),
            ),
          ],
        ),
      ),
    );
  }
}