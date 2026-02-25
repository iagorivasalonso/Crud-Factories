import 'dart:convert';
import 'package:crud_factories/Backend/Global/controllers/Conection.dart';
import 'package:flutter/foundation.dart' hide Factory;
import 'package:http/http.dart' as http;
import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Objects/Factory.dart';
import '../connectors_API/connectApi.dart';


Future<void> sqlImportFactories(connectionControler controllers) async {

  if (selectedDb.isEmpty) return;

  if (kIsWeb) {
    await _loadFactoriesFromApi(controllers);
  } else {
    await _loadFactoriesFromDb();
  }
}

Future<void> _loadFactoriesFromDb() async {
  try {
    final result = await executeQuery.query('SELECT * FROM factories');
    for (final row in result) {
      allFactories.add(Factory(
        id: row[0].toString(),
        name: row[1],
        highDate: row[2],
        sector: row[3].toString(),
        thelephones: [row[4], row[5]],
        mail: row[6],
        web: row[7],
        address: {
          'street': row[8],
          'number': row[9],
          'apartament': row[10],
          'city': row[11],
          'postalCode': row[12],
          'province': row[13],
        },
      ));
    }
    debugPrint('Factories cargadas desde DB: ${allFactories.length}');
  } catch (e, stack) {
    debugPrint('DB ERROR: $e');
    debugPrintStack(stackTrace: stack);
  }
}
Future<void> _loadFactoriesFromApi(connectionControler controllers) async {
  try {

    final String nameTable = 'factories';
    final uri = await connectApi(controllers,nameTable);

    final res = await http.get(uri, headers: {'Content-Type': 'application/json'} );

    if (res.statusCode != 200) {
      throw Exception('HTTP ${res.statusCode}: ${res.body}');
    }


    final body = jsonDecode(res.body);

    if (body is List) {
      for (final row in body) {
        // Protege thelephones
// Protege los teléfonos de la API
        List<String> phonesList = [
          row['telephone1']?.toString() ?? '',
          row['telephone2']?.toString() ?? '',
        ];

        allFactories.add(Factory(
          id: row['id']?.toString() ?? '',
          name: row['name'] ?? '',
          highDate: row['highDate'] ?? '',
          sector: row['sector']?.toString() ?? '',
          thelephones: [row['telephone1'],row['telephone2']],
          mail: row['mail'] ?? '',
          web: row['web'] ?? '',
          address: {
            'street': row['address'] ?? '',
            'number': row['number'] ?? '',
            'apartament': row['apartament'] ?? '',
            'city': row['city'] ?? '',
            'postalCode': row['postalcode'] ?? '',
            'province': row['province'] ?? '',
          },
        ));
      }
    }


    debugPrint('Factories cargadas desde API: ${allFactories.length}');
  } catch (e, stack) {
    debugPrint('API ERROR: $e');
    debugPrintStack(stackTrace: stack);
  }
}
