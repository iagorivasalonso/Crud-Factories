import 'dart:convert' show utf8, latin1, LineSplitter;
import 'dart:io' show File;
import 'dart:typed_data';
import 'package:crud_factories/Backend/CSV/importLines.dart';
import 'package:crud_factories/Objects/LineSend.dart';
import 'package:crud_factories/Objects/Sector.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';

Future<List<LineSend>> csvImportLineSend({
  File? file,
  Uint8List? bytes,
  String? content,
  String? assetPath,
}) async {
  String csvContent;
  // 🟢 1. Bytes (file picker / web)
  if (bytes != null) {
    try {
      csvContent = utf8.decode(bytes);
    } catch (_) {
      csvContent = latin1.decode(bytes);
    }
  } else if (kIsWeb) {
    csvContent = await rootBundle.loadString(assetPath!);
  } else{
    // 🟢 3. DESKTOP → usar route como archivo real
    final file = File(assetPath!);

    if (await file.exists()) {
      csvContent = await file.readAsString(encoding: utf8);
    } else {
      throw Exception("route not found: $assetPath");
    }
  }
  return readLinesFromCsvContent(csvContent);
}


List<LineSend> readLinesFromCsvContent(String content) {

  final lines = const LineSplitter()
      .convert(content)
      .where((line) => line.trim().isNotEmpty)
      .toList();

  final lineSend = <LineSend>[];

  for (final line in lines.skip(1)) {
    final parts = line.split(";");
    if (parts.length < 5) continue;

    lineSend.add(LineSend(
      id: parts[0].trim(),
      date: parts[1].trim(),
      factory: parts[2].trim(),
      observations: parts[3].trim(),
      state: parts[4].trim(),
    ));
  }
print(lineSend);
  return lineSend;
}