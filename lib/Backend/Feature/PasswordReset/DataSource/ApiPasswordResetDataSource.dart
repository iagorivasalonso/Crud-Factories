
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:crud_factories/Backend/connectors_API/ApiConfigUrl.dart';
import 'package:crud_factories/Backend/Feature/Connection/Controller/ConnectionController.dart';

import 'IApiPasswordResetDataSource.dart';

class ApiPasswordResetDataSource implements IApiPasswordResetDataSource {

  final ConnectionController connectionController;

  ApiPasswordResetDataSource({
    required this.connectionController,
  });

  static String get baseUrl => ApiConfigUrl.baseUrl;

  // =========================
  // CONNECTION
  // =========================

  Map<String, dynamic> _connectionBody() {

    final connection = connectionController.provider.selected;

    if (connection == null) {
      throw Exception('Debes seleccionar una conexión');
    }

    return {
      'host': connection.host,
      'port': connection.port,
      'dbUser': connection.user,
      'dbPassword': connection.password,
      'database': connection.database,
    };
  }

  // =========================
  // POST
  // =========================

  Future<Map<String, dynamic>> _post(
      String endpoint,
      Map<String, dynamic> data,
      ) async {

    final url = '$baseUrl$endpoint';

    final body = {
      ..._connectionBody(),
      ...data,
    };

    print('URL API: $url');
    print('INICIANDO PETICIÓN HTTP');

    late http.Response response;

    try {

      response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      ).timeout(const Duration(seconds: 20));

    } on TimeoutException {
      print('TIMEOUT: NODE NO HA RESPONDIDO');
      throw Exception('La API no ha respondido a tiempo');

    } catch (e) {
      print('ERROR HTTP: $e');
      rethrow;
    }

    print('RESPUESTA RECIBIDA');
    print('STATUS: ${response.statusCode}');
    print('BODY: ${response.body}');

    Map<String, dynamic> result = {};

    try {
      final decoded = jsonDecode(response.body);

      if (decoded is Map) {
        result = Map<String, dynamic>.from(decoded);
      }
    } catch (_) {}

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception(
        result['message'] ??
            'Error HTTP ${response.statusCode} en la recuperación',
      );
    }

    if (result['ok'] != true) {
      throw Exception(
        result['message'] ??
            'No se pudo completar la operación',
      );
    }

    return result;
  }
  // =========================
  // REQUEST RESET
  // =========================

  @override
  Future<void> requestReset({
    required String username,
    required String mail,
  }) async {

    await _post('/session/password/request', {
      'username': username,
      'mail': mail,
    });
  }

  // =========================
  // VERIFY RESET
  // =========================

  @override
  Future<bool> verifyReset({
    required String username,
    required String mail,
    required String token,
  }) async {

    final data = await _post('/session/password/verify', {
      'username': username,
      'mail': mail,
      'token': token,
    });

    return data['valid'] == true;
  }

  // =========================
  // RESET PASSWORD
  // =========================

  @override
  Future<void> resetPassword({
    required String username,
    required String mail,
    required String token,
    required String newPassword,
  }) async {

    await _post('/session/password/reset', {
      'username': username,
      'mail': mail,
      'token': token,
      'newPassword': newPassword,
    });
  }


}
