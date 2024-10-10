import 'dart:io';

import 'package:crud_factories/Objects/Empleoye.dart';

csvImportEmpleoyes(List<String> fileContent, List<Empleoye> empleoyes) async {

  List<String> select =[];

  if(fileContent.isEmpty)
  {
    File file =new File('D:/empleoyes.csv');

    if(file.existsSync())
      fileContent = await file.readAsLines();
  }

  for (int i = 0; i <fileContent.length; i++)
  {
    select = fileContent[i].split(",");
    empleoyes.add(Empleoye(
        id: select[0],
        name: select[1],
        idFactory: select[2],
    ));
  }

  return empleoyes;
}