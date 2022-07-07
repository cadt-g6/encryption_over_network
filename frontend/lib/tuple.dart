import 'dart:io';

class Tuple {
  final String cypterText;
  final String plainText;

  Tuple(this.cypterText, this.plainText);

  @override
  String toString() {
    return "$plainText $cypterText";
  }

  Future<File> writeToFile() async {
    File file = File('assets/cache.txt');
    String str = "$plainText:$cypterText\n";
    return file.writeAsString(str, mode: FileMode.append);
  }
}
