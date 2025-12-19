import 'package:crud_factories/Backend/Global/files.dart';
import 'package:crud_factories/Objects/Factory.dart';
import 'package:csv/csv.dart';
import 'package:flutter/foundation.dart' hide Factory;

import 'export/export.dart';
import 'export/export_web.dart';

Future<bool> csvExportatorFactories(List<Factory> factories) async {

  bool err = false;

  List<dynamic> associateList = [

      for (int i = 0; i <factories.length;i++)
      {
        "id": factories[i].id,
        "name": factories[i].name,
        "highDate": factories[i].highDate,
        "sector": factories[i].sector,
        "telephone1": factories[i].thelephones[0],
        "telephone2": factories[i].thelephones[1],
        "mail": factories[i].mail,
        "web": factories[i].web,
        "address": factories[i].address['street'],
        "number": factories[i].address['number'],
        "apartament": factories[i].address['apartament'],
        "city" : factories[i].address['city'],
        "postalCode": factories[i].address['postalCode'],
        "province" : factories[i].address['province'],
      },
  ];

  List<List<dynamic>> rows = [];

  for (int i = 0; i < associateList.length; i++)
  {
      List<dynamic> row = [];

      row.add(associateList[i]["id"]);
      row.add(associateList[i]["name"]);
      row.add(associateList[i]["highDate"]);
      row.add(associateList[i]["sector"]);
      row.add(associateList[i]["telephone1"]);
      row.add(associateList[i]["telephone2"]);
      row.add(associateList[i]["mail"]);
      row.add(associateList[i]["web"]);
      row.add(associateList[i]["address"]);
      row.add(associateList[i]["number"]);
      row.add(associateList[i]["apartament"]);
      row.add(associateList[i]["city"]);
      row.add(associateList[i]["postalCode"]);
      row.add(associateList[i]["province"]);
      rows.add(row);
  }

  String csv = const ListToCsvConverter(fieldDelimiter: ';').convert(rows);

  if (kIsWeb) {
    err =  await csvExportweb(csv, fileName: fFactories.path);
  } else {
    err = !await csvExport(csv,file: fFactories);
  }

  return err;
}