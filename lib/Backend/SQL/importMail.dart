import 'dart:convert';
import 'package:crud_factories/Backend/Global/controllers/Conection.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Objects/Mail.dart';
import '../connectors_API/connectApi.dart';

Future<List<Mail>> sqlImportMails() async {

  if (selectedDb.isEmpty) return [];

  if (kIsWeb) {
    return _loadMailsFromApi();
  } else {
    return _loadMailsFromDb();
  }
}

Future<List<Mail>> _loadMailsFromDb() async {

  final list = <Mail>[];
  try {
    final result = await executeQuery.query('SELECT * FROM mails');
    for (final row in result) {
      list.add(Mail(
        id: row[0].toString(),
        company: row[1],
        address: row[2],
        password: row[3],
      ));
    }
    debugPrint('Emails cargados desde DB: ${list.length}');
  } catch (e, stack) {
    debugPrint('DB ERROR: $e');
    debugPrintStack(stackTrace: stack);
  }
  return list;
}

Future<List<Mail>> _loadMailsFromApi() async {

  final list = <Mail>[];
  try {

    final String nameTable = 'mails';
    final uri = await connectApi(nameTable);

    final res = await http.get(uri, headers: {'Content-Type': 'application/json'} );

    if (res.statusCode != 200) {
      throw Exception('HTTP ${res.statusCode}: ${res.body}');
    }
    final body = jsonDecode(res.body);

    if (body is List) {
      for (final row in body) {
        list.add(Mail(
          id: row['id']?.toString() ?? '',
          company: row['company'] ?? '',
          address: row['email'] ?? '',      // aquí tu campo email
          password: row['password'] ?? '',
        ));
      }
    }

    debugPrint('Mails cargados desde API: ${list.length}');
  } catch (e, stack) {
    debugPrint('API ERROR: $e');
    debugPrintStack(stackTrace: stack);
  }
  return list;
}
