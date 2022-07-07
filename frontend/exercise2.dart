/// Encrypt & decrypt image from & to server with AES algorithms.

import 'dart:io';
import 'api.dart';
import './lib/aes.dart';

/// To execute:
/// dart --no-sound-null-safety exercise2.dart
void main() async {
  print("START");

  await imageDecryption();
  await imageEncryption();

  print("DONE");
  return;
}

/// Get encrypted image from server then decrypt here to view image
Future<File> imageDecryption() async {
  File response = await Api.get('encrypted_image');

  AesFile keyImage = AesFile(key: '1234567890' * 2);
  File decrypteImage = await keyImage.decrypt(response);

  return decrypteImage;
}

/// Encrypt image & send it to server which then server need to decrypt to view the image
Future<File> imageEncryption() async {
  AesFile keyImage = AesFile(key: '1234567890' * 2);
  File encryptedFile = await keyImage.encrypt(File('./assets/image.jpeg'));

  await Api.send('decrypted_image', encryptedFile);
  return encryptedFile;
}
