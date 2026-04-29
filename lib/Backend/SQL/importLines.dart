import 'dart:convert';
import 'package:crud_factories/Backend/Global/controllers/Conection.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Objects/LineSend.dart';
import '../connectors_API/connectApi.dart';


Future<List<LineSend>> sqlImportLines() async {

  if (selectedDb.isEmpty) return [];

  if (kIsWeb) {
    return _loadLinesFromApi();
  } else {
    return _loadLinesFromDb();
  }
}

Future<List<LineSend>> _loadLinesFromDb() async {

  final list = <LineSend>[];

  try {
    final result = await executeQuery.query('SELECT * FROM linesends');
    for (final row in result) {
      list.add(LineSend(
        id: row[0].toString(),
        date: row[1],
        factory: row[2],
        observations: row[3],
        state: row[4],
      ));
    }
    debugPrint('Lineas cargadas desde DB: ${list.length}');
  } catch (e, stack) {
    debugPrint('DB ERROR: $e');
    debugPrintStack(stackTrace: stack);
  }
  return list;
}

Future<List<LineSend>> _loadLinesFromApi() async {

  final list = <LineSend>[];
  try {

    final String nameTable = 'lines';
    final uri = await connectApi(nameTable);

    final res = await http.get(uri, headers: {'Content-Type': 'application/json'} );

    if (res.statusCode != 200) {
      throw Exception('HTTP ${res.statusCode}: ${res.body}');
    }
    final body = jsonDecode(res.body);

    if (body is List) {
      for (final row in body) {
        list.add(LineSend(
          id: row['id'].toString() ?? '',
          date: row['date'] ?? '',
          factory: row['factory'] ?? '',
          observations: row['observations'] ?? '',
          state: row['state']  ?? '',
        ));
      }
    }

    debugPrint('Lines cargadas desde API: ${list.length}');
  } catch (e, stack) {
    debugPrint('API ERROR: $e');
    debugPrintStack(stackTrace: stack);
  }
  return list;
}
