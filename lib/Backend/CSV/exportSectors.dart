
import 'dart:io';
import 'package:crud_factories/Objects/Sector.dart';
import 'package:csv/csv.dart';

void csvExportatorSectors(List<Sector> sectors){

  File myFile = File('D:/sectors.csv');

  List<dynamic> associateList = [
      for (int i = 0; i < sectors.length; i++)
      {
        "id": sectors[i].id,
        "name": sectors[i].name,
      },
  ];

  List<List<dynamic>> rows = [];

  for (int i = 0; i < associateList.length; i++) {

    List<dynamic> row = [];

    row.add(associateList[i]["id"]);
    row.add(associateList[i]["name"]);
    rows.add(row);
  }

  String csv = const ListToCsvConverter(fieldDelimiter: ';').convert(rows);
  myFile.writeAsString(csv);
}


