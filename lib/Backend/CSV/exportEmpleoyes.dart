
import 'package:crud_factories/Backend/Global/files.dart';
import 'package:crud_factories/Objects/Empleoye.dart';
import 'package:csv/csv.dart';

import 'Export_general/export_csv_io.dart';
import 'Export_general/export_csv_stub.dart';



Future<bool> csvExportatorEmpleoyes(List<Empleoye> empleoyes) async {

  bool err = false;

  List<dynamic> associateList = [

      for (int i = 0; i < empleoyes.length; i++)
      {
        "id": empleoyes[i].id,
        "name": empleoyes[i].name,
        "idFactory": empleoyes[i].idFactory
      },
  ];

  List<List<dynamic>> rows = [];

  for (int i = 0; i < associateList.length; i++)
  {
        List<dynamic> row = [];

        row.add(associateList[i]["id"]);
        row.add(associateList[i]["name"]);
        row.add(associateList[i]["idFactory"]);
        rows.add(row);
  }

  final filePath = fEmpleoyes.toString();
  String csv = const ListToCsvConverter(fieldDelimiter: ';').convert(rows);

  err = !await exportCsv(csv, file: filePath);

  return err;
}
