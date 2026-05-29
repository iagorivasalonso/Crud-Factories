import 'dart:convert';

import 'package:crud_factories/Backend/Feature/Sector/IsectorDataSource.dart' show ISectorDataSource;
import 'package:crud_factories/Backend/SQL/Export_general/saveToWebStorage_web.dart' show saveToWebStorage;
import 'package:crud_factories/Objects/Sector.dart' show Sector;
import 'package:http/http.dart' as http;
import 'package:crud_factories/Backend/connectors_API/connectApi.dart';

class ApiSectorDataSource implements ISectorDataSource{


  final ApiConfig config;

  ApiSectorDataSource({required this.config});

  @override
  Future<void> delete(String id) async {

    final data = await connectApi('sectors/$id',config);

    final res = await http.delete(data);

    if (res.statusCode != 200) {
      throw Exception('HTTP ${res.statusCode}: ${res.body}');
    }
  }

  @override
  Future<List<Sector>> load() async {
    final uri = await connectApi('sectors', config);

    final res = await http.get(uri);

    if (res.statusCode != 200) {
      throw Exception('HTTP ${res.statusCode}: ${res.body}');
    }

    final List data = jsonDecode(res.body);

    return data.map((item) {
      return Sector(
        id: item['id'],
        name: item['sector'],
      );
    }).toList();
  }

  @override
  Future<void> insert(Sector sector) async {

      await saveToWebStorage(
        'sectors',
        sector.id,
        {
          'id': sector.id,
          'sector': sector.name,
        },
        config,
      );

  }

  @override
  Future<void> upload(Sector sector) async  {

    await saveToWebStorage(
    'sectors',
    sector.id,
    {
      'id': sector.id,
      'sector': sector.name,
    },
    config,
    );
  }




/*
  Future<void> saveAll(List<Sector> sectors) async {


  }

  Future<void> delete(String id) async {

  }

  Future<void> updateAll(List<Sector> sectors) async {



    for (final sector in sectors) {
      final uri = await connectApi('sectors/${sector.id}',config);

      final res = await http.put(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'sector': sector.name}),
      );

      if (res.statusCode != 200) {
        throw Exception('HTTP ${res.statusCode}: ${res.body}');
      }
    }
  }*/
}

class ApiConfig {
  final String host;
  final int port;
  final String database;
  final String user;
  final String password;

  ApiConfig({
    required this.host,
    required this.port,
    required this.database,
    required this.user,
    required this.password,
  });
}