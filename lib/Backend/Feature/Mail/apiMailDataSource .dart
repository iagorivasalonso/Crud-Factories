
import 'dart:convert';

import 'package:crud_factories/Backend/Feature/Mail/IMailDataSource.dart';
import 'package:crud_factories/Backend/SQL/Export_general/saveToWebStorage_web.dart' show saveToWebStorage;
import 'package:crud_factories/Backend/connectors_API/connectApi.dart';
import 'package:crud_factories/Objects/ApiConfig.dart';
import 'package:crud_factories/Objects/Mail.dart';
import 'package:http/http.dart' as http;

class apiMailDataSource implements IMailDataSource {

  final ApiConfig config;

  apiMailDataSource({required this.config});

  @override
  Future<void> delete(String id) async {

    final data = await connectApi('mails/$id', config);

    final res = await http.delete(data);

    if (res.statusCode != 200) {
      throw Exception('HTTP ${res.statusCode}: ${res.body}');
    }
  }


  @override
  Future<List<Mail>> load() async{

    final uri = await connectApi('mails', config);

    final res = await http.get(uri);

    if (res.statusCode != 200) {
      throw Exception('HTTP ${res.statusCode}: ${res.body}');
    }

    final List data = jsonDecode(res.body);

      return data.map((item){
         return Mail(
           id: item['id'].toString(),
           mail: item['mail'],
           host: item['host'],
           port: item['port'],
           secure: item['secure'],
           password: item['password'],
         );
      }).toList();

  }


  @override
  Future<void> insert(Mail m) async {

    saveToWebStorage(
        'mail', // prefijo
         m.id,        // id único de la fábrica
        {
          'id': m.id,
          'mail': m.mail,
          'host': m.host,
          'port': m.port,
          'secure': m.secure,
          'password': m.password
        },
        config
    );
  }

  Future<void> upload(Mail m) async{

    saveToWebStorage(
        'mail', // prefijo
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
        isUpdate: true
    );
  }
}