import 'package:flutter/foundation.dart' as foundation;
import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Objects/Sector.dart';

import '../connectors_API/saveToWebStorage.dart';


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
        saveToWebStorage(
          'sectors', // prefijo
          id,     // id único de la línea
          {
            'id': id,
            'sector': name,
          },
        );
      }

    }
    print('Sectores guardados correctamente.');
  } catch (e) {
    print('Error guardando sectores: $e');
  }
}
