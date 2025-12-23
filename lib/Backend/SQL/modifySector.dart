import 'dart:convert';

import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Objects/Sector.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:http/http.dart' as http;

Future<void> sqlModifySector(List<Sector> sectors) async {

  Future<void> sqlModifySector(List<Sector> sectors) async {
    if (sectors.isEmpty) return;

    try {
      for (final sector in sectors) {
        final String id = sector.id;
        final String name = sector.name;

        if (!foundation.kIsWeb) {
          await executeQuery.query(
            'UPDATE sectors SET sector=? WHERE id=?',
            [name, id],
          );
        } else {
          final uri = Uri.parse('http://localhost:3000/$selectedDb/sectors/$id');
          final res = await http.put(
            uri,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'sector': name}),
          );

          if (res.statusCode != 200) {
            throw Exception('HTTP ${res.statusCode}: ${res.body}');
          }
        }
      }

      print('Sectores modificados: ${sectors.length}');
    } catch (e) {
      print('ERROR al modificar sectores: $e');
    }
  }

}
