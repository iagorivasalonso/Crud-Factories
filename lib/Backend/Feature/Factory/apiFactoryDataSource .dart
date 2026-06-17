
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
        id: item['id'].toString(),
        name: item['name'] ?? '',
        highDate: item['highDate'] ?? '',
        sector: item['sector'] ?? '',
        thelephones: [item['telephone1'] ?? '',item['telephone2'] ?? ''],
        mail: item['mail'] ?? '',
        web: item['web'] ?? '',
        address: Address(
          street: item['street'] ?? '',
          number: item['number'] ?? '',
          apartment: item['apartment'],
          city: item['city'] ?? '',
          province: item['province'] ?? '',
          postcode: item['postcode'] ?? '',
        ),
      );
    }).toList();
  }

  @override
  Future<void> insert(Factory factory)  async{

    saveToWebStorage(
        'factories', // prefijo
        factory.id,        // id único de la fábrica
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
          'address': {
            'street': factory.address.street,
            'number': factory.address.number,
            'apartment': factory.address.apartment,
            'city':  factory.address.city,
            'province': factory.address.province,
            'postcode': factory.address.postcode,
          },
        },
        config
    );
  }

  @override
  Future<void> upload(Factory factory) async {

    saveToWebStorage(
        'factories', // prefijo
        factory.id,        // id único de la fábrica
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
              'address': {
                  'street': factory.address.street,
                  'number': factory.address.number,
                  'apartment': factory.address.apartment,
                  'city':  factory.address.city,
                  'province': factory.address.province,
                  'postcode': factory.address.postcode,
              },
      },
        config,
        isUpdate: true,
    );
  }


}