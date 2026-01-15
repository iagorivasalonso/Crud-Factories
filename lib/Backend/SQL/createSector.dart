import 'dart:convert';
import 'dart:html' as html; // Solo se usa en web
import 'package:flutter/foundation.dart' as foundation;
import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Objects/Sector.dart';

Future<void> sqlCreateSector(List<Sector> sectors) async {
  try {
    for (var sector in sectors) {
      String id = sector.id;
      String name = sector.name;

      if (!foundation.kIsWeb) {
        // SQLite o DB nativa
        await executeQuery.query(
          'INSERT INTO sectors (id, sector) VALUES (?, ?)',
          [id, name],
        );
      } else {
        // Web: guardar en localStorage
        String key = 'sector_$id';
        Map<String, String> value = {
          'id': id,
          'name': name,
        };
        html.window.localStorage[key] = jsonEncode(value);
      }
    }

    print('Sectores guardados correctamente.');
  } catch (e) {
    print('Error guardando sectores: $e');
  }
}
