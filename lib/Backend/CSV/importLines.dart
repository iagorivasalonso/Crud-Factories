import 'dart:convert';
import 'package:crud_factories/Backend/data.dart';
import 'package:crud_factories/Objects/LineSend.dart';

csvImportLines(List<String> fileContent, List<LineSend> line ) async {

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
              state: select[4],
          ));
    }

  } catch (e) {
    if(e.toString().contains("El sistema no puede encontrar el archivo especificado"))
    {
      errorFiles.add("no se encuentra archivo de lineas");
    }
    else
    {
      if(e.toString().contains("Invalid value"))
      {
        errorFiles.add("error de formato de archivo de lineas");
      }
    }
  }

  return line;
}