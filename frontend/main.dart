import 'dart:io';
import 'package:encryption_over_network/aes.dart';
import 'package:encryption_over_network/des_ede3.dart';
import 'api.dart';

enum Mode { encrypt, decrypt }

class Tuple {
  final String cypterText;
  final String plainText;

  Tuple(this.cypterText, this.plainText);

  @override
  String toString() {
    return "$plainText $cypterText";
  }

  writeToFile() {
    var file = File('cache.txt');
    file.writeAsString("$plainText $cypterText", mode: FileMode.append);
  }
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

Future<dynamic> imageDecryption() async {
  var response = await Api.get('encrypted_image');

  print('response $response');

  var keyImage = AesFile('1234567890' * 2);
  var decrypteImage = keyImage.decrypt(response);

  return decrypteImage;
}

Future<dynamic> imageEncryption() async {
  var keyImage = AesFile('1234567890' * 2);
  var encryptedFile = await keyImage.encrypt(File('./assets/image.jpeg'));

  await Api.send('decrypted_image', encryptedFile);
  return encryptedFile;
}

void main() async {
  // var encrypt = await des3_encryption('vatanak')
  //   ..writeToFile();
  // var decrypt = await des3_dycryption('Thea')
  //   ..writeToFile();
  // imageDecryption();
  imageEncryption();
}
