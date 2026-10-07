import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/transaction_model.dart';

class RiwayatTab extends StatelessWidget {
  final List<TransactionHistory> transactionHistory;

  const RiwayatTab({super.key, required this.transactionHistory});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Rekapitulasi Penjualan',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.darkGreen),
          ),
          const SizedBox(height: 2),
          const Text(
            'Riwayat transaksi kasir yang telah berhasil diproses',
            style: TextStyle(color: AppColors.textMuted, fontSize: 12),
          ),
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.borderColor),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor: WidgetStateProperty.all(AppColors.lightGreenBg),
                headingRowHeight: 44,
                dataRowMinHeight: 48,
                dataRowMaxHeight: 56,
                horizontalMargin: 16,
                columnSpacing: 20,
                columns: const [
                  DataColumn(label: Text('ID Transaksi', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: AppColors.darkGreen))),
                  DataColumn(label: Text('Nama Produk', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: AppColors.darkGreen))),
                  DataColumn(label: Text('Waktu', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: AppColors.darkGreen))),
                  DataColumn(label: Text('Total', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: AppColors.darkGreen))),
                  DataColumn(label: Text('Status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: AppColors.darkGreen))),
                ],
                rows: transactionHistory.map((trx) {
                  return DataRow(
                    cells: [
                      DataCell(Text(trx.transactionId, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: AppColors.textDark))),
                      DataCell(Text(trx.productName, style: const TextStyle(fontSize: 12, color: AppColors.textDark))),
                      DataCell(Text(trx.date, style: const TextStyle(fontSize: 12, color: AppColors.textMuted))),
                      DataCell(Text('Rp ${trx.totalAmount.toStringAsFixed(0)}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primaryGreen))),
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: AppColors.lightGreenBg,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            trx.status,
                            style: const TextStyle(color: AppColors.primaryGreen, fontSize: 11, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
