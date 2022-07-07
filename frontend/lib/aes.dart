import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:aes_crypt/aes_crypt.dart';

// void main() async {
//   var image = File('encrypted 0.jpeg');

//   var tt = AesFile('1234567890' * 2);
//   // var encryt = await tt.encrypt(image);
//   var decry = await tt.decrypt(image);

//   print(tt);
// }

class AesFile {
  final String key;

  late final List<int> encodedKey;
  late final AesCrypt crypt;

  AesFile(this.key) {
    encodedKey = utf8.encode(key).getRange(0, 16).toList();
    crypt = AesCrypt();
    crypt.aesSetMode(AesMode.ofb);
    crypt.aesSetKeys(
      Uint8List.fromList(encodedKey),
      Uint8List.fromList(encodedKey),
    );
  }

  Future<File> encrypt(File file) async {
    Uint8List bytes = await file.readAsBytes();

    List<int> list = [...bytes.toList()];
    while (list.length % 16 != 0) list.add(0);

    Uint8List data = Uint8List.fromList(list);
    Uint8List result = crypt.aesEncrypt(data);

    File encrypted = File('encrypted.jpeg');
    await encrypted.writeAsBytes(result);

    return encrypted;
  }

  Future<File> decrypt(File file) async {
    Uint8List bytes = await file.readAsBytes();
    Uint8List decrypted = crypt.aesDecrypt(bytes);

    List<int> list = [...decrypted.toList()];
    while (list.last == 0) list.removeLast();

    File encrypted = File('decrypted.jpeg');
    await encrypted.writeAsBytes(Uint8List.fromList(list));

    return encrypted;
  }
}
