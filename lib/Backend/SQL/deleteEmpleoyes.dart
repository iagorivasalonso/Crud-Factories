import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Objects/Empleoye.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:http/http.dart' as http;

Future<void> sqlDeleteEmpleoyes(List<Empleoye> idsDelete) async {
  if (idsDelete.isEmpty) return;

  try {
    for (final item in idsDelete) {
      final String id = item.id;

      if (!foundation.kIsWeb) {
        // Desktop → DB local
        await executeQuery.query('DELETE FROM empleoyes WHERE id=?', [id]);
      } else {
        // Web → HTTP DELETE al backend
        final uri = Uri.parse('http://localhost:3000/$selectedDb/empleoyes/$id');
        final res = await http.delete(uri);

        if (res.statusCode != 200) {
          throw Exception('HTTP ${res.statusCode}: ${res.body}');
        }
      }
    }

    print('Empleoyes eliminados: ${idsDelete.length}');
  } catch (e) {
    print('ERROR al eliminar empleoyes: $e');
  }
}