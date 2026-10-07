// sintak operator
// 2.5
import 'dart:io';

void main() {
  stdout.write("nilai a: ");
  var input_a = stdin.readLineSync();

  var angka_a = double.parse(input_a!);

  stdout.write("nilai b: ");
  var input_b = stdin.readLineSync();

  var angka_b = double.parse(input_b!);

  double hasil;

  hasil = angka_a + angka_b;

  print("hasil penjulaman : $hasil");
}
