import 'package:crud_factories/Objects/Conection.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DbApi {
  static const baseUrl = 'http://localhost:3000/db';

  static Future<Map<String, dynamic>> actionApi(
      String action, Conection? connection, [Conection? newDataBase]) async {
    if (connection == null && action != 'disconnect') {
      return {'ok': false, 'message': 'Debes seleccionar una conexión'};
    }

    try {
      final body = {
        'action': action,
      };

      if (connection != null) {
        body.addAll({
          'host': connection.host,
          'port': connection.port,
          'user': connection.user,
          'password': connection.password,
          'database': connection.database,
        });

        if (newDataBase != null) {
          body['newDatabase'] = newDataBase.database;
        }
      }

      final res = await http.post(
        Uri.parse('$baseUrl/db'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      final data = jsonDecode(res.body);

      if (data is! Map<String, dynamic>) {
        return {
          'ok': false,
          'message': 'Respuesta inválida del servidor: ${res.body}',
        };
      }



      String message;

// Caso normal: data['message'] existe
      if (data['message'] != null && data['message'] is String) {
        message = data['message'];
      }
// Caso error: puede ser Map o String
      else if (data['error'] != null) {
        if (data['error'] is Map && data['error']['message'] is String) {
          message = data['error']['message'];
        } else if (data['error'] is String) {
          message = data['error'];
        } else {
          message = 'Error desconocido';
        }
      } else {
        message = 'Error desconocido';
      }


      return {'ok': data['ok'] ?? false, 'message': message};

    } catch (e, stackTrace) {
      print('ERROR EN DbApi.actionApi: $e');
      print(stackTrace);

      return {
        'ok': false,
        'message': 'Error de conexión: $e'
      };
    }
  }

  static Future<Map<String, dynamic>> queryData(
      String sql,
      List<Object?>? params,
      ) async {

    final body = {
      'sql': sql,
      'params': params ?? [],
    };

    final res = await http.post(
      Uri.parse('$baseUrl/query'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    return jsonDecode(res.body);
  }
}