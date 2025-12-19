import 'dart:developer';

import 'package:crud_factories/Backend/Global/files.dart';
import 'package:crud_factories/Objects/Sector.dart';
import 'package:csv/csv.dart';
import 'package:flutter/foundation.dart';

import 'export/export.dart';
import 'export/export_web.dart';

Future<bool> csvExportatorSectors(List<Sector> sectors) async {

  bool err = false;

  List<dynamic> associateList = [

      for (int i = 0; i < sectors.length; i++)
      {
        "id": sectors[i].id,
        "name": sectors[i].name,
      },
  ];

  List<List<dynamic>> rows = [];

  for (int i = 0; i < associateList.length; i++)
  {
      List<dynamic> row = [];

      row.add(associateList[i]["id"]);
      row.add(associateList[i]["name"]);
      rows.add(row);
  }

  String csv = const ListToCsvConverter(fieldDelimiter: ';').convert(rows);


  if (kIsWeb) {
    err =  await csvExportweb(csv, fileName: fSectors.path);
  } else {
    err = !await csvExport(csv,file: fSectors);
  }



  return err;
}


