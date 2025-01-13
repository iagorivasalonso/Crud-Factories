

import 'package:crud_factories/Backend/data.dart';
import 'package:crud_factories/Objects/RouteCSV.dart';
import 'package:csv/csv.dart';

void csvExportatorRoutes(List<RouteCSV> routes){

  List<dynamic> associateList = [
    for (int i = 0; i < routes.length; i++)
      {
        "id": routes[i].id,
        "name": routes[i].name,
        "route": routes[i].route
      },
  ];

  List<List<dynamic>> rows = [];

  for (int i = 0; i < associateList.length; i++) {

    List<dynamic> row = [];

    row.add(associateList[i]["id"]);
    row.add(associateList[i]["name"]);
    row.add(associateList[i]["route"]);
    rows.add(row);
  }

  String csv = const ListToCsvConverter(fieldDelimiter: ';').convert(rows);
  fRoutes.writeAsString(csv);
}
