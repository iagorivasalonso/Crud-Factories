import 'dart:convert';
import 'dart:typed_data';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart' show rootBundle, debugPrint;

import 'package:crud_factories/Objects/RouteCSV.dart' show RouteCSV;

Future<List<RouteCSV>> csvImportRoutes({
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
        ? 'assets/dataDefault/routes.csv'
        : path.trim();

    debugPrint(
      '📦 csvImportRoutes cargando asset: "$assetPath"',
    );

    csvContent = await rootBundle.loadString(assetPath);
  }

  return readRoutesFromCsvContent(csvContent);
}


List<RouteCSV> readRoutesFromCsvContent(String content) {
  final lines = const LineSplitter()
      .convert(content)
      .where((line) => line.trim().isNotEmpty)
      .toList();

  final routes = <RouteCSV>[];

  for (final line in lines.skip(1)) {
    final parts = line.split(';');

    if (parts.length < 3) {
      continue;
    }

    final id = parts[0].trim();
    final name = parts[1].trim();
    final routePath = parts[2].trim();

    routes.add(
      RouteCSV(
        id: id,
        name: name,
        route: routePath.isEmpty ? '<EMPTY>' : routePath,
      ),
    );
  }

print(routes);

  return routes;
}
