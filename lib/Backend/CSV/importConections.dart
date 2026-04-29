import 'dart:convert';
import 'dart:typed_data';
import 'dart:io' show File;
import 'package:crud_factories/Objects/Conection.dart' show Conection;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';

Future<List<Conection>> csvImportConections({
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
      assetPath ?? "assets/dataDefault/conections.csv",
    );
  }

  return readConectionsFromCsvContent(csvContent);
}

List<Conection> readConectionsFromCsvContent(String content) {
  final lines = const LineSplitter()
      .convert(content)
      .where((line) => line.trim().isNotEmpty)
      .toList();

  final connections = <Conection>[];

  for (final line in lines.skip(1)) {
    final parts = line.split(";");
    if (parts.length < 6) continue;

    connections.add(Conection(
      id: parts[0].trim(),
      database: parts[1].trim(),
      host: parts[2].trim(),
      port: parts[3].trim(),
      user: parts[4].trim(),
      password: parts[5].trim(),
    ));
  }

  print('Connections loaded: ${connections.length}');
  return connections;
}