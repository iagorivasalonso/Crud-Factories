
import 'dart:convert';

import 'package:crud_factories/Backend/Feature/Factory/IFactoryDataSource.dart' show IfactorydataSource, IFactoryDataSource;
import 'package:crud_factories/Backend/SQL/Export_general/saveToWebStorage_web.dart' show saveToWebStorage;
import 'package:crud_factories/Backend/connectors_API/connectApi.dart' show connectApi;
import 'package:crud_factories/Objects/ApiConfig.dart' show ApiConfig;
import 'package:crud_factories/Objects/Factory.dart';
import 'package:http/http.dart' as http;

class apiFactoryDataSource implements IFactoryDataSource {

  final ApiConfig config;

  apiFactoryDataSource({required this.config});

  @override
  Future<void> delete(String id) async {

    final data = await connectApi('factories/$id',config);

    final res = await http.delete(data);

    if (res.statusCode != 200) {
      throw Exception('HTTP ${res.statusCode}: ${res.body}');
    }
  }

  @override
  Future<List<Factory>> load() async {

    final uri = await connectApi('factories', config);

    final res = await http.get(uri);

    if (res.statusCode != 200) {
      throw Exception('HTTP ${res.statusCode}: ${res.body}');
    }

    final List data = jsonDecode(res.body);

    return data.map((item) {
      return Factory(
        id: item['id']?.toString() ?? '',
        name: item['name']?.toString() ?? '',
        highDate: item['highDate']?.toString() ?? '',
        sector: item['sector']?.toString() ?? '',
        thelephones: [item['telephone1']?.toString() ?? '',item['telephone2']?.toString() ?? ''],
        mail: item['mail']?.toString() ?? '',
        web: item['web']?.toString() ?? '',
        address: Address(
          street: item['address']?.toString() ?? '',
          number: item['number']?.toString() ?? '',
          apartment: item['apartment']?.toString() ?? '',
          city: item['city']?.toString() ?? '',
          province: item['province']?.toString() ?? '',
          postcode: item['postcode']?.toString() ?? '',
        ),
      );
    }).toList();
  }

  @override
  Future<void> insert(Factory f)  async{

    saveToWebStorage(
        'factories', // prefijo
        f.id,        // id único de la fábrica
        {
          'id': f.id,
          'name': f.name,
          'highDate': f.highDate,
          'sector': f.sector,
          'telephone1': f.thelephones.isNotEmpty
              ? f.thelephones[0]
              : '',
          'telephone2': f.thelephones.length > 1
              ? f.thelephones[1]
              : '',
          'mail': f.mail,
          'web': f.web,
          'address': {
            'address': f.address.street,
            'number': f.address.number,
            'apartment': f.address.apartment,
            'city':  f.address.city,
            'province': f.address.province,
            'postcode': f.address.postcode,
          },
        },
        config
    );
  }

  @override
  Future<void> upload(Factory f) async {

    saveToWebStorage(
        'factories', // prefijo
        f.id,        // id único de la fábrica
         {
              'id': f.id,
              'name': f.name,
              'highDate': f.highDate,
              'sector': f.sector,
              'telephone1': f.thelephones.isNotEmpty
                  ? f.thelephones[0]
                  : '',
              'telephone2': f.thelephones.length > 1
                  ? f.thelephones[1]
                  : '',
              'mail': f.mail,
              'web': f.web,
              'address': {
                  'address': f.address.street,
                  'number': f.address.number,
                  'apartment': f.address.apartment,
                  'city':  f.address.city,
                  'province': f.address.province,
                  'postcode': f.address.postcode,
              },
      },
        config,
        isUpdate: true,
    );
  }

  @override
  Future<void> save(List<Factory> factories) async {
    for (final factory in factories) {
      await saveToWebStorage(
        'factories',
        factory.id,
        {
          'id': factory.id,
          'name': factory.name,
          'highDate': factory.highDate,
          'sector': factory.sector,
          'telephone1': factory.thelephones.isNotEmpty
              ? factory.thelephones[0]
              : '',
          'telephone2': factory.thelephones.length > 1
              ? factory.thelephones[1]
              : '',
          'mail': factory.mail,
          'web': factory.web,
          'address': factory.address.street,
          'number': factory.address.number,
          'apartment': factory.address.apartment,
          'city': factory.address.city,
          'province': factory.address.province,
          'postcode': factory.address.postcode,
        },
        config,
      );
    }
  }


}
