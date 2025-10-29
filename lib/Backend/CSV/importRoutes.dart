import 'dart:convert';
import 'dart:io';
import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Backend/Global/files.dart';
import 'package:crud_factories/Objects/RouteCSV.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:fluent_ui/fluent_ui.dart';


Future<void>csvImportRoutes(BuildContext context, List<RouteCSV> routesManage) async {

  try {

    routesManage.addAll(await readRoutesFromCsv(fRoutes));

  } catch (e) {
        String array = S.of(context).routes;

        if(e.toString().contains("El sistema no puede encontrar el archivo especificado")) {
          errorFiles.add("${S.of(context).file_not_found} $array");
        }
        else if(e.toString().contains("Invalid value")) {
          errorFiles.add("${S.of(context).file_format_error} $array");
        }
  }
}

Future<List<RouteCSV>> readRoutesFromCsv(File file) async {

  final content = await file.readAsString(encoding: utf8);
  final lines = const LineSplitter()
      .convert(content)
      .where((line) => line.trim().isNotEmpty)
      .toList();

  final route = <RouteCSV>[];

  for( final line in lines) {
    final parts = line.split(";");
    if (parts.length < 4) continue;
    route.add(RouteCSV(
      id: parts[0].trim(),
      name: parts[1].trim(),
      route: parts[2].trim(),
    ));
  }
  return route;
}