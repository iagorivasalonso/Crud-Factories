import 'dart:convert';

import 'package:crud_factories/Backend/Feature/Connection/Controller/ConnectionController.dart';
import 'package:crud_factories/Backend/Feature/Session/ISessionService.dart';
import 'package:crud_factories/Objects/AppSession.dart' show AppSession;
import 'package:crud_factories/Objects/User.dart' show User;
import 'package:http/http.dart' as http;

class ApiSessionService implements ISessionservice{


  final ConnectionController connectionController;

  ApiSessionService({
    required this.connectionController,
  });


  late final config = connectionController.provider.config;

  static const String baseUrl = 'http://localhost:3000';

  @override
  Future<SessionResult> login(String username, String password) async {

    final res = await http.post(
      Uri.parse('$baseUrl/session/login'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'username': username,
        'password': password,
        'host': config.host,
        'port': config.port,
        'dbUser': config.user,
        'dbPassword': config.password,
        'database': config.database,
      }),
    );

    final data = jsonDecode(res.body);


    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw Exception(
        data['message'] ?? 'Error al iniciar sesión',
      );
    }

    if (data['ok'] != true) {
      throw Exception(
        data['message'] ?? 'Login incorrecto',
      );
    }

    return SessionResult(
      user: User.fromMap(data['user']),
      session: AppSession.fromMap(data['session']),
    );
  }

  @override
  Future<void> logout(String sessionId) async {

    final res = await http.post(
      Uri.parse('$baseUrl/session/logout'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'sessionId': sessionId,

        'host': config.host,
        'port': config.port,
        'dbUser': config.user,
        'dbPassword': config.password,
        'database': config.database,
      }),
    );

    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw Exception(
        'Error al cerrar sesión: ${res.body}',
      );
    }

    final data = jsonDecode(res.body);

    if (data['ok'] != true) {
      throw Exception(
        data['message'] ?? 'Error al cerrar sesión',
      );
    }
  }

  @override
  Future<SessionResult?> restoreSession(String sessionId) async {

    final res = await http.post(
      Uri.parse('$baseUrl/session/restore'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'sessionId': sessionId,

        'host': config.host,
        'port': config.port,
        'dbUser': config.user,
        'dbPassword': config.password,
        'database': config.database,
      }),
    );

    if (res.statusCode == 404) {
      return null;
    }

    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw Exception(
        'Error al restaurar sesión: ${res.body}',
      );
    }

    final data = jsonDecode(res.body);

    if (data['ok'] != true) {
      return null;
    }

    return SessionResult(
      user: User.fromMap(data['user']),
      session: AppSession.fromMap(data['session']),
    );
  }
}