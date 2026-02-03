import 'package:crud_factories/Backend/CSV/Export_general/export_csv_io.dart';
import 'package:crud_factories/Backend/CSV/Export_general/export_csv_web.dart' show exportCsv;
import 'package:crud_factories/Backend/Global/files.dart';
import 'package:crud_factories/Objects/Sector.dart';
import 'package:csv/csv.dart';

import 'Export_general/export_csv.dart';



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

  err = !await exportCsvIO(csv,file: fMails);


  return err;
}


