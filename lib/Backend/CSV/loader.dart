import 'dart:convert';
import 'dart:io';
import 'package:crud_factories/Backend/Global/files.dart';
import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Objects/RouteCSV.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'ImportGeneral/AppFile.dart';
import 'ImportGeneral/importAppFile.dart';


class csvLoaderService {

  static Future<bool> loadInitialRoutes(BuildContext context) async {


    const String defaultRoutesPath = 'assets/dataDefault/routes.csv';

    fRoutes = new File(defaultRoutesPath);
    routesCSV =  await createDefaultData(defaultRoutesPath);

    if (routesCSV.isEmpty) {
      errorFiles.add(S.of(context).route_file_cannot_be_read);
      return false;
    }

    if(true)
    {
      namesRoutesOrdened = [S.of(context).routes,S.of(context).connections,S.of(context).server,S.of(context).sectors,S.of(context).companies,S.of(context).employees,S.of(context).lines, S.of(context).mails];

      List<RouteCSV> tmp = reorderRouter(namesRoutesOrdened, routesCSV);
      routesCSV = tmp;
      print(tmp);
    }

    return true; // Devuelve true si todo bien
  }

  static Future<bool> loadRemainingRoutes(BuildContext context) async {

    final cantidadRoutes=routesCSV.length;
    bool isCorrect= true;

    for(int i = 1; i <cantidadRoutes; i++)
    {
      final route = routesCSV[i].route;
      try {
        AppFile file;
        if(route.startsWith('assets/'))
        {
           file = fromAsset(route);
        }
        else
        {
          file = fromPath(route);
        }

        await importAppFile(context, file);
      } catch (e, s) {
        String array =routesCSV[i].name;
        errorFiles.add("${S.of(context).file_not_found} $array");
      }

    }

    return true; // Devuelve true si todo bien
  }
  static AppFile fromAsset(String assetPath) {
    return AppFile(
      name: assetPath.split('/').last,
      assetPath: assetPath,
    );
  }

  static AppFile fromPath(String path) {
    return AppFile(
      name: path.split('/').last,
      path: path,
    );
  }

  static AppFile fromPlatformFile(PlatformFile file) {
    return AppFile(
      name: file.name,
      path: file.path,
      bytes: file.bytes,
    );
  }
}


Future<List<RouteCSV>> createDefaultData(String defaultRoutesPath) async {

  final rawData = await rootBundle.loadString(defaultRoutesPath);

  final converter = CsvToListConverter(fieldDelimiter: ';');
  final List<List<dynamic>> listData = converter.convert(rawData);

  routesCSV.clear();

  for (final row in listData) {
    // Seguridad básica
    if (row.length < 3) continue;

    routesCSV.add(RouteCSV(
      id: row[0].toString(),
      name: row[1],
      route: row[2],
    ));
  }

  return routesCSV;

}



List<RouteCSV> reorderRouter ( List<String> orderRoutes, List<RouteCSV> routesCsv) {

   final routeMap = {
     for(var r in routesCsv)
        if(r.name.isNotEmpty)
           r.name:r
   };

   final reordered = orderRoutes.map((name) {
     final existingRoute = routeMap[name];
     if (existingRoute != null) {
       return existingRoute;
     } else {
       return RouteCSV(name: name, id: '', route: '');
     }
   }).toList();

   return reordered;
}

void clearAllData() {
  routesCSV.clear();
  errorFiles.clear();

  // ⚠️ TODAS las listas que llenan los CSV
  allFactories.clear();
  empleoyes.clear();
  sectors.clear();
  conections.clear();
  mails.clear();
  allLines.clear();
}