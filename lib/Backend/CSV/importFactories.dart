import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:crud_factories/Objects/Factory.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';

Future<List<Factory>> csvImportFactories({
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

  return readFactoriesFromCsvContent(csvContent);
}

List<Factory> readFactoriesFromCsvContent(String content) {
  final lines = const LineSplitter()
      .convert(content)
      .where((line) => line.trim().isNotEmpty)
      .toList();

  final factories = <Factory>[];

  for (final line in lines.skip(1)) {
    final parts = line.split(";");
    if (parts.length < 14) continue;

    factories.add(Factory(
      id: parts[0].trim(),
      name: parts[1].trim(),
      highDate: parts[2].trim(),
      sector: parts[3].trim(),
      thelephones: [
        parts[4].trim(),
        parts[5].trim(),
      ],
      mail: parts[6].trim(),
      web: parts[7].trim(),
      address: {
        'street': parts[8].trim(),
        'number': parts[9].trim(),
        'apartament': parts[10].trim(),
        'city': parts[11].trim(),
        'postalCode': parts[12].trim(),
        'province': parts[13].trim(),
      },
    ));
  }

  return factories;
}