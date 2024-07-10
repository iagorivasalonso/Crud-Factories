import 'dart:io';
import 'package:crud_factories/Objects/LineSend.dart';
import 'package:csv/csv.dart';


void  csvExportatorLines(List<LineSend> listSend) async {

  File myFile = File('D:/lineSends.csv');

  List<dynamic> associateList = [

    for (int i = 0; i <listSend.length;i++)
    {
        "id": listSend[i].id,
        "date": listSend[i].date,
        "factory": listSend[i].factory,
        "observations": listSend[i].observations,
        "state": listSend[i].state
    },
  ];

  List<List<dynamic>> rows = [];
  List<dynamic> row = [];


  for (int i = 0; i < associateList.length; i++) {
    List<dynamic> row = [];
    row.add(associateList[i]["id"]);
    row.add(associateList[i]["date"]);
    row.add(associateList[i]["factory"]);
    row.add(associateList[i]["observations"]);
    row.add(associateList[i]["state"]);
    rows.add(row);
  }

  String csv = const ListToCsvConverter().convert(rows);
  myFile.writeAsString(csv);

}