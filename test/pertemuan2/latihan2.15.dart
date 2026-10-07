import 'dart:io';

void main() {
  // Membuat list dengan ukuran 5
  var languages = List.filled(5, ""); 

  print("Sebutkan ${languages.length} bahasa yang ingin kamu pelajari!");

  for (int i = 0; i < languages.length; i++) {
    stdout.write("$i. ");
    languages[i] = stdin.readLineSync() ?? ""; // Menggunakan ?? "" sebagai default jika null
  }

  print(languages);
}