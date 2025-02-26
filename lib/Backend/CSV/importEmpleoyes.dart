import 'dart:convert';
import 'package:crud_factories/Backend/data.dart';
import 'package:crud_factories/Objects/Empleoye.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:flutter/material.dart';

csvImportEmpleoyes(BuildContext context, List<String> fileContent, List<Empleoye> empleoyes) async {

  try {

    final content = await fEmpleoyes.readAsString(encoding: utf8);
    final lines = const LineSplitter().convert(content);

    for (int i = 0; i < lines.length; i++)
    {
      List<String> select = lines[i].split(";");

        empleoyes.add(Empleoye(
          id: select[0],
          name: select[1],
          idFactory: select[2],
        ));
    }

  } catch (e) {
    String array = S.of(context).employees;

    if(e.toString().contains("El sistema no puede encontrar el file especificado"))
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


  return empleoyes;
}