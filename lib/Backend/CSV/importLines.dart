import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:crud_factories/Objects/LineSend.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';

Future<List<LineSend>> csvImportLines({
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
    // 🟢 3. DESKTOP → usar routeFirst como archivo real
    final file = File(assetPath!);

    if (await file.exists()) {
      csvContent = await file.readAsString(encoding: utf8);
    } else {
      throw Exception("route not found: $assetPath");
    }
  }

  return readLinesFromCsvContent(csvContent);
}

Future<List<LineSend>> readLinesFromCsv(File file) async {
  final content = await file.readAsString(encoding: utf8);
  return readLinesFromCsvContent(content);
}

List<LineSend> readLinesFromCsvContent(String content) {
  final lines = const LineSplitter()
      .convert(content)
      .where((line) => line.trim().isNotEmpty)
      .toList();

  final lineSends = <LineSend>[];

  for (final line in lines.skip(1)) {
    final parts = line.split(";");

    if (parts.length < 5) continue;

    final id = parts[0].trim();
    final date = parts[1].trim();
    final factory = parts[2].trim();
    final observations = parts[3].trim();
    final state = parts[4].trim();

    // Validación simple de fecha
    if (!date.contains("-")) continue;

    lineSends.add(LineSend(
      id: id,
      date: date,
      factory: factory,
      observations: observations,
      state: state,
    ));
  }

  return lineSends;
}