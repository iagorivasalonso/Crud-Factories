import 'dart:io';
import 'package:crud_factories/Objects/Mail.dart';
import 'package:csv/csv.dart';


void csvExportatorMails(List<Mail> mails) {

  File myFile = File('D:/mails.csv');

  List<dynamic> associateList = [
    for (int i = 0; i <mails.length; i++)
    {
        "id": mails[i].id,
        "addrres": mails[i].addrres,
        "company": mails[i].company,
        "password": mails[i].password
    },
  ];

  List<List<dynamic>> rows = [];

  for (int i = 0; i < associateList.length; i++) {

    List<dynamic> row = [];

    row.add(associateList[i]["id"]);
    row.add(associateList[i]["addrres"]);
    row.add(associateList[i]["company"]);
    row.add(associateList[i]["password"]);
    rows.add(row);
  }

  String csv = const ListToCsvConverter(fieldDelimiter: ';').convert(rows);
  myFile.writeAsString(csv);
}