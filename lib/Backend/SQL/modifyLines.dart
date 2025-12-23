import 'dart:convert';

import 'package:flutter/foundation.dart' as foundation;
import 'package:http/http.dart' as http;

import '../../Objects/LineSend.dart';
import '../Global/variables.dart';

Future<void> sqlModifyLines(List<LineSend> linesList) async {
  if (linesList.isEmpty) return;

  try {
    for (final line in linesList) {
      final String id = line.id;
      final String date = line.date;
      final String factory = line.factory;
      final String observations = line.observations;
      final String state = line.state;

      if (!foundation.kIsWeb) {
        await executeQuery.query(
          'UPDATE linesends SET date=?, factory=?, observations=?, state=? WHERE id=?',
          [date, factory, observations, state, id],
        );
      } else {
        final uri = Uri.parse('http://localhost:3000/$selectedDb/lines/$id');
        final res = await http.put(
          uri,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'date': date,
            'factory': factory,
            'observations': observations,
            'state': state,
          }),
        );

        if (res.statusCode != 200) {
          throw Exception('HTTP ${res.statusCode}: ${res.body}');
        }
      }
    }

    print('Lines modificadas: ${linesList.length}');
  } catch (e) {
    print('ERROR al modificar lines: $e');
  }
}
