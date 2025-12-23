import 'package:flutter/foundation.dart' as foundation;
import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Objects/Factory.dart';
import 'package:http/http.dart' as http;

Future<void> sqlDeleteFactory(String id) async {


  try {


      if (!foundation.kIsWeb) {
        await executeQuery.query('DELETE FROM factories WHERE id=?', [id]);
      } else {
        final uri = Uri.parse('http://localhost:3000/$selectedDb/factories/$id');
        final res = await http.delete(uri);

        if (res.statusCode != 200) {
          throw Exception('HTTP ${res.statusCode}: ${res.body}');
        }

    }

    print('Factories eliminadas: ${id}');
  } catch (e) {
    print('ERROR al eliminar factories: $e');
  }
}
