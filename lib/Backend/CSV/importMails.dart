import 'dart:convert';
import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Backend/Global/files.dart';
import 'package:crud_factories/Objects/Mail.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:flutter/material.dart';

csvImportMails(BuildContext context, List<String> fileContent, List<Mail> mails) async {

  try {

    final content = await fMails.readAsString(encoding: utf8);
    final lines = const LineSplitter().convert(content);

    for (int i = 0; i < lines.length; i++)
    {
      List<String> select  = lines[i].split(";");

          mails.add(Mail(
              id: select[0].trim(),
              addrres: select[1].trim(),
              company: select[2].trim(),
              password: select[3].trim()
          ));
    }

  } catch (e) {
    String array = S.of(context).emails;

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

  return mails;
}
