import 'package:flutter/material.dart';

class AkunTab extends StatelessWidget {
  const AkunTab({super.key});

  @override
  Widget build(BuildContext context) {
    const data = [
      {'nim': '210001', 'nama': 'Budi', 'prodi': 'Informatika'},
      {'nim': '210002', 'nama': 'Siti', 'prodi': 'Sistem Informasi'},
      {'nim': '210003', 'nama': 'Andi', 'prodi': 'Teknik Elektro'},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('NIM')),
          DataColumn(label: Text('Nama')),
          DataColumn(label: Text('Prodi')),
        ],
        rows: data
            .map(
              (e) => DataRow(cells: [
                DataCell(Text(e['nim']!)),
                DataCell(Text(e['nama']!)),
                DataCell(Text(e['prodi']!)),
              ]),
            )
            .toList(),
      ),
    );
  }
}
