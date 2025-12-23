import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Objects/Sector.dart';

Future<void> sqlImportSetors() async {
  const String baseUrl = 'http://localhost:3000';

  if (selectedDb.isEmpty) {
    print('BD no seleccionada');
    return;
  }

  if (kIsWeb) {
    await _loadSectorsFromApi(baseUrl);
  } else {
    await _loadSectorsFromDb();
  }
}

/// =======================
/// DESKTOP → DB LOCAL
/// =======================
Future<void> _loadSectorsFromDb() async {
  try {
    final result = await executeQuery.query('SELECT * FROM sectors');

    for (final row in result) {
      sectors.add(
        Sector(
          id: row[0].toString(),
          name: row[1],
        ),
      );
    }

    debugPrint('Sectores cargados desde DB: ${sectors.length}');
  } catch (e, stack) {
    debugPrint('DB ERROR: $e');
    debugPrintStack(stackTrace: stack);
  }
}

/// =======================
/// WEB → API NODE
/// =======================
Future<void> _loadSectorsFromApi(String baseUrl) async {
  try {
    print('$baseUrl/db/$selectedDb/sectors?db=$selectedDb');
    // Enviar selectedDb correctamente en query parameters
    final uri = Uri.parse('$baseUrl/$selectedDb/sectors?db=$selectedDb')
        .replace(queryParameters: {'db': selectedDb});

    final res = await http.get(uri);

    if (res.statusCode != 200) {
      throw Exception('HTTP ${res.statusCode}: ${res.body}');
    }

    final List<dynamic> data = jsonDecode(res.body);

    for (final row in data) {
      sectors.add(
        Sector(
          id: row['id'].toString(),
          name: row['sector'],
        ),
      );
    }

    debugPrint('Sectores cargados desde API: ${sectors.length}');
  } catch (e, stack) {
    debugPrint('API ERROR: $e');
    debugPrintStack(stackTrace: stack);
  }
}
