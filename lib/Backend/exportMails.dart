import 'dart:io';
import 'package:csv/csv.dart';

import '../Objects/Mail.dart';

void csvExportator(List<Mail> mails, int select) {


  File myFile = File('D:/mails.csv');

  List<dynamic> associateList = [

    for (int i = 0; i <mails.length;i++)
    {

        "id": mails[i].id,
        "company": mails[i].company,
        "addrres": mails[i].addrres,
        "password": mails[i].password
    },
  ];

  List<List<dynamic>> rows = [];
  List<dynamic> row = [];


  for (int i = 0; i < associateList.length; i++) {
    List<dynamic> row = [];

    row.add(associateList[i]["id"]);
    row.add(associateList[i]["company"]);
    row.add(associateList[i]["addrres"]);
    row.add(associateList[i]["password"]);
    rows.add(row);
  }

  String csv = const ListToCsvConverter().convert(rows);
  print(csv);
  myFile.writeAsString(csv);
}