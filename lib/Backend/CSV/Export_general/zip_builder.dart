import 'dart:convert';
import 'dart:typed_data';
import 'package:archive/archive.dart';

class ZipBuilder {
  static Uint8List build(Map<String, String> files) {
    final encoder = ZipEncoder();
    final archive = Archive();

    files.forEach((name, content) {
      final bytes = utf8.encode(content);

      archive.addFile(
        ArchiveFile(
          name,
          bytes.length,
          utf8.encode(content),
        ),
      );
    });

    return Uint8List.fromList(encoder.encode(archive)!);
  }
}