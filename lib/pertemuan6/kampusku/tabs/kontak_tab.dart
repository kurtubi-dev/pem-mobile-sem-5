import 'package:flutter/material.dart';

class KontakTab extends StatelessWidget {
  const KontakTab({super.key});

  @override
  Widget build(BuildContext context) {
    final contacts = [
      {'nama': 'Dosen A', 'telp': '08123456789'},
      {'nama': 'Dosen B', 'telp': '08501234321'},
    ];

    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: contacts.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (_, idx) {
        final c = contacts[idx];
        return ListTile(
          leading: const CircleAvatar(child: Icon(Icons.person)),
          title: Text(c['nama']!),
          subtitle: Text(c['telp']!),
          trailing: const Icon(Icons.phone),
        );
      },
    );
  }
}
