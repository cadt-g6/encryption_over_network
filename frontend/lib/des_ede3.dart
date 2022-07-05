import 'dart:convert';
import 'dart:typed_data';
import 'package:dart_des/dart_des.dart';

class DesEde3 {
  static String encrypt(String plainText, String key) {
    List<int> encodeKey = utf8.encode(key).getRange(0, 8).toList();
    DES cipher = DES(key: encodeKey, mode: DESMode.ECB);

    plainText += '\x00' * (8 - plainText.length % 8);
    List<int> encrypted = cipher.encrypt(ascii.encode(plainText));
    String cipherBase64 = base64Encode(encrypted);

    return utf8.decode(cipherBase64.codeUnits);
  }

  static String decrypt(String cipherText, String key) {
    List<int> decodeKey = key.substring(0, 8).codeUnits;
    DES cipher = DES(key: decodeKey, mode: DESMode.ECB);
    Uint8List plainTextBase64 = base64Decode(cipherText);
    List<int> s = cipher.decrypt(plainTextBase64);

    return utf8.decode(s);
  }
}
