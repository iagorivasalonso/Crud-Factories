import 'dart:convert';

import 'package:crud_factories/Backend/Feature/User/IUserDataSource.dart';
import 'package:crud_factories/Backend/connectors_API/connectApi.dart' show connectApi;
import 'package:crud_factories/Objects/User.dart';
import 'package:http/http.dart' as http;

import '../../../Objects/ApiConfig.dart';

class ApiUserDataSource  implements IUserDataSource{


  final ApiConfig config;

  ApiUserDataSource({
    required this.config,
  });


  @override
  Future<User> create({required User user, required String passwordHash}) async {

    final uri = await connectApi(
      'users',
      config,
    );

    final res = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'username': user.username,
        'mail': user.mail,
        'password_hash': passwordHash,
        'role': user.role,
        'active': user.active,
      }),
    );

    if (res.statusCode != 200) {
      throw Exception('HTTP ${res.statusCode}: ${res.body}');
    }

    final data = jsonDecode(res.body);

    return User.fromMap(data);
  }

  @override
  Future<void> delete(String id) async {

    final uri = await connectApi(
      'users/$id',
      config,
    );

    final res = await http.delete(uri);

    if (res.statusCode != 200) {
      throw Exception('HTTP ${res.statusCode}: ${res.body}');
    }
  }


  @override
  Future<List<User>> load() async {

    final uri = await connectApi(
      'users',
      config,
    );

    final res = await http.get(uri);

    if (res.statusCode != 200) {
      throw Exception('HTTP ${res.statusCode}: ${res.body}');
    }

    final List data = jsonDecode(res.body);

    return data.map((item) {
      return User(
        id: item['id']?.toString() ?? '',
        username: item['username']?.toString() ?? '',
        mail: item['mail']?.toString(),
        role: item['role']?.toString() ?? 'user',
        active: item['active'] == true || item['active'] == 1,
      );
    }).toList();
  }

  @override
  Future<User> upload(User user, String passwordHash) async {

    final uri = await connectApi(
      'users/${user.id}',
      config,
    );

    print('URL: $uri');

    final body = <String, dynamic>{
      'username': user.username,
      'mail': user.mail,
      'role': user.role,
      'active': user.active,
    };

    if (passwordHash.isNotEmpty) {
      body['password_hash'] = passwordHash;
    }

    final res = await http.put(
      uri,
      body: jsonEncode(body),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (res.statusCode != 200) {
      throw Exception('HTTP ${res.statusCode}: ${res.body}');
    }

    return user;
  }

  @override
  Future<User?> findByUsernameAndMail(
      String username, [
        String? mail
      ]) async {
    final uri = await connectApi(
      'users',
      config,
    );

    final res = await http.get(uri);

    if (res.statusCode != 200) {
      throw Exception('HTTP ${res.statusCode}: ${res.body}');
    }

    final List data = jsonDecode(res.body);
    print('========== USERS API ==========');
    print('Usuarios recibidos: ${data.length}');
    print(data);
    for (final item in data) {
      final itemUsername = item['username']?.toString() ?? '';
      final itemMail = item['mail']?.toString() ?? '';

      if (itemUsername.toLowerCase() == username.toLowerCase() &&
          itemMail.toLowerCase() == mail?.toLowerCase()) {
        return User(
          id: item['id']?.toString() ?? '',
          username: itemUsername,
          mail: itemMail,
          role: item['role']?.toString() ?? 'user',
          active: item['active'] == true || item['active'] == 1,
        );
      }
    }

    return null;
  }

}