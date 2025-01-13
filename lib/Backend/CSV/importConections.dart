
import 'dart:convert';
import 'dart:io';
import 'package:crud_factories/Backend/data.dart';
import 'package:crud_factories/Objects/Conection.dart';

csvImportConections(List<String> fileContent, List<Conection> conections) async {

  try {
    File file = File(routesManage[6].route);
    final content = await file.readAsString(encoding: latin1);

    final lines = const LineSplitter().convert(content);

    List<String> select = [];

    for (int i = 0; i < lines.length; i++) {

      select = lines[i].split(";");
      conections.add(Conection(
          id: select[0],
          database: select[1],
          host: select[2],
          port: select[3],
          user: select[4],
          password: select[5]
      ));

  }
  } catch (e) {
    print('Error reading CSV file conections: $e');
  }
  return conections;
}