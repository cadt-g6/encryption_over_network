import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';

class Api {
  static Future<Map> post(String path, Map body) async {
    String host = '4779-103-16-62-134.ngrok.io';
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

  static Future<File> get(String path, [Map? body]) async {
    String host = '4779-103-16-62-134.ngrok.io';
    var response = await http.get(
      Uri(
        host: host,
        path: path,
        scheme: 'http',
      ),
    );

    File file = File('assets/encrypted_image.png');
    if (!await file.parent.exists()) await file.parent.create(recursive: true);
    await file.writeAsBytes(response.bodyBytes);

    return file;
  }

  static Future<dynamic> send(String path, File file) async {
    String host = '4779-103-16-62-134.ngrok.io';

    var request = http.MultipartRequest(
      'POST',
      Uri(
        host: host,
        path: path,
        scheme: 'http',
      ),
    );

    var httpImamge = http.MultipartFile.fromBytes(
      'body',
      await file.readAsBytes(),
      filename: basename(file.path),
      contentType: MediaType('image', 'jpeg'),
    );
    request.files.add(httpImamge);

    await request.send();
  }
}
