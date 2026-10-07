import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/product_model.dart';
import '../models/promo_model.dart';
import '../widgets/product_item_card.dart';

class KatalogTab extends StatefulWidget {
  final List<Product> products;
  final List<PromoVoucher> vouchers;
  final Function(Product) onSelectProduct;

  const KatalogTab({
    super.key,
    required this.products,
    required this.vouchers,
    required this.onSelectProduct,
  });

  @override
  State<KatalogTab> createState() => _KatalogTabState();
}

class _KatalogTabState extends State<KatalogTab> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.lightGreenBg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: AppColors.primaryGreen,
                ),
                labelColor: Colors.white,
                unselectedLabelColor: AppColors.textMuted,
                labelStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                tabs: [
                  Tab(text: 'Daftar Produk'),
                  Tab(text: 'Ketentuan Promo'),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: widget.products.length,
                  itemBuilder: (context, index) {
                    final item = widget.products[index];
                    return ProductItemCard(
                      product: item,
                      onOrder: () => widget.onSelectProduct(item),
                    );
                  },
                ),
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.borderColor),
                    ),
                    child: ExpansionPanelList(
                      elevation: 0,
                      dividerColor: AppColors.borderColor,
                      expansionCallback: (int index, bool isExpanded) {
                        setState(() {
                          widget.vouchers[index].isExpanded = isExpanded;
                        });
                      },
                      children: widget.vouchers.map<ExpansionPanel>((PromoVoucher voucher) {
                        return ExpansionPanel(
                          backgroundColor: Colors.transparent,
                          headerBuilder: (BuildContext context, bool isExpanded) {
                            return ListTile(
                              leading: const Icon(Icons.confirmation_number_outlined, color: AppColors.primaryGreen),
                              title: Text(
                                voucher.title,
                                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: AppColors.darkGreen),
                              ),
                              subtitle: Text('Kode: ${voucher.code}', style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
                            );
                          },
                          body: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(voucher.description, style: const TextStyle(fontSize: 13, color: AppColors.textDark)),
                                const SizedBox(height: 10),
                                const Text(
                                  'Syarat & Ketentuan:',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: AppColors.darkGreen),
                                ),
                                const SizedBox(height: 4),
                                ...voucher.terms.map(
                                  (term) => Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text('• ', style: TextStyle(color: AppColors.primaryGreen, fontWeight: FontWeight.bold)),
                                        Expanded(child: Text(term, style: const TextStyle(fontSize: 12, color: AppColors.textMuted))),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          isExpanded: voucher.isExpanded,
                        );
                      }).toList(),
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
