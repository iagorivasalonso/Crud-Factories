import 'dart:io';
import 'package:crud_factories/Objects/Factory.dart';


csvImportFactories(List<String> fileContent, List<Factory> factories) async {

  List<String> select =[];

   if(fileContent.isEmpty)
  {

    File file =new File('D:/factories.csv');

    if(file.existsSync())
    fileContent = await file.readAsLines();
  }




  for (int i = 0; i <fileContent.length; i++)
  {
    select = fileContent[i].split(",");

    factories.add(Factory(
        id: select[0],
        name: select[1],
        highDate: select[2],
        sector: select[3],
        thelephones: [select[4],select[5]],
        mail: select[6],
        web: select[7],
        address: {
          'street': select[8],
          'number': select[9],
          'apartament': select[10],
          'city': select[11],
          'postalCode':select[12] ,
          'province': select[13]
        }));
  }

  return factories;
}