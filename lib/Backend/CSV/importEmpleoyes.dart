import 'dart:convert';
import 'dart:io';
import 'dart:typed_data' show Uint8List;
import 'package:crud_factories/Objects/Empleoye.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';

Future<List<Empleoye>> csvImportEmpleoyees({
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


  return readEmpleoyeFromCsvContent(csvContent);
}

List<Empleoye> readEmpleoyeFromCsvContent(String content) {
  final lines = const LineSplitter()
      .convert(content)
      .where((line) => line.trim().isNotEmpty)
      .toList();

  final employees = <Empleoye>[];

  for (final line in lines.skip(1)) {
    final parts = line.split(";");
    if (parts.length < 3) continue;

    employees.add(Empleoye(
      id: parts[0].trim(),
      name: parts[1].trim(),
      idFactory: parts[2].trim(),
    ));
  }

  return employees;
}