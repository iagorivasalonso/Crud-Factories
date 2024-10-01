import 'dart:io';

import 'package:crud_factories/Objects/Sector.dart';

csvImportSectors(List<String> fileContent, List<Sector> sectors) async{

  List<String> select =[];

  if(fileContent.isEmpty)
  {
    File file = new File('D:/sectors.csv');

    if(file.existsSync())
      fileContent = await file.readAsLines();
  }

  for (int i = 0; i < fileContent.length; i++) {
    select = fileContent[i].split(",");
    sectors.add(Sector(
        id: select[0],
        name: select[1]));
  }

    return sectors;

}