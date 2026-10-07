import 'dart:io';

// Class Barang dengan Encapsulation
class Barang {
  String nama;
  double harga;
  int _stok; // Private property

  Barang(this.nama, this.harga, int stok) : _stok = stok;

  int get stok => _stok;

  bool kurangiStok(int jumlah) {
    if (jumlah <= _stok) {
      _stok -= jumlah;
      return true;
    }
    return false;
  }
}

// Item Transaksi
class ItemBelanja {
  Barang barang;
  int jumlah;

  ItemBelanja(this.barang, this.jumlah);

  double get subtotal => barang.harga * jumlah;
}

// Class Transaksi
class Transaksi {
  List<ItemBelanja> itemList = [];

  void tambahItem(Barang barang, int jumlah) {
    itemList.add(ItemBelanja(barang, jumlah));
  }

  double hitungTotal() {
    double total = 0;
    for (var item in itemList) {
      total += item.subtotal;
    }
    return total;
  }
}

void main() {
  List<Barang> produkToko = [
    Barang("Indomie Goreng", 5000, 20),
    Barang("Indomie Rebus", 5000, 25),
    Barang("Telur", 2500, 50),
    Barang("Air Mineral", 5000, 20),
  ];

  Transaksi transaksi = Transaksi();
  bool belanjaLagi = true;

  
  print("=== TOKO DIMAS ANJAY MABAR ===");

  while (belanjaLagi) {
    print("\n--- KATALOG PRODUK ---");
    for (int i = 0; i < produkToko.length; i++) {
      print(
          "[${i + 1}] ${produkToko[i].nama} | Rp ${produkToko[i].harga.toInt()} | Tersedia: ${produkToko[i].stok}");
    }

    stdout.write("\nPilih nomor produk [1-${produkToko.length}]: ");
    int pilihan = int.parse(stdin.readLineSync()!) - 1;

    if (pilihan < 0 || pilihan >= produkToko.length) {
      print(">> Pilihan tidak valid!");
      continue;
    }

    stdout.write("Jumlah pembelian: ");
    int jumlah = int.parse(stdin.readLineSync()!);

    if (produkToko[pilihan].kurangiStok(jumlah)) {
      transaksi.tambahItem(produkToko[pilihan], jumlah);
      print(">> Berhasil menambahkan ke keranjang!");
    } else {
      print(">> Gagal: Stok tidak mencukupi!");
    }

    stdout.write("\nBeli barang lain? (y/n): ");
    String konfirmasi = stdin.readLineSync()!.toLowerCase();
    if (konfirmasi != 'y') {
      belanjaLagi = false;
    }
  }

  // Struk Pembelian
  print("\n====================================");
  print("          STRUK PEMBELIAN           ");
  print("====================================");
  for (var item in transaksi.itemList) {
    print(
        "${item.barang.nama} x ${item.jumlah} item  ->  Rp ${item.subtotal.toInt()}");
  }
  print("------------------------------------");
  print("TOTAL PEMBAYARAN : Rp ${transaksi.hitungTotal().toInt()}");
  print("====================================");

  // Update Stok Akhir
  print("\n--- UPDATE STOK TERBARU ---");
  for (var produk in produkToko) {
    print("• ${produk.nama} : Sisa ${produk.stok} item");
  }

  print("\nTerima kasih telah berbelanja!");
}