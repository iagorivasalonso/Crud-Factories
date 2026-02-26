import 'package:flutter/foundation.dart' as foundation;
import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Objects/Mail.dart';
import 'package:http/http.dart' as http;

import '../connectors_API/connectApi.dart';

Future<void> sqlDeleteMail(String id) async {


  try {

      if (!foundation.kIsWeb) {
        await executeQuery.query('DELETE FROM mails WHERE id=?', [id]);
      } else {
        final String route = 'mails/$id';
        final uri = await connectApi(route);
        final res = await http.delete(uri);

        if (res.statusCode != 200) {
          throw Exception('HTTP ${res.statusCode}: ${res.body}');
        }
    }

    print('Mails eliminados: ${id}');
  } catch (e) {
    print('ERROR al eliminar mails: $e');
  }
}
