
import 'dart:convert';
import 'dart:io';
import 'package:crud_factories/Objects/Conection.dart';

csvImportConections(List<String> fileContent, List<Conection> conections) async {

  try {
    final File file = File('D:/conections.csv');
    final content = await file.readAsString(encoding: latin1);

    final lines = const LineSplitter().convert(content);

    List<String> select = [];

    for (int i = 0; i < lines.length; i++) {

      select = lines[i].split(";");

    if(select.length == 6)
    {
      conections.add(Conection(
          id: select[0],
          database: select[1],
          host: select[2],
          port: select[3],
          user: select[4],
          password: select[5]
      ));
    }
  }
  } catch (e) {
    print('Error reading CSV file conections: $e');
  }
  return conections;
}