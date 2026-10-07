import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/product_model.dart';
import '../models/promo_model.dart';
import '../models/transaction_model.dart';
import '../widgets/app_drawer.dart';
import '../views/katalog_tab.dart';
import '../views/riwayat_tab.dart';
import '../views/info_toko_tab.dart';
import 'order_form_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Product> _products = [
    Product(
      id: 'P001',
      name: 'Kertas HVS A4 80gsm (1 Rim)',
      category: 'Perlengkapan Kantor',
      price: 55000,
      stock: 45,
      discount: 10,
      imageUrl: 'Images/kertas.jpg',
    ),
    Product(
      id: 'P002',
      name: 'Printer Wireless Multitasking',
      category: 'Elektronik',
      price: 1850000,
      stock: 8,
      discount: 15,
      imageUrl: 'Images/printer.webp',
    ),
    Product(
      id: 'P003',
      name: 'Proyektor Mini Portable',
      category: 'Elektronik',
      price: 2400000,
      stock: 5,
      discount: 20,
      imageUrl: 'Images/proyektor.webp',
    ),
    Product(
      id: 'P004',
      name: 'Mouse Ergonomis Wireless',
      category: 'Aksesoris Komputer',
      price: 150000,
      stock: 25,
      discount: 5,
      imageUrl: 'Images/mouse.jpg',
    ),
    Product(
      id: 'P005',
      name: 'Stapler Heavy Duty',
      category: 'Perlengkapan Kantor',
      price: 85000,
      stock: 12,
      discount: 0,
      imageUrl: 'Images/stapler.jpg',
    ),
  ];

  final List<PromoVoucher> _vouchers = [
    PromoVoucher(
      title: 'Voucher Jualle Hemat 15%',
      code: 'JUALLE15',
      description: 'Diskon 15% untuk pembelian minimal Rp 200.000.',
      terms: [
        'Berlaku untuk semua item kategori Elektronik & Kantor.',
        'Tidak dapat digabungkan dengan promo cuci gudang.',
        'Masa berlaku hingga 31 Desember 2026.',
      ],
    ),
    PromoVoucher(
      title: 'Promo Gratis Ongkir Kargo',
      code: 'JUALLEFREESHIP',
      description: 'Potongan ongkos kirim hingga Rp 25.000.',
      terms: [
        'Minimal transaksi Rp 500.000.',
        'Khusus untuk opsi pengiriman Kargo.',
        'Berlaku 1 kali per akun kasir per hari.',
      ],
    ),
    PromoVoucher(
      title: 'Diskon Aksesoris Komputer 20%',
      code: 'AKSESORIS20',
      description: 'Potongan harga khusus kategori aksesoris.',
      terms: [
        'Tanpa minimal belanja.',
        'Berlaku khusus pembayaran tunai / POS Jualle.',
      ],
    ),
  ];

  final List<TransactionHistory> _transactionHistory = [
    TransactionHistory(
      transactionId: 'TRX-982101',
      productName: 'Printer Wireless Multitasking (x1)',
      date: '07/10/2026 09:15',
      totalAmount: 1612500,
      status: 'Berhasil',
    ),
    TransactionHistory(
      transactionId: 'TRX-982102',
      productName: 'Kertas HVS A4 (x5)',
      date: '07/10/2026 09:30',
      totalAmount: 257500,
      status: 'Berhasil',
    ),
  ];

  Future<void> _navigateToOrderForm(Product product) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderFormScreen(product: product),
      ),
    );

    if (result != null && result is TransactionHistory) {
      setState(() {
        _transactionHistory.insert(0, result);
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle_outline, color: Colors.white, size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Transaksi ${result.transactionId} Berhasil Diproses!',
                    style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
                  ),
                ),
              ],
            ),
            backgroundColor: AppColors.darkGreen,
            duration: const Duration(seconds: 4),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      KatalogTab(
        products: _products,
        vouchers: _vouchers,
        onSelectProduct: _navigateToOrderForm,
      ),
      RiwayatTab(
        transactionHistory: _transactionHistory,
      ),
      const InfoTokoTab(),
    ];

    final List<String> titles = [
      'Katalog Produk Jualle',
      'Riwayat Penjualan',
      'Informasi Toko Jualle',
    ];

    return Scaffold(
      backgroundColor: AppColors.bgOffWhite,
      appBar: AppBar(
        title: Text(titles[_currentIndex], style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.textDark, fontSize: 17)),
        backgroundColor: Colors.white,
        elevation: 0.5,
        iconTheme: const IconThemeData(color: AppColors.textDark),
      ),
      drawer: AppDrawer(
        currentIndex: _currentIndex,
        onSelectTab: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.borderColor, width: 0.5)),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          selectedItemColor: AppColors.primaryGreen,
          unselectedItemColor: AppColors.textMuted,
          backgroundColor: Colors.white,
          elevation: 0,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.store_outlined),
              activeIcon: Icon(Icons.store),
              label: 'Katalog',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history_outlined),
              activeIcon: Icon(Icons.history),
              label: 'Riwayat',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info_outline),
              activeIcon: Icon(Icons.info),
              label: 'Info Toko',
            ),
          ],
        ),
      ),
    );
  }
}
