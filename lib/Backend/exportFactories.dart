import 'dart:io';
import 'package:csv/csv.dart';
import '../Objects/Factory.dart';

void csvExportator(List<Factory> factories, int select) async {

  File myFile = File('D:/ite.csv');

  List<dynamic> associateList = [

    for (int i = 0; i <factories.length;i++)
      {

        "id": factories[i].id,
        "name": factories[i].name,
        "highDate": factories[i].highDate,
        "telephone1": factories[i].thelephones[0],
        "telephone2": factories[i].thelephones[1],
        "mail": factories[i].mail,
        "web": factories[i].web,
        "address": factories[i].address,
        "city" : factories[i],
        "contacts" :factories[i].contacts,

      },
  ];



  List<List<dynamic>> rows = [];
  List<dynamic> row = [];


  for (int i = 0; i < associateList.length; i++) {
    List<dynamic> row = [];

    row.add(associateList[i]["id"]);
    row.add(associateList[i]["name"]);
    row.add(associateList[i]["highDate"]);
    row.add(associateList[i]["telephone1"]);
    row.add(associateList[i]["telephone2"]);
    row.add(associateList[i]["mail"]);
    row.add(associateList[i]["web"]);
    row.add(associateList[i]["address"]);
    row.add(associateList[i]["city"]);
    row.add(associateList[i]["postalCode"]);
    row.add(associateList[i]["province"]);
    row.add(associateList[i]["contacts"]);
    rows.add(row);

  }

  String csv = const ListToCsvConverter().convert(rows);
  myFile.writeAsString(csv);

}