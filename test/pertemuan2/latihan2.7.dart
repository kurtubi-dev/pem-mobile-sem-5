// login.dart
import 'dart:io';

void main(){
  print("### Login ###");
  stdout.write("Password : ");
  String password = stdin.readLineSync()!;

  if (password == "admin"){
    print("Login berhasil!");
  } else {
    print("Password salah!");
  }
}