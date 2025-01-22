import 'dart:convert';
import 'package:crud_factories/Backend/data.dart';
import 'package:crud_factories/Objects/RouteCSV.dart';

csvImportRoutes(List<String> fileContent, List<RouteCSV> routesManage) async {

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
        if(e.toString().contains("El sistema no puede encontrar el archivo especificado"))
        {
           errorFiles.add("no se encuentra archivo de rutas");
        }
        else
        {
            if(e.toString().contains("Invalid value"))
            {
              errorFiles.add("error de formato de archivo de rutas");
            }
        }
  }

  return routesManage;
}

