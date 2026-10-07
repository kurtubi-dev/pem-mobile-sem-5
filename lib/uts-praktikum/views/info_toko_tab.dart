import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class InfoTokoTab extends StatelessWidget {
  const InfoTokoTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.borderColor),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'Images/logo.png',
                      width: 44,
                      height: 44,
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Jualle',
                      style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: AppColors.primaryGreen),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                const Text(
                  'Sistem Ritel Perlengkapan Kantor & Elektronik',
                  style: TextStyle(fontSize: 12, color: AppColors.textMuted),
                ),
                const Divider(height: 28),
                const ListTile(
                  dense: true,
                  leading: Icon(Icons.location_on_outlined, color: AppColors.primaryGreen, size: 20),
                  title: Text('Alamat Toko', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                  subtitle: Text('Jl. Merdeka No. 123, Kompleks Jualle Sentra, Jakarta', style: TextStyle(fontSize: 12)),
                ),
                const ListTile(
                  dense: true,
                  leading: Icon(Icons.phone_outlined, color: AppColors.primaryGreen, size: 20),
                  title: Text('Kontak Layanan', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                  subtitle: Text('+62 812-3456-7890 (Customer Care)', style: TextStyle(fontSize: 12)),
                ),
                const ListTile(
                  dense: true,
                  leading: Icon(Icons.schedule_outlined, color: AppColors.primaryGreen, size: 20),
                  title: Text('Jam Operasional', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                  subtitle: Text('Senin - Minggu (08:00 - 21:00 WIB)', style: TextStyle(fontSize: 12)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.lightGreenBg,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.primaryGreen.withOpacity(0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.verified_outlined, color: AppColors.primaryGreen, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Kode Lisensi Resmi',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.darkGreen),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                const Text(
                  'Tekan dan tahan teks di bawah ini untuk menyalin kode lisensi resmi:',
                  style: TextStyle(fontSize: 12, color: AppColors.textMuted),
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.borderColor),
                  ),
                  child: const SelectableText(
                    'LIC-JUALLE-POS-2026-NIM-GANJIL-9988776655',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryGreen,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
