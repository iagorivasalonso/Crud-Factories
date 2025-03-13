import 'dart:convert';
import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Backend/Global/files.dart';
import 'package:crud_factories/Objects/Factory.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:flutter/material.dart';

csvImportFactories(BuildContext context, List<String> fileContent, List<Factory> factories) async {

  try {

    final content = await fFactories.readAsString(encoding: utf8);
    final lines = const LineSplitter().convert(content);

    for (int i = 0; i < lines.length; i++) {

      List<String> select = lines[i].split(";");

          factories.add(Factory(
            id: select[0],
            name: select[1],
            highDate: select[2],
            sector: select[3],
            thelephones: [select[4], select[5]],
            mail: select[6],
            web: select[7],
            address: {
              'street': select[8],
              'number': select[9],
              'apartament': select[10],
              'city': select[11],
              'postalCode': select[12],
              'province': select[13],
            },
          ));
    }

  } catch (e) {
    String array = S.of(context).companies;

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

  return factories;
}