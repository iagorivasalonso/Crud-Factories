import 'package:flutter/foundation.dart' as foundation;
import 'package:fluent_ui/fluent_ui.dart';
import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Functions/manageState.dart';
import 'package:crud_factories/Objects/LineSend.dart';

import '../connectors_API/saveToWebStorage.dart';


Future<void> sqlCreateLine(List<LineSend> lines, BuildContext context) async {
  try {
    for (var line in lines) {
      String id = line.id;
      String date = line.date;
      String factory = line.factory;
      String state = manageState.parseState(line.state.toString(), context, false);
      String observations = line.observations;

      if (!foundation.kIsWeb) {
        // SQLite o DB nativa
        await executeQuery.query(
          'INSERT INTO lineSends (id, date, factory, state, observations) VALUES (?, ?, ?, ?, ?)',
          [id, date, factory, state, observations],
        );
      } else {

        saveToWebStorage(
          'lines', // prefijo
          id,     // id único de la línea
          {
            'id': id,
            'date': date,
            'factory': factory,
            'state': state,
            'observations': observations,
          },
        );
      }
    }

    print('LineSends guardadas correctamente.');
  } catch (e) {
    print('Error guardando lineSends: $e');
  }
}
