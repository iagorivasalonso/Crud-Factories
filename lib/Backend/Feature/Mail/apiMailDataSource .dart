
import 'dart:convert';

import 'package:crud_factories/Backend/Feature/Mail/IMailDataSource.dart';
import 'package:crud_factories/Backend/SQL/Export_general/saveToWebStorage_web.dart' show saveToWebStorage;
import 'package:crud_factories/Backend/connectors_API/connectApi.dart';
import 'package:crud_factories/Objects/ApiConfig.dart';
import 'package:crud_factories/Objects/Mail.dart';
import 'package:http/http.dart' as http;

class apiMailDataSource implements IMailDataSource {

  final ApiConfig config;
  final String userId;

  apiMailDataSource({required this.config, required this.userId});

  @override
  Future<void> delete(String id) async {

    final data = await connectApi('mails/$id', config, userId: userId);

    final res = await http.delete(data);

    if (res.statusCode != 200) {
      throw Exception('HTTP ${res.statusCode}: ${res.body}');
    }
  }


  @override
  Future<List<Mail>> load() async{

    final uri = await connectApi('mails', config, userId: userId);

    final res = await http.get(uri);

    if (res.statusCode != 200) {
      throw Exception('HTTP ${res.statusCode}: ${res.body}');
    }

    final List data = jsonDecode(res.body);

      return data.map((item){
         return Mail(
           id: item['id']?.toString() ?? '',
           mail: item['mail']?.toString() ?? '',
           host: item['host']?.toString() ?? '',
           port: item['port']?.toString() ?? '',
           secure: item['secure'] == true || item['secure'] == 1,
           password: item['password']?.toString() ?? '',
         );
      }).toList();

  }

  @override
  Future<List<Mail>> loadSystemMails() async {   // van todos los mails de la bd que sean admin sin id

    final uri = await connectApi('mails/system', config);

    final res = await http.get(uri);

    if (res.statusCode != 200) {
      throw Exception('HTTP ${res.statusCode}: ${res.body}');
    }

    final List data = jsonDecode(res.body);

    return data.map((item){
      return Mail(
        id: item['id']?.toString() ?? '',
        mail: item['mail']?.toString() ?? '',
        host: item['host']?.toString() ?? '',
        port: item['port']?.toString() ?? '',
        secure: item['secure'] == true || item['secure'] == 1,
        password: item['password']?.toString() ?? '',
      );
    }).toList();

  }


  @override
  Future<void> insert(Mail m) async {

    saveToWebStorage(
        'mails', // prefijo
         m.id,        // id único de la fábrica
        {
          'id': m.id,
          'mail': m.mail,
          'host': m.host,
          'port': m.port,
          'secure': m.secure,
          'password': m.password
        },
        config,
        userId: userId,
    );
  }

  Future<void> upload(Mail m) async{

    saveToWebStorage(
        'mails', // prefijo
         m.id,        // id único de la fábrica
          {
            'id': m.id,
            'mail': m.mail,
            'host': m.host,
            'port': m.port,
            'secure': m.secure,
            'password': m.password
          },
        config,
        userId: userId,
        isUpdate: true
    );
  }

  @override
  Future<void> save(List<Mail> mails) async {

    for (final mail in mails) {
      await saveToWebStorage(
        'mails', // prefijo
        mail.id,        // id único de la fábrica
        {
          'id': mail.id,
          'mail': mail.mail,
          'host': mail.host,
          'port': mail.port,
          'secure': mail.secure,
          'password': mail.password
        },
        config,
        userId: userId,
      );
    }

  }
}
