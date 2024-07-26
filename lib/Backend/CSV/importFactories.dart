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
    String tmp="";

    List <String> allEmp = [];

    select = fileContent[i].split(",");
    allEmp= fileContent[i].split("[");
    tmp=allEmp[1].substring(0,allEmp[1].length-1);
    allEmp=tmp.split(",");


    factories.add(Factory(
        id: select[0],
        name: select[1],
        highDate: select[2],
        thelephones: [select[3],select[4]],
        mail: select[5],
        web: select[6],
        address: {
          'street': select[7],
          'number': select[8].replaceAll(" ",""),
          'apartament': select[9],
          'city': select[10],
          'postalCode':select[11] ,
          'province': select[12]
        },
        contacts: allEmp));
  }

  return factories;
}