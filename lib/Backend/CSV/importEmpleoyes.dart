import 'dart:convert';
import 'package:crud_factories/Backend/data.dart';
import 'package:crud_factories/Objects/Empleoye.dart';

csvImportEmpleoyes(List<String> fileContent, List<Empleoye> empleoyes) async {

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
    if(e.toString().contains("El sistema no puede encontrar el archivo especificado"))
    {
      errorFiles.add("no se encuentra archivo de empleados");
    }
    else
    {
      if(e.toString().contains("Invalid value"))
      {
        errorFiles.add("error de formato de archivo de empleados");
      }
    }
  }

  return empleoyes;
}