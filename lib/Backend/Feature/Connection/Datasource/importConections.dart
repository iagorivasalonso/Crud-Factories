import 'dart:convert';
import 'dart:typed_data';
import 'dart:io' show File;
import 'package:crud_factories/Objects/Conection.dart' show Conection;
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

Future<List<Conection>> csvImportconnections({
  File? file,
  Uint8List? bytes,
  String? content,
  required String path,
}) async {
  String csvContent;

  // 1. Bytes
  if (bytes != null) {
    try {
      csvContent = utf8.decode(bytes);
    } catch (_) {
      csvContent = latin1.decode(bytes);
    }

    // 2. Contenido ya disponible
  } else if (content != null) {
    csvContent = content;

    // 3. Asset Flutter
  } else {
    final assetPath = path.trim().isEmpty
        ? 'assets/dataDefault/connections.csv'
        : path.trim();

    debugPrint(
      '📦 csvImportConections cargando asset: "$assetPath"',
    );

    csvContent = await rootBundle.loadString(assetPath);
  }


  return readconnectionsFromCsvContent(csvContent);
}

List<Conection> readconnectionsFromCsvContent(String content) {

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
