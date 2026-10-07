import 'dart:io';

void main() {
  print("Apakah kamu cinta coding?");
  stdout.write("Jawab (y/t): ");

  String jawab = stdin.readLineSync()!;

  // Menggunakan operator ternary sebagai ganti if/else
  var hasil = (jawab == 'y')
      ? "kamu cocok menjadi seorang programmer"
      : "Kamu memiliki ketertarikan di bidang lain";

  print("Ok berarti $hasil");
}
