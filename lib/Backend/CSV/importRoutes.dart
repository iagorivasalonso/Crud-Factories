import 'dart:convert';
import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Backend/Global/files.dart';
import 'package:crud_factories/Objects/RouteCSV.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:flutter/material.dart';

csvImportRoutes(BuildContext context,List<String> fileContent, List<RouteCSV> routesManage) async {

  try {

    final content = await fRoutes.readAsString(encoding: utf8);
    final lines = const LineSplitter().convert(content);

    for (int i = 0; i < lines.length; i++)
    {
      List<String> select = lines[i].split(";");

        routesManage.add(RouteCSV(
          id: select[0].trim(),
          name: select[1].trim(),
          route: select[2].trim(),
        ));
    }

  } catch (e) {
        String array = S.of(context).routes;

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

  return routesManage;
}

