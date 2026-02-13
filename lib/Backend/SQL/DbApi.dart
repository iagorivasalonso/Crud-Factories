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


  static Future<Map<String, dynamic>> actionApi(String action, Conection? connection, [Conection? newDataBase]) async {

    if (connection == null) {
      return {'ok': false, 'message': 'Debes seleccionar una conexión'};
    }

    try {
      final body = {
        'action': action,
        'host': connection.host,
        'port': connection.port,
        'user': connection.user,
        'password': connection.password,
        'database': connection.database,
        if (action == 'update' && newDataBase != null) 'newDatabase': newDataBase.database,
      };

      final res = await http.post(
        Uri.parse('$baseUrl/db'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      final data = jsonDecode(res.body);
      if (data['ok'] == true) {
        return {'ok': true, 'message': data['message']};
      } else {
        return {'ok': false, 'message': data['message'] ?? 'Error desconocido'};
      }

    } catch (e) {
      return {'ok': false, 'message': 'Error de conexión: $e'};
    }
  }
}

