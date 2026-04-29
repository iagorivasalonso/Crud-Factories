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
      assetPath ?? "assets/dataDefault/employees.csv",
    );
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