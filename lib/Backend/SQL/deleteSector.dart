import 'package:flutter/foundation.dart' as foundation;
import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Objects/Sector.dart';
import 'package:http/http.dart' as http;

import '../connectors_API/connectApi.dart';

Future<void> sqlDeleteSector(String id) async {


  try {


      if (!foundation.kIsWeb) {
        await executeQuery.query('DELETE FROM sectors WHERE id=?', [id]);
      } else {

        final String route = 'sectors/$id';
        final uri = await connectApi(route);

        final res = await http.delete(uri);

        if (res.statusCode != 200) {
          throw Exception('HTTP ${res.statusCode}: ${res.body}');
        }

    }

    print('Sectores eliminados: ${id}');
  } catch (e) {
    print('ERROR al eliminar sectores: $e');
  }
}
