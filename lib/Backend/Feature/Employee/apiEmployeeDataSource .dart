
import 'dart:convert';

import 'package:crud_factories/Backend/Feature/Factory/IFactoryDataSource.dart' show IfactorydataSource;
import 'package:crud_factories/Backend/SQL/Export_general/saveToWebStorage_web.dart' show saveToWebStorage;
import 'package:crud_factories/Backend/connectors_API/connectApi.dart' show connectApi;
import 'package:crud_factories/Objects/ApiConfig.dart' show ApiConfig;
import 'package:crud_factories/Objects/Empleoye.dart';
import 'package:crud_factories/Objects/Factory.dart';
import 'package:http/http.dart' as http;

import 'IEmployeeDataSource.dart';

class ApiEmployeeDataSource implements IEmployeeDataSource {

  final ApiConfig config;

  ApiEmployeeDataSource({required this.config});

  @override
  Future<void> delete(String id) async {

    final data = await connectApi('employees/$id',config);

    final res = await http.delete(data);

    if (res.statusCode != 200) {
      throw Exception('HTTP ${res.statusCode}: ${res.body}');
    }
  }

  @override
  Future<List<Empleoyee>> load() async {

    final uri  = await connectApi('employees',config);

    final res = await http.get(uri);

    if (res.statusCode != 200) {
      throw Exception('HTTP ${res.statusCode}: ${res.body}');
    }

    final List data = jsonDecode(res.body);

    return data.map((item) {
      return Empleoyee(
        id: item['id'].toString(),
        name: item['name'] ?? '',
       idFactory: item['idFactory']
      );
    }).toList();
  }

  @override
  Future<void> insert(Empleoyee employee)  async{

    saveToWebStorage(
        'employees', // prefijo
        employee.id,        // id único de la fábrica
        {
          'id': employee.id,
          'name': employee.name,
          'idFactory': employee.idFactory,
        },
        config
    );

  }
//esto solo se usa en CSV
  @override
  Future<void> upload(Empleoyee empleoyee) {
    // TODO: implement upload
    throw UnimplementedError();
  }

  @override
  Future<void> deleteByFactory(String factoryId) {
    // TODO: implement deleteByFactory
    throw UnimplementedError();
  }
}