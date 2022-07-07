import 'package:encryption_over_network/des_ede3.dart';
import 'package:encryption_over_network/tuple.dart';
import 'api.dart';

//dart --no-sound-null-safety main.dart
void main() async {
  var encrypt = await des3_encryption('vatanak')
    ..writeToFile();
  var decrypt = await des3_dycryption('Thea')
    ..writeToFile();
}

Future<Tuple> des3_encryption(String text) async {
  Map jsonData = {
    "text": text,
    "encrypt": 'true',
  };

  var json = await Api.post('des-ede3', jsonData);
  var cipherText = json['cipher_text'];
  var plainText = DesEde3.decrypt(cipherText, '1234567890' * 2);

  return Tuple(cipherText, plainText);
}

Future<Tuple> des3_dycryption(String text) async {
  var cipherText = DesEde3.encrypt(text, '1234567890' * 2);
  Map jsonData = {
    "text": cipherText,
    "encrypt": 'false',
  };

  var json = await Api.post('des-ede3', jsonData);
  var plainText = json['plain_text'];

  return Tuple(cipherText, plainText);
}
