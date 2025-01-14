import 'dart:convert';
import 'package:crud_factories/Backend/data.dart';
import 'package:crud_factories/Objects/Conection.dart';

csvImportConections(List<String> fileContent, List<Conection> conections) async {

  try {

      final content = await fConections.readAsString(encoding: utf8);
      final lines = const LineSplitter().convert(content);

      for (int i = 0; i < lines.length; i++)
      {
        List<String> select  = lines[i].split(";");
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
    if(e.toString().contains("El sistema no puede encontrar el archivo especificado"))
    {
      print("no se encuentra archivo de conexiones");
    }
    else
    {
      if(e.toString().contains("Invalid value"))
      {
        print("error de formato de archivo de conexiones");
      }
    }
  }
  return conections;
}