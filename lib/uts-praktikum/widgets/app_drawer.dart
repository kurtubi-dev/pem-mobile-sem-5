import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../screens/login_screen.dart';

class AppDrawer extends StatelessWidget {
  final int currentIndex;
  final Function(int) onSelectTab;

  const AppDrawer({
    super.key,
    required this.currentIndex,
    required this.onSelectTab,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: AppColors.primaryGreen),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Image.asset('Images/logo.png', width: 44, height: 44),
                ),
                const SizedBox(width: 14),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Jualle POS',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Kasir: Budi Santoso',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.store_outlined,
              color: AppColors.primaryGreen,
            ),
            title: const Text('Katalog Produk', style: TextStyle(fontSize: 14)),
            selected: currentIndex == 0,
            onTap: () {
              onSelectTab(0);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.history_outlined,
              color: AppColors.primaryGreen,
            ),
            title: const Text(
              'Riwayat Transaksi',
              style: TextStyle(fontSize: 14),
            ),
            selected: currentIndex == 1,
            onTap: () {
              onSelectTab(1);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.info_outline,
              color: AppColors.primaryGreen,
            ),
            title: const Text('Informasi Toko', style: TextStyle(fontSize: 14)),
            selected: currentIndex == 2,
            onTap: () {
              onSelectTab(2);
              Navigator.pop(context);
            },
          ),
          const Spacer(),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout_outlined, color: Colors.red),
            title: const Text(
              'Keluar',
              style: TextStyle(color: Colors.red, fontSize: 14),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
