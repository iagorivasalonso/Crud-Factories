import 'dart:convert';
import 'dart:io';
import 'package:crud_factories/Backend/data.dart';
import 'package:crud_factories/Objects/RouteCSV.dart';

csvImportRoutes(List<String> fileContent, List<RouteCSV> routesManage) async {


  try {
    final content = await fRoutes.readAsString(encoding: utf8);
    final lines = const LineSplitter().convert(content);

    for (int i = 0; i < lines.length; i++) {
      List<String> select = lines[i].split(";");


        routesManage.add(RouteCSV(
          id: select[0].trim(),
          name: select[1].trim(),
          route: select[2].trim(),
        ));

    }

  } catch (e) {
    print('Error reading CSV file routes: $e');
  }

  return routesManage;

}

