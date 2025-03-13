import 'dart:convert';
import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Backend/Global/files.dart';
import 'package:crud_factories/Functions/manageState.dart';
import 'package:crud_factories/Objects/LineSend.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:flutter/material.dart';

csvImportLines(BuildContext context, List<String> fileContent, List<LineSend> line ) async {

  try {

    final content = await fLines.readAsString(encoding: utf8);
    final lines1 = const LineSplitter().convert(content);

    for (int i = 0; i < lines1.length; i++)
    {
      List<String> select  = lines1[i].split(";");

          line.add(LineSend(
              id: select[0],
              date:select[1],
              factory:select[2] ,
              observations: select[3] ,
              state: manageState.parseState(select[4],context,
                  true),
          ));

    }

  } catch (e) {
    String array = S.of(context).lines;

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

  return line;
}