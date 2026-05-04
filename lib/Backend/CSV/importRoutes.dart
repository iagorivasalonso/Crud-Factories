import 'dart:convert';
import 'dart:typed_data';
import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Objects/RouteCSV.dart' show RouteCSV;
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb, debugPrint;
import 'dart:io' show File;

import 'package:crud_factories/Objects/RouteCSV.dart';
import 'package:universal_html/html.dart' hide File;

Future<List<RouteCSV>> csvImportRoutes({
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
    csvContent = await rootBundle.loadString(routeFirst);
  } else{
    // 🟢 3. DESKTOP → usar routeFirst como archivo real
    final file = File(routeFirst);

    if (await file.exists()) {
      csvContent = await file.readAsString(encoding: utf8);
    } else {
      throw Exception("routeFirst not found: $routeFirst");
    }
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