import 'dart:convert';
import 'dart:io';

import 'package:flutter_tensorflow/des_ede3.dart';
import 'package:http/http.dart' as http;

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

class Api {
  static Future<Map> post(String path, Map body) async {
    String host = '2358-203-189-153-190.ngrok.io';
    var response = await http.post(
      Uri(
        host: host,
        path: path,
        scheme: 'http',
      ),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(body),
    );

    return jsonDecode(response.body);
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

void main() async {
  var encrypt = await des3_encryption('abc')
    ..writeToFile();
  // var decrypt = await des3_dycryption('abc')
  //   ..writeToFile();
  // print(encrypt);
  // print(decrypt);
}
