import 'dart:convert';
import 'package:crud_factories/Backend/Global/controllers/Conection.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Objects/Mail.dart';

import 'connectApi.dart';

Future<void> sqlImportMails(connectionControler controllers) async {

  if (selectedDb.isEmpty) return;

  if (kIsWeb) {
    await _loadMailsFromApi(controllers);
  } else {
    await _loadMailsFromDb();
  }
}

Future<void> _loadMailsFromDb() async {
  try {
    final result = await executeQuery.query('SELECT * FROM mails');
    for (final row in result) {
      mails.add(Mail(
        id: row[0].toString(),
        company: row[1],
        address: row[2],
        password: row[3],
      ));
    }
    debugPrint('Mails cargados desde DB: ${mails.length}');
  } catch (e, stack) {
    debugPrint('DB ERROR: $e');
    debugPrintStack(stackTrace: stack);
  }
}

Future<void> _loadMailsFromApi(connectionControler controllers) async {
  try {

    final String nameTable = 'mails';
    final uri = await connectApi(controllers,nameTable);

    final res = await http.get(uri, headers: {'Content-Type': 'application/json'} );

    if (res.statusCode != 200) {
      throw Exception('HTTP ${res.statusCode}: ${res.body}');
    }
    final body = jsonDecode(res.body);

    if (body is List) {
      for (final row in body) {
        mails.add(Mail(
          id: row['id']?.toString() ?? '',
          company: row['company'] ?? '',
          address: row['email'] ?? '',      // aquí tu campo email
          password: row['password'] ?? '',
        ));
      }
    }

    final List<dynamic> data = jsonDecode(res.body);
    for (final row in data) {
      mails.add(Mail(
        id: row['id']?.toString() ?? '',
        company: row['company'] ?? '',
        address: row['email'] ?? '',      // aquí tu campo email
        password: row['password'] ?? '',
      ));
    }
    debugPrint('Mails cargados desde API: ${mails.length}');
  } catch (e, stack) {
    debugPrint('API ERROR: $e');
    debugPrintStack(stackTrace: stack);
  }
}
