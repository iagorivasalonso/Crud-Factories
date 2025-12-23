import 'dart:convert';
import 'package:flutter/foundation.dart' hide Factory;
import 'package:http/http.dart' as http;
import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Objects/Factory.dart';


Future<void> sqlImportFactories() async {
  const String baseUrl = 'http://localhost:3000';
  if (selectedDb.isEmpty) return;

  if (kIsWeb) {
    await _loadFactoriesFromApi(baseUrl);
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
Future<void> _loadFactoriesFromApi(String baseUrl) async {
  try {
    final uri = Uri.parse('$baseUrl/$selectedDb/factories?db=$selectedDb');
    final res = await http.get(uri);
    print(res);

    if (res.statusCode != 200) {
      throw Exception('HTTP ${res.statusCode}: ${res.body}');
    }

    final data = jsonDecode(res.body);
    print(data);

    // Protege contra que data no sea una lista
    final factoriesList = (data is List) ? data : [];

    for (final row in factoriesList) {
      // Protege thelephones
      final rawPhones = row['thelephones'];
      final phonesList = (rawPhones is List)
          ? rawPhones.map((e) => e.toString()).toList()
          : <String>[];

      // Protege address
      final rawAddress = row['address'];
      final addressMap = (rawAddress is Map)
          ? rawAddress.map((k, v) => MapEntry(k.toString(), v.toString()))
          : <String, String>{};

      allFactories.add(Factory(
        id: row['id']?.toString() ?? '',
        name: row['name'] ?? '',
        highDate: row['highDate'] ?? '',
        sector: row['sector']?.toString() ?? '',
        thelephones: phonesList,
        mail: row['mail'] ?? '',
        web: row['web'] ?? '',
        address: addressMap,
      ));
    }

    debugPrint('Factories cargadas desde API: ${allFactories.length}');
  } catch (e, stack) {
    debugPrint('API ERROR: $e');
    debugPrintStack(stackTrace: stack);
  }
}
