//  fungsi input output
// 2.3
import 'dart:io';

void main() {
  stdout.write("Siapa kamu: ");
  var nama = stdin.readLineSync();
  print("hello $nama !");
}