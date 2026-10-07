import 'package:flutter/material.dart';

class BeritaDetailScreen extends StatelessWidget {
  final String title;
  final String imageAsset;

  const BeritaDetailScreen({
    super.key,
    required this.title,
    required this.imageAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Image.asset(imageAsset, height: 200, fit: BoxFit.cover),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
            'Suspendisse varius enim in eros elementum tristique. '
            'Duis cursus, mi quis viverra ornare, eros dolor interdum nulla.',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 24),
          // Placeholder YouTube video
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.play_circle_fill, color: Colors.red, size: 64),
                  SizedBox(height: 8),
                  Text(
                    'YouTube Video Placeholder',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
