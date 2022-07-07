import 'dart:io';

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