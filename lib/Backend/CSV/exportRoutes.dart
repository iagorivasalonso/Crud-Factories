import 'dart:io';
import 'package:crud_factories/Backend/Global/files.dart';
import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Objects/RouteCSV.dart';
import 'package:csv/csv.dart';

import 'exportatorList.dart';

Future<bool> csvExportatorRoutes(List<RouteCSV> routes) async {

  bool err = false;

  List<dynamic> associateList = [

      for (int i = 0; i < routes.length; i++)
      {
        "id": routes[i].id,
        "name": routes[i].name,
        "route": routes[i].route
      },
  ];

  List<List<dynamic>> rows = [];

  for (int i = 0; i < associateList.length; i++)
  {
    List<dynamic> row = [];

    row.add(associateList[i]["id"]);
    row.add(associateList[i]["name"]);
    row.add(associateList[i]["route"]);
    rows.add(row);
  }
  final filePath = fRoutes;
  routeFirst = filePath.path;

  String csv = const ListToCsvConverter(fieldDelimiter: ';').convert(rows);
  err = await csvExport(filePath,csv);


  return err;
}
