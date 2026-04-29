import 'dart:convert' show utf8, latin1, LineSplitter;
import 'dart:io' show File;
import 'dart:typed_data';
import 'package:crud_factories/Objects/Sector.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';

Future<List<Sector>> csvImportSectors({
  File? file,
  Uint8List? bytes,
  String? content,
  String? assetPath,
}) async {
  String csvContent;

  if (bytes != null) {
    try {
      csvContent = utf8.decode(bytes);
    } catch (_) {
      csvContent = latin1.decode(bytes);
    }
  }

  // 📄 String directo
  else if (content != null) {
    csvContent = content;
  }

  // 🖥️ Desktop / Mobile file
  else if (!kIsWeb && file != null) {
    csvContent = await file.readAsString(encoding: utf8);
  }

  // 📦 Asset (fallback automático)
  else {
    csvContent = await rootBundle.loadString(
      assetPath ?? "assets/dataDefault/sectors.csv",
    );
  }

  return readSectorsFromCsvContent(csvContent);
}

Future<List<Sector>> readSectorsFromCsv(File file) async {
  final content = await file.readAsString(encoding: utf8);
  return readSectorsFromCsvContent(content);
}

List<Sector> readSectorsFromCsvContent(String content) {
  final lines = const LineSplitter()
      .convert(content)
      .where((line) => line.trim().isNotEmpty)
      .toList();

  final sectors = <Sector>[];

  for (final line in lines.skip(1)) {
    final parts = line.split(";");
    if (parts.length < 2) continue;

    sectors.add(Sector(
      id: parts[0].trim(),
      name: parts[1].trim(),
    ));
  }

  return sectors;
}