import 'package:crud_factories/Objects/Conection.dart';
import 'package:crud_factories/Objects/Conection.dart';
import 'dart:convert';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:http/http.dart' as http show post;
import '../../Alertdialogs/confirm.dart';
import '../../Alertdialogs/error.dart';
import '../../generated/l10n.dart';



class DbApi {
  static const baseUrl = 'http://localhost:3000';


  static Future<void> actionApi(BuildContext context, String action, Conection? connection) async {

    if (connection == null) {
      error(context, S.of(context).You_must_select_a_connection);
      return;
    }

    try {
      final body = {
        'action': action,
        'host': connection.host,
        'port': connection.port,
        'user': connection.user,
        'password': connection.password,
        'database': connection.database,
      };

      final res = await http.post(
        Uri.parse('$baseUrl/db'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );
print(res.body);
      final data = jsonDecode(res.body);
      if (res.statusCode != 200) {
        throw data['error'];
      }

      confirm(context, data['message']);
    } catch (e) {
      error(context, e.toString());
    }
  }
}

