
import 'dart:io';

import 'package:crud_factories/Objects/Conection.dart';

csvImportConections(List<String> fileContent, List<Conection> conection) async {

  List<String> select = [];

  if(fileContent.isEmpty)
  {
    File file = File('D:/conections.csv');

    if(file.existsSync())
      fileContent = await file.readAsLines();
  }

  for (int i = 0; i <fileContent.length; i++)
  {
    select = fileContent[i].split(",");
    conection.add(Conection(
        id: select[0],
        database: select[1],
        host: select[2],
        port: select[3],
        user: select[4],
        password: select[5]
    ));

  }
}