import 'dart:io';

class FileReader {

  static Future<String> fromFile(String path) async {
    final file = File(path);

    if (!await file.exists()) {
      throw Exception("FILE NOT FOUND: $path");
    }

    return file.readAsString();
  }
}