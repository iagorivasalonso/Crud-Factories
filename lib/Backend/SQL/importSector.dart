import 'dart:convert';
import 'package:crud_factories/Backend/Global/controllers/Conection.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Objects/Sector.dart';

import '../connectors_API/connectApi.dart';

Future<List<Sector>> sqlImportSetors() async {
 

  if (selectedDb.isEmpty)return[];

  if (kIsWeb) {
    return _loadSectorsFromApi();
  } else {
    return _loadSectorsFromDb();
  }
}

/// =======================
/// DESKTOP → DB LOCAL
/// =======================
Future<List<Sector>> _loadSectorsFromDb() async {

  final list = <Sector>[];

  try {
    final result = await executeQuery.query('SELECT * FROM sectors');

    for (final row in result) {
      list.add(
        Sector(
          id: row[0].toString(),
          name: row[1],
        ),
      );
    }

    debugPrint('Sectores cargados desde DB: ${list.length}');
  } catch (e, stack) {
    debugPrint('DB ERROR: $e');
    debugPrintStack(stackTrace: stack);
  }
  return list;
}

/// =======================
/// WEB → API NODE
/// =======================
Future<List<Sector>> _loadSectorsFromApi() async {

  final list = <Sector>[];

  try {

     final String nameTable = 'sectors';
     final uri = await connectApi(nameTable);

    final res = await http.get(uri, headers: {'Content-Type': 'application/json'} );

    if (res.statusCode != 200) {
      throw Exception('HTTP ${res.statusCode}: ${res.body}');
    }

    final body = jsonDecode(res.body);

    if (body is List) {
      for (final row in body) {
        list.add(Sector(
          id: row['id']?.toString() ?? '',
          name: row['sector'] ?? '',
        ));
      }
    }
    debugPrint('Sectores cargados desde API: ${list.length}');
  } catch (e, stack) {
    debugPrint('API ERROR: $e');
    debugPrintStack(stackTrace: stack);
  }
  return list;
}
