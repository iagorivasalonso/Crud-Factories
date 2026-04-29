import 'dart:convert';
import 'package:crud_factories/Backend/Global/controllers/Conection.dart';
import 'package:crud_factories/Backend/connectors_API/connectApi.dart' show connectApi;
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Objects/Empleoye.dart';

Future<List<Empleoye>> sqlImportEmpleoyes() async {

  if (selectedDb.isEmpty) return [];

  if (kIsWeb) {
     return _loadEmpleoyesFromApi();
  } else {
     return _loadEmpleoyesFromDb();
  }
}

Future<List<Empleoye>> _loadEmpleoyesFromDb() async {

  final list = <Empleoye>[];

  try {
    final result = await executeQuery.query('SELECT * FROM empleoyes');
    for (final row in result) {
      list.add(Empleoye(
        id: row[0].toString(),
        name: row[1],
        idFactory: row[2].toString(),
      ));
    }
    debugPrint('Empleados cargados desde DB: ${list.length}');
  } catch (e, stack) {
    debugPrint('DB ERROR: $e');
    debugPrintStack(stackTrace: stack);
  }
  return list;
}

Future<List<Empleoye>> _loadEmpleoyesFromApi() async {

  final list = <Empleoye>[];

  try {

    final String nameTable = 'empleoyes';
    final uri = await connectApi(nameTable);

    final res = await http.get(uri, headers: {'Content-Type': 'application/json'} );

    if (res.statusCode != 200) {
      throw Exception('HTTP ${res.statusCode}: ${res.body}');
    }

    final body = jsonDecode(res.body);

    if (body is List) {
      for (final row in body) {
        list.add(Empleoye(
          id: row['id'].toString(),
          name: row['name'],
          idFactory: row['idFactory'].toString(),
        ));

      }
    }


    debugPrint('Empleoyes cargados desde API: ${list.length}');
  } catch (e, stack) {
    debugPrint('API ERROR: $e');
    debugPrintStack(stackTrace: stack);
  }
  return list;
}
