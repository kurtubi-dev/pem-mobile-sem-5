//  funsgi input output
// 2.4
import 'dart:io';

void main() {
  stdout.write("Siapa kamu: ");
  var nama = stdin.readLineSync();
  print("hello $nama !");

  stdout.write("Masukkan angka: ");
  var input = stdin.readLineSync();

  int angka = int.parse(input!);

  print("Angka yang kamu masukkan : $angka");
}
