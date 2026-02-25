import 'dart:convert';
import 'package:crud_factories/Backend/Global/controllers/Conection.dart';
import 'package:crud_factories/Backend/SQL/connectApi.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Objects/Sector.dart';

Future<void> sqlImportSetors(connectionControler controllers) async {
 

  if (selectedDb.isEmpty) {
    print('BD no seleccionada');
    return;
  }

  if (kIsWeb) {
    await _loadSectorsFromApi(controllers);
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
Future<void> _loadSectorsFromApi(connectionControler controllers) async {

  try {

     final String nameTable = 'sectors';
     final uri = await connectApi(controllers,nameTable);

    final res = await http.get(uri, headers: {'Content-Type': 'application/json'} );

    if (res.statusCode != 200) {
      throw Exception('HTTP ${res.statusCode}: ${res.body}');
    }

    final body = jsonDecode(res.body);

    if (body is List) {
      for (final row in body) {
        sectors.add(Sector(
          id: row['id']?.toString() ?? '',
          name: row['sector'] ?? '',
        ));
      }
    }
    debugPrint('Sectores cargados desde API: ${sectors.length}');
  } catch (e, stack) {
    debugPrint('API ERROR: $e');
    debugPrintStack(stackTrace: stack);
  }
}
