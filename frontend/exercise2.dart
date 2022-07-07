import 'dart:io';
import 'package:encryption_over_network/aes.dart';
import 'api.dart';

//dart --no-sound-null-safety main.dart
void main() async {
  imageDecryption();
  imageEncryption();
}

Future<dynamic> imageDecryption() async {
  File response = await Api.get('encrypted_image');

  AesFile keyImage = AesFile('1234567890' * 2);
  Future<File> decrypteImage = keyImage.decrypt(response);

  return decrypteImage;
}

Future<dynamic> imageEncryption() async {
  AesFile keyImage = AesFile('1234567890' * 2);
  File encryptedFile = await keyImage.encrypt(File('./assets/image.jpeg'));

  await Api.send('decrypted_image', encryptedFile);
  return encryptedFile;
}
