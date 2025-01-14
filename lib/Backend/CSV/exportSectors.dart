import 'package:crud_factories/Backend/data.dart';
import 'package:crud_factories/Objects/Sector.dart';
import 'package:csv/csv.dart';

void csvExportatorSectors(List<Sector> sectors){

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
  fSectors.writeAsString(csv);
}


