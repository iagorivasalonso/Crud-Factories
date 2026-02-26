
import 'package:flutter/foundation.dart' as foundation;
import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Objects/Empleoye.dart';

import '../connectors_API/saveToWebStorage.dart';



Future<void> sqlCreateEmpleoye(List<Empleoye> empleoyes) async {

  try {
    for (var emp in empleoyes) {
      String id = emp.id;
      String name = emp.name;
      String idFactory = emp.idFactory;
      if (!foundation.kIsWeb) {
        await executeQuery.query(
          'INSERT INTO empleoyes (id, name, idFactory) VALUES (?, ?, ?)',
          [id, name, idFactory],
        );
      }
      else
      {
        saveToWebStorage(
          'empleoyes',
          id,
          {
            'id': id,
            'name': name,
            'idFactory': idFactory,
          },
        );
      }

    }

    print('Empleados guardados correctamente.');
  } catch (e) {
    print('Error guardando empleados: $e');
  }
}
