import 'dart:convert';
import 'dart:typed_data';
import 'package:crud_factories/Objects/RouteCSV.dart' show RouteCSV;
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb, debugPrint;
import 'dart:io' show File;
import 'package:crud_factories/Objects/RouteCSV.dart';

Future<List<RouteCSV>> csvImportRoutes({
  File? file,
  Uint8List? bytes,
  String? content,
  required String path,
}) async {

  String csvContent;

  // 🟢 1. bytes
  if (bytes != null) {
    try {
      csvContent = utf8.decode(bytes);

      debugPrint(
        '✅ Asset cargado correctamente: $path (${csvContent.length} caracteres)',
      );
    } catch (e, stack) {
      debugPrint('❌ ERROR cargando asset: $path');
      debugPrint('❌ $e');
      debugPrint('$stack');

      rethrow;
    }

    // 🟢 2. web o asset
  } else if (kIsWeb){
    debugPrint('🌐 Cargando asset WEB: $path');

  csvContent = await rootBundle.loadString(path);

    // 🟢 3. desktop/mobile file
  } else {
    final file = File(path);

    if (!await file.exists()) {
      return []; // mejor que crash
    }

    csvContent = await file.readAsString(encoding: utf8);
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
    final parts = line.split(";");
    if (parts.length < 3) continue;

    final id = parts[0].trim();
    final name = parts[1].trim();
    final routePath = parts[2].trim();

    routes.add(RouteCSV(
      id: id,
      name: name,
      route: routePath.isEmpty ? "<EMPTY>" : routePath,
    ));
  }

  debugPrint('Routes loaded: ${routes.length}');
  return routes;
}
