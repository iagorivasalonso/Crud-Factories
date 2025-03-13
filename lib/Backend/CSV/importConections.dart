import 'dart:convert';
import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Backend/Global/files.dart';
import 'package:crud_factories/Objects/Conection.dart';
import 'package:crud_factories/generated/l10n.dart';
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
    String array = S.of(context).connections;

    if(e.toString().contains("El sistema no puede encontrar el archivo especificado"))
    {
      String noFile =  S.of(context).file_not_found;
      errorFiles.add("$noFile $array");
    }
    else
    {
      if(e.toString().contains("Invalid value"))
      {
        String errorFile =  S.of(context).file_format_error;
        errorFiles.add("$errorFile $array");
      }
    }
  }

  return conections;
}