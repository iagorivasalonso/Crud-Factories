import 'package:csv/csv.dart';

import '../../Objects/RouteCSV.dart';
import '../Global/files.dart';
import 'Export_general/export_csv.dart';



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
  final filePath = fRoutes.toString();


  String csv = const ListToCsvConverter(fieldDelimiter: ';').convert(rows);

  err = !await exportCsv(csv, file: filePath);

  return err;
}
