import 'dart:io';
import 'package:csv/csv.dart';
import '../Objects/lineSend.dart';

void   csvExportator(List<lineSend> listSend) async {

  File myFile = File('D:/lineSends.csv');

  List<dynamic> associateList = [

    for (int i = 0; i <listSend.length;i++)
      {

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
    row.add(associateList[i]["date"]);
    row.add(associateList[i]["factory"]);
    row.add(associateList[i]["observations"]);
    row.add(associateList[i]["state"]);
    rows.add(row);

  }

  String csv = const ListToCsvConverter().convert(rows);
  myFile.writeAsString(csv);


}