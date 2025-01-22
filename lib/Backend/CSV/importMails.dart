import 'dart:convert';
import 'package:crud_factories/Backend/data.dart';
import 'package:crud_factories/Objects/Mail.dart';

csvImportMails(List<String> fileContent, List<Mail> mails) async {

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
    if(e.toString().contains("El sistema no puede encontrar el archivo especificado"))
    {
      errorFiles.add("no se encuentra archivo de emails");
    }
    else
    {
      if(e.toString().contains("Invalid value"))
      {
        errorFiles.add("error de formato de archivo de emails");
      }
    }
  }

  return mails;
}
