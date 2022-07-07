import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';

class Api {
  static String host = '127.0.0.1';
  static int port = 5001;

  static Future<Map> post(String path, Map body) async {
    http.Response response = await http.post(
      Uri(
        host: host,
        path: path,
        port: port,
        scheme: 'http',
      ),
      body: jsonEncode(body),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
    );

    return jsonDecode(response.body);
  }

  static Future<File> get(String path, [Map? body]) async {
    http.Response response = await http.get(
      Uri(
        host: host,
        path: path,
        port: port,
        scheme: 'http',
      ),
    );

    File file = File('assets/downloaded.png');
    bool exists = !await file.parent.exists();
    if (!exists) await file.parent.create(recursive: true);

    await file.writeAsBytes(response.bodyBytes);
    return file;
  }

  static Future<dynamic> send(String path, File file) async {
    http.MultipartRequest request = http.MultipartRequest(
      'POST',
      Uri(
        host: host,
        path: path,
        port: port,
        scheme: 'http',
      ),
    );

    http.MultipartFile httpImamge = http.MultipartFile.fromBytes(
      'body',
      await file.readAsBytes(),
      filename: basename(file.path),
      contentType: MediaType('image', 'jpeg'),
    );

    request.files.add(httpImamge);
    await request.send();
  }
}
