import 'package:flutter/foundation.dart' as foundation;
import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Objects/LineSend.dart';
import 'package:http/http.dart' as http;

Future<void> sqlDeleteLines(List<String> idsDelete) async {
  if (idsDelete.isEmpty) return;

  try {
    for (final item in idsDelete) {
      final String id = item;

      if (!foundation.kIsWeb) {
        await executeQuery.query('DELETE FROM linesends WHERE id=?', [id]);
      } else {
        final uri = Uri.parse('http://localhost:3000/$selectedDb/lines/$id');
        final res = await http.delete(uri);

        if (res.statusCode != 200) {
          throw Exception('HTTP ${res.statusCode}: ${res.body}');
        }
      }
    }

    print('Lines eliminadas: ${idsDelete.length}');
  } catch (e) {
    print('ERROR al eliminar lines: $e');
  }
}
