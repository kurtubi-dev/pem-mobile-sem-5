import 'dart:io';

// Membuat fungsi luas persegi
int luasPersegi(int sisi) {
  return sisi * sisi;
}

void main() {
  print("--- Program luas persegi ---");
  stdout.write("Input panjang sisi: ");
  int s = int.parse(stdin.readLineSync()!);

  // Memanggil fungsi
  int hasil = luasPersegi(s);

  print("Luas: $hasil");
}