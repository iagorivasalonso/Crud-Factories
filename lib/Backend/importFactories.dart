import 'dart:io';

import 'package:crud_factories/Objects/Factory.dart';

importFactory(List<String> fileContent, List<Factory> factories) async {

  List<String> select =[];


 File file =new File('D:/factories.csv');
 fileContent = await file.readAsLines();
String tmp="";

 List <String> allEmp = [];
  for (int i = 1; i <fileContent.length; i++) {

    allEmp = fileContent[i].split("[");

    tmp=allEmp[1].substring(0,allEmp[1].length-2);
    allEmp=tmp.split(", ");

  }


  for (int i = 0; i <fileContent.length; i++) {

    select = fileContent[i].split(",");

    factories.add(Factory(
        id: select[0],
        name: select[1],
        highDate: select[2],
        thelephones: [select[3],select[4]],
        mail: select[5],
        web: select[6],
        address: {
          'street': select[7],
          'number': select[8],
          'apartament': select[9],
          'city': select[10],
          'postalCode':select[11] ,
          'province': select[12]
        },
        contacts: allEmp));
  }


  return factories;
}