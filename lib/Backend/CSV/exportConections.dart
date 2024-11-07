import 'dart:io';
import 'package:crud_factories/Objects/Conection.dart';
import 'package:csv/csv.dart';

void csvExportatorConections(List<Conection> conections) {


  File myFile = File('D:/conections.csv');

  List<dynamic> associateList = [

    for(int i = 0; i < conections.length; i++ )
    {
      "id": conections[i].id,
       "database": conections[i].database,
       "host": conections[i].host,
       "port": conections[i].port,
       "user":conections[i].user,
       "password":conections[i].password,
    }
  ];

  List<List<dynamic>> rows = [];

  for (int i = 0; i < associateList.length; i++) {

    List<dynamic> row = [];

    row.add(associateList[i]["id"]);
    row.add(associateList[i]["database"]);
    row.add(associateList[i]["host"]);
    row.add(associateList[i]["port"]);
    row.add(associateList[i]["user"]);
    row.add(associateList[i]["password"]);
    rows.add(row);
  }

  String csv = const ListToCsvConverter(fieldDelimiter: ';').convert(rows);
  myFile.writeAsString(csv);
}
