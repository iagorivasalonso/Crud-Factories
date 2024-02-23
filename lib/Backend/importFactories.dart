
import 'dart:io';

import 'package:crud_factories/Objects/Factory.dart';

importFactory(List<String> fileContent, List<Factory> factories) async {

  List<String> select =[];
  List<String> select1;
  String allEmp="";
  String temp = "";

  File file =new File('D:/factories.csv');
  fileContent = await file.readAsLines();

  for (int i = 0; i <fileContent.length; i++) {
    select =fileContent[i].split(",");

    List<String> telephones;
    telephones = [ select[3],select[4]];
    select1 = fileContent[i].split("[");
    allEmp = fileContent[1];
    temp = select1[1];
    select1 = temp.split("[");
    temp = temp.substring(0, temp.length - 2);
    select1 = temp.split(",");


    List<String>num = select[9].split(" ");
    factories.add(Factory(
        id: select[0],
        name: select[1],
        highDate: select[2],
        thelephones: telephones,
        mail: select[5],
        web: select[6],
        address: {
          'street': select[7].substring(1),
          'number': num[1],
          'apartament': num[7].substring(0, num[7].length - 3),
          'city': select[10],
          'postalCode': select[11],
          'province': select[12]
        },
        contacts: select1));
  }


  return factories;
}
