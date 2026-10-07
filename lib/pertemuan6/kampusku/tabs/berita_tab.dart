import 'package:flutter/material.dart';
import 'berita_detail.dart';

class BeritaTab extends StatelessWidget {
  const BeritaTab({super.key});

  @override
  Widget build(BuildContext context) {
    final berita = List.generate(
      6,
      (i) => {
        'title': 'Berita Kampus #${i + 1}',
        'subtitle': 'Ringkasan singkat berita ${i + 1}',
        'image': 'Images/gambar.jpeg',
      },
    );

    return ListView.builder(
      itemCount: berita.length,
      itemBuilder: (_, idx) {
        final b = berita[idx];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: ListTile(
            leading: Image.asset(b['image']!, width: 60, height: 60, fit: BoxFit.cover),
            title: Text(b['title']!),
            subtitle: Text(b['subtitle']!),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BeritaDetailScreen(
                  title: b['title']!,
                  imageAsset: b['image']!,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
