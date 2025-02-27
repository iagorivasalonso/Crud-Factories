import 'dart:convert';
import 'package:crud_factories/Backend/data.dart';
import 'package:crud_factories/Objects/Conection.dart';
import 'package:flutter/material.dart';

csvImportConections(BuildContext context,List<String> fileContent, List<Conection> conections) async {

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
    if(e.toString().contains("El sistema no puede encontrar el file especificado"))
    {
      errorFiles.add("no se encuentra file de connections");
    }
    else
    {
      if(e.toString().contains("Invalid value"))
      {
        errorFiles.add("error de formato de file de connections");
      }
    }
  }

  return conections;
}