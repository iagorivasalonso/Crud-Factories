import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Objects/Empleoye.dart';

Future<void> sqlImportEmpleoyes() async {
  const String baseUrl = 'http://localhost:3000';
  if (selectedDb.isEmpty) return;

  if (kIsWeb) {
    await _loadEmpleoyesFromApi(baseUrl);
  } else {
    await _loadEmpleoyesFromDb();
  }
}

Future<void> _loadEmpleoyesFromDb() async {
  try {
    final result = await executeQuery.query('SELECT * FROM empleoyes');
    for (final row in result) {
      empleoyes.add(Empleoye(
        id: row[0].toString(),
        name: row[1],
        idFactory: row[2].toString(),
      ));
    }
    debugPrint('Empleoyes cargados desde DB: ${empleoyes.length}');
  } catch (e, stack) {
    debugPrint('DB ERROR: $e');
    debugPrintStack(stackTrace: stack);
  }
}

Future<void> _loadEmpleoyesFromApi(String baseUrl) async {
  try {
    final uri = Uri.parse('$baseUrl/$selectedDb/empleoyes?db=$selectedDb');
    final res = await http.get(uri);
print(uri);
    if (res.statusCode != 200) {
      throw Exception('HTTP ${res.statusCode}: ${res.body}');
    }

    final List<dynamic> data = jsonDecode(res.body);
    for (final row in data) {
      empleoyes.add(Empleoye(
        id: row['id'].toString(),
        name: row['name'],
        idFactory: row['idFactory'].toString(),
      ));

    }
    print(empleoyes);
    debugPrint('Empleoyes cargados desde API: ${empleoyes.length}');
  } catch (e, stack) {
    debugPrint('API ERROR: $e');
    debugPrintStack(stackTrace: stack);
  }
}
