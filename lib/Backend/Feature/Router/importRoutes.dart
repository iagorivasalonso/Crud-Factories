import 'dart:convert';
import 'dart:typed_data';

import 'package:crud_factories/Objects/RouteCSV.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../../CSV/csvParse.dart';


Future<List<RouteCSV>> csvImportRoutes({
  Uint8List? bytes,
  String? content,
  required String path,
}) async {
  String csvContent;

  if (bytes != null) {
    try {
      csvContent = utf8.decode(bytes);
    } catch (_) {
      csvContent = latin1.decode(bytes);
    }
  } else if (content != null) {
    csvContent = content;
  } else {
    final assetPath = path.trim().isEmpty
        ? 'assets/dataDefault/routes.csv'
        : path.trim();

    debugPrint(
      '📦 csvImportRoutes cargando asset: "$assetPath"',
    );

    csvContent = await rootBundle.loadString(assetPath);
  }

  return csvParse.parseRoutes(csvContent);
}