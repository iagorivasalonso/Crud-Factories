import 'dart:convert';
import 'package:crud_factories/Backend/data.dart';
import 'package:crud_factories/Objects/Sector.dart';

csvImportSectors(List<String> fileContent, List<Sector> sectors) async {

  try {

    final content = await fSectors.readAsString(encoding: utf8);
    final lines = const LineSplitter().convert(content);

    for (int i = 0; i < lines.length; i++)
    {
      List<String> select  = lines[i].split(";");

          sectors.add(Sector(
              id: select[0].trim(),
              name: select[1].trim()
          ));
    }

  } catch (e) {
    if(e.toString().contains("El sistema no puede encontrar el archivo especificado"))
    {
      print("no se encuentra archivo de sectores");
    }
    else
    {
      if(e.toString().contains("Invalid value"))
      {
        print("error de formato de archivo de sectores");
      }
    }
  }

    return sectors;
}