import 'dart:convert';
import 'dart:html' as html; // Solo para web
import 'package:flutter/foundation.dart' as foundation;
import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Objects/Empleoye.dart';

Future<void> sqlCreateEmpleoye(List<Empleoye> empleoyes) async {
  try {
    for (var emp in empleoyes) {
      String id = emp.id;
      String name = emp.name;
      String idFactory = emp.idFactory;

      if (!foundation.kIsWeb) {
        // SQLite o DB nativa
        await executeQuery.query(
          'INSERT INTO empleoyes (id, name, idFactory) VALUES (?, ?, ?)',
          [id, name, idFactory],
        );
      } else {
        // Web: guardar en localStorage
        String key = 'empleoye_$id';
        Map<String, String> value = {
          'id': id,
          'name': name,
          'idFactory': idFactory,
        };
        html.window.localStorage[key] = jsonEncode(value);
      }
    }

    print('Empleados guardados correctamente.');
  } catch (e) {
    print('Error guardando empleados: $e');
  }
}
