// ignore_for_file: unused_local_variable

// Make sure encryption & decryption
// from both side matched

import 'api.dart';
import './lib/tuple.dart';
import './lib/des_ede3.dart';

String key = '1234567890' * 2;

// To execute:
// dart --no-sound-null-safety exercise1.dart
void main() async {
  Tuple encrypt = await des3_encryption('vatanak');
  await encrypt.writeToFile();

  Tuple decrypt = await des3_dycryption('Thea');
  await decrypt.writeToFile();
}

/// Expect [text] to match [plainText]:
///
/// text: initial text to encrypt
/// plainText: decrypted by `frontend`
///
Future<Tuple> des3_encryption(String text) async {
  Map jsonData = {"text": text, "encrypt": 'true'};
  Map<dynamic, dynamic> json = await Api.post('des-ede3', jsonData);
  dynamic cipherText = json['cipher_text'];

  /// decrypt ciphter text from server &
  /// expect its result which is [plainText] to match initial plain text jsonData['text']
  String plainText = DesEde3.decrypt(cipherText, key);
  return Tuple(cipherText, plainText);
}

/// Expect [text] to match [plainText]:
///
/// text: initial text to encrypt
/// plainText: decrypted by `server`
///
Future<Tuple> des3_dycryption(String text) async {
  String cipherText = DesEde3.encrypt(text, key);

  Map jsonData = {"text": cipherText, "encrypt": 'false'};
  Map<dynamic, dynamic> json = await Api.post('des-ede3', jsonData);

  dynamic plainText = json['plain_text'];
  return Tuple(cipherText, plainText);
}
