import 'dart:convert';

import 'package:crud_factories/Backend/Feature/LineSend/ILineSendDataSource.dart';
import 'package:crud_factories/Backend/SQL/Export_general/saveToWebStorage_web.dart';
import 'package:crud_factories/Backend/connectors_API/connectApi.dart' show connectApi;
import 'package:crud_factories/Objects/ApiConfig.dart';
import 'package:crud_factories/Objects/LineSend.dart';
import 'package:http/http.dart' as http;


class apiLinesendDatasource implements ILineSendDatasource{

 final ApiConfig config;

 apiLinesendDatasource({required this.config});

  @override
  Future<void> delete(List<LineSend> l) async {

   for(final line in l) {

      final data = await connectApi('linesends/${line.id}', config);

      final res = await http.delete(data);

      if (res.statusCode != 200) {
        throw Exception('HTTP ${res.statusCode}: ${res.body}');
      }
   }
  }

 @override
 Future<List<LineSend>> load() async {

   final uri = await connectApi('lineSends', config);

   final res = await http.get(uri);

   if (res.statusCode != 200) {
     throw Exception('HTTP ${res.statusCode}: ${res.body}');
   }

   final List data = jsonDecode(res.body);

   return data.map((item){
       return LineSend(
         id: item['id'].toString(),
         date: item['date'],
         factory: item['factory'],
         observations: item['observations'],
         state: item['state'],
       );
   }).toList();


 }

  @override
  Future<void> insert(List<LineSend> l) async {

    for(final line in l) {

      saveToWebStorage(
          'lineSends', // prefijo
          line.id,        // id único de la fábrica
          {
            'id': line.id,
            'date': line.date,
            'factory': line.factory,
            'observations': line.observations,
            'state': line.state
          },
          config,
      );
    }

  }


  @override
  Future<bool> upload(List<LineSend> l) async {

          if(l.isEmpty)
                return false;

          for(final line in l) {

            saveToWebStorage(
                 'lineSends', // prefijo
                  line.id,        // id único de la fábrica
                  {
                    'id': line.id,
                    'date': line.date,
                    'factory': line.factory,
                    'observations': line.observations,
                    'state': line.state
                  },
                  config,
                 isUpdate: true
            );
          }
          return true;
    }

  }
