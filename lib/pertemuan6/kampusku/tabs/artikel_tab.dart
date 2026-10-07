import 'package:flutter/material.dart';

class ArtikelTab extends StatelessWidget {
  const ArtikelTab({super.key});

  @override
  Widget build(BuildContext context) {
    final dummyArticles = List.generate(
      8,
      (i) => {
        'title': 'Artikel ${i + 1}',
        'subtitle': 'Ringkasan singkat artikel ${i + 1}',
      },
    );

    return ListView.builder(
      itemCount: dummyArticles.length,
      itemBuilder: (_, idx) {
        final a = dummyArticles[idx];
        return ListTile(
          leading: const Icon(Icons.article),
          title: Text(a['title']!),
          subtitle: Text(a['subtitle']!),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
            // placeholder – no detail page needed for demo
          },
        );
      },
    );
  }
}
