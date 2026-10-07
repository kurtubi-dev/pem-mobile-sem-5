import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/product_model.dart';
import '../models/transaction_model.dart';

class OrderFormScreen extends StatefulWidget {
  final Product product;

  const OrderFormScreen({super.key, required this.product});

  @override
  State<OrderFormScreen> createState() => _OrderFormScreenState();
}

class _OrderFormScreenState extends State<OrderFormScreen> {
  int _quantity = 1;
  String _shippingMethod = 'Reguler';

  bool _insurance = false;
  bool _bubbleWrap = false;
  bool _woodenPacking = false;

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  double _memberDiscountPercent = 10.0;
  bool _isDropshipOrGiftWrap = false;

  final Map<String, double> _shippingCosts = {
    'Reguler': 10000,
    'Kargo': 25000,
    'Instan': 35000,
  };

  double get _extraServicesCost {
    double total = 0;
    if (_insurance) total += 5000;
    if (_bubbleWrap) total += 3000;
    if (_woodenPacking) total += 15000;
    return total;
  }

  double get _subtotal => widget.product.price * _quantity;
  double get _productDiscountAmount => _subtotal * (widget.product.discount / 100);
  double get _memberDiscountAmount => (_subtotal - _productDiscountAmount) * (_memberDiscountPercent / 100);
  double get _shippingCost => _shippingCosts[_shippingMethod] ?? 10000;
  double get _grandTotal => (_subtotal - _productDiscountAmount - _memberDiscountAmount) + _shippingCost + _extraServicesCost;

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 10, minute: 0),
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _processTransaction() {
    if (_selectedDate == null || _selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Silakan pilih Tanggal dan Jam pengambilan terlebih dahulu!'),
          backgroundColor: AppColors.accentRed,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Ringkasan Transaksi Kasir',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.darkGreen),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: AppColors.textMuted, size: 20),
                    onPressed: () => Navigator.pop(ctx),
                  ),
                ],
              ),
              const Divider(height: 20),
              _buildCostRow('Produk (${widget.product.name} x$_quantity)', 'Rp ${_subtotal.toStringAsFixed(0)}'),
              if (widget.product.discount > 0)
                _buildCostRow('Diskon Produk (${widget.product.discount}%)', '- Rp ${_productDiscountAmount.toStringAsFixed(0)}', isDiscount: true),
              if (_memberDiscountPercent > 0)
                _buildCostRow('Diskon Member (${_memberDiscountPercent.round()}%)', '- Rp ${_memberDiscountAmount.toStringAsFixed(0)}', isDiscount: true),
              _buildCostRow('Pengiriman ($_shippingMethod)', 'Rp ${_shippingCost.toStringAsFixed(0)}'),
              _buildCostRow('Layanan Ekstra', 'Rp ${_extraServicesCost.toStringAsFixed(0)}'),
              if (_isDropshipOrGiftWrap)
                _buildCostRow('Opsi Dropship / Bungkus Kado', 'Aktif', isAccent: true),
              const Divider(height: 24),
              _buildCostRow(
                'TOTAL PEMBAYARAN',
                'Rp ${_grandTotal.toStringAsFixed(0)}',
                isBold: true,
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 46,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.check_circle_outline, size: 18),
                  label: const Text('PROSES & SIMPAN TRANSAKSI', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryGreen,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    Navigator.pop(ctx);
                    _showFinalAlertDialog();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showFinalAlertDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Konfirmasi Transaksi', style: TextStyle(color: AppColors.darkGreen, fontSize: 17, fontWeight: FontWeight.bold)),
          content: Text(
            'Apakah Anda yakin ingin menyelesaikan transaksi untuk ${widget.product.name} sebesar Rp ${_grandTotal.toStringAsFixed(0)}?',
            style: const TextStyle(fontSize: 13, color: AppColors.textDark),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Batal', style: TextStyle(color: AppColors.textMuted)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryGreen,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                Navigator.pop(dialogContext);
                
                final String dateStr = '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year} ${_selectedTime!.format(context)}';
                final transactionResult = TransactionHistory(
                  transactionId: 'TRX-JUALLE-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
                  productName: '${widget.product.name} (x$_quantity)',
                  date: dateStr,
                  totalAmount: _grandTotal,
                  status: 'Berhasil',
                );

                Navigator.pop(context, transactionResult);
              },
              child: const Text('Setujui & Simpan', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCostRow(String label, String value, {bool isDiscount = false, bool isBold = false, bool isAccent = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                fontSize: isBold ? 14 : 13,
                color: isBold ? AppColors.textDark : AppColors.textMuted,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: isBold ? 15 : 13,
              color: isDiscount ? AppColors.accentRed : (isAccent ? AppColors.primaryGreen : (isBold ? AppColors.primaryGreen : AppColors.textDark)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 14, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.darkGreen),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String dateText = _selectedDate == null
        ? 'Pilih Tanggal'
        : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}';
    String timeText = _selectedTime == null
        ? 'Pilih Jam'
        : _selectedTime!.format(context);

    return Scaffold(
      backgroundColor: AppColors.bgOffWhite,
      appBar: AppBar(
        title: const Text('Form Pemesanan', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textDark, fontSize: 17)),
        backgroundColor: Colors.white,
        elevation: 0.5,
        iconTheme: const IconThemeData(color: AppColors.textDark),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.borderColor),
              ),
              child: Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: AppColors.lightGreenBg,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: widget.product.imageUrl.startsWith('http')
                        ? Image.network(
                            widget.product.imageUrl,
                            width: 56,
                            height: 56,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Image.asset('Images/logo.png', fit: BoxFit.contain),
                            ),
                          )
                        : Image.asset(
                            widget.product.imageUrl,
                            width: 56,
                            height: 56,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Image.asset('Images/logo.png', fit: BoxFit.contain),
                            ),
                          ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.product.name,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textDark),
                        ),
                        const SizedBox(height: 2),
                        Text('Rp ${widget.product.price.toStringAsFixed(0)} / unit | Stok: ${widget.product.stock}', style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.borderColor),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Jumlah Kuantitas', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: AppColors.textDark)),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline, color: AppColors.primaryGreen, size: 22),
                        onPressed: _quantity > 1 ? () => setState(() => _quantity--) : null,
                      ),
                      Text('$_quantity', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline, color: AppColors.primaryGreen, size: 22),
                        onPressed: _quantity < widget.product.stock ? () => setState(() => _quantity++) : null,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            _buildSectionHeader('1. Metode Pengiriman (Kurir)'),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.borderColor),
              ),
              child: Column(
                children: [
                  RadioListTile<String>(
                    dense: true,
                    activeColor: AppColors.primaryGreen,
                    title: const Text('Reguler (Rp 10.000)', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                    subtitle: const Text('Estimasi 2-3 hari kerja', style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
                    value: 'Reguler',
                    groupValue: _shippingMethod,
                    onChanged: (val) => setState(() => _shippingMethod = val!),
                  ),
                  const Divider(height: 1),
                  RadioListTile<String>(
                    dense: true,
                    activeColor: AppColors.primaryGreen,
                    title: const Text('Kargo (Rp 25.000)', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                    subtitle: const Text('Untuk pengiriman jumlah besar', style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
                    value: 'Kargo',
                    groupValue: _shippingMethod,
                    onChanged: (val) => setState(() => _shippingMethod = val!),
                  ),
                  const Divider(height: 1),
                  RadioListTile<String>(
                    dense: true,
                    activeColor: AppColors.primaryGreen,
                    title: const Text('Instan (Rp 35.000)', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                    subtitle: const Text('Sampai dalam hari yang sama', style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
                    value: 'Instan',
                    groupValue: _shippingMethod,
                    onChanged: (val) => setState(() => _shippingMethod = val!),
                  ),
                ],
              ),
            ),
            _buildSectionHeader('2. Layanan Ekstra Proteksi'),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.borderColor),
              ),
              child: Column(
                children: [
                  CheckboxListTile(
                    dense: true,
                    activeColor: AppColors.primaryGreen,
                    title: const Text('Asuransi Pengiriman (+Rp 5.000)', style: TextStyle(fontSize: 13)),
                    value: _insurance,
                    onChanged: (val) => setState(() => _insurance = val ?? false),
                  ),
                  const Divider(height: 1),
                  CheckboxListTile(
                    dense: true,
                    activeColor: AppColors.primaryGreen,
                    title: const Text('Bubble Wrap Ekstra (+Rp 3.000)', style: TextStyle(fontSize: 13)),
                    value: _bubbleWrap,
                    onChanged: (val) => setState(() => _bubbleWrap = val ?? false),
                  ),
                  const Divider(height: 1),
                  CheckboxListTile(
                    dense: true,
                    activeColor: AppColors.primaryGreen,
                    title: const Text('Packing Kayu (+Rp 15.000)', style: TextStyle(fontSize: 13)),
                    value: _woodenPacking,
                    onChanged: (val) => setState(() => _woodenPacking = val ?? false),
                  ),
                ],
              ),
            ),
            _buildSectionHeader('3. Jadwal Pengambilan Barang'),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primaryGreen,
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: AppColors.borderColor),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    icon: const Icon(Icons.calendar_today_outlined, size: 16),
                    label: Text(dateText, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                    onPressed: _pickDate,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primaryGreen,
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: AppColors.borderColor),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    icon: const Icon(Icons.access_time_outlined, size: 16),
                    label: Text(timeText, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                    onPressed: _pickTime,
                  ),
                ),
              ],
            ),
            _buildSectionHeader('4. Penyesuaian Diskon & Dropship'),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.borderColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Diskon Member:', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textDark)),
                      Text('${_memberDiscountPercent.round()}%', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.primaryGreen)),
                    ],
                  ),
                  Slider(
                    activeColor: AppColors.primaryGreen,
                    inactiveColor: AppColors.lightGreenBg,
                    value: _memberDiscountPercent,
                    min: 0.0,
                    max: 30.0,
                    divisions: 6,
                    onChanged: (val) => setState(() => _memberDiscountPercent = val),
                  ),
                  const Divider(height: 1),
                  SwitchListTile(
                    dense: true,
                    activeColor: AppColors.primaryGreen,
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Aktifkan Dropship / Bungkus Kado', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                    subtitle: const Text('Kirim tanpa logo/struk ritel utama', style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
                    value: _isDropshipOrGiftWrap,
                    onChanged: (val) => setState(() => _isDropshipOrGiftWrap = val),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.receipt_long_outlined, size: 18),
                label: const Text('PROSES TRANSAKSI', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryGreen,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: _processTransaction,
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
