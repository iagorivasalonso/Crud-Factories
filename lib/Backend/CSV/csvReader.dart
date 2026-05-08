import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;

class CsvReader {

  static Future<String> fromAsset(String path) {
    return rootBundle.loadString(path);
  }

  static String fromBytes(Uint8List bytes) {
    return String.fromCharCodes(bytes);
  }


}
