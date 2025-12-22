import 'dart:convert';
import 'dart:io';
import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Objects/RouteCSV.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../Global/files.dart';
import 'Import General/importCsvSafe.dart';


Future<bool> chargueDataCSV(BuildContext context) async {

  bool isCorrect = true;
  fRoutes = new File("assets/dataDefault/routes.csv");
  routesCSV =  await createDefaultData(fRoutes);

  if (routesCSV.isEmpty) {
    errorFiles.add(S.of(context).route_file_cannot_be_read);
    return false;
  }

  if (isCorrect)
  {

    final bytes = Uint8List.fromList(
      utf8.encode(
        await rootBundle.loadString(routesCSV[6].route),
      ),
    );

    try {
      final platformFile = PlatformFile(
        name: routesCSV[0].route.split('/').last,
        path: kIsWeb ? null : routesCSV[1].route,
          bytes: bytes,
          size: bytes.length
      );
      bool result = await importCsvSafe(context, platformFile);
    } catch (e, s) {
      errorFiles.add("Error al importar conexiones");
    }

    try {
      final bytes = Uint8List.fromList(
        utf8.encode(
          await rootBundle.loadString(routesCSV[6].route),
        ),
      );
      final platformFile = PlatformFile(
        name: routesCSV[0].route.split('/').last,
        path: kIsWeb ? null : routesCSV[3].route,
          bytes: bytes,
          size: bytes.length
      );
      bool result = await importCsvSafe(context, platformFile);
    } catch (e, s) {
      errorFiles.add("Error al importar sectors");
    }


    try {
      final bytes = Uint8List.fromList(
        utf8.encode(
          await rootBundle.loadString(routesCSV[6].route),
        ),
      );

      final platformFile = PlatformFile(
        name: routesCSV[0].route.split('/').last,
        path: kIsWeb ? null : routesCSV[4].route,
          bytes: bytes,
          size: bytes.length
      );
      bool result = await importCsvSafe(context, platformFile);
    } catch (e, s) {
      errorFiles.add("Error al importar factories");
    }

    try {

      final bytes = Uint8List.fromList(
        utf8.encode(
          await rootBundle.loadString(routesCSV[6].route),
        ),
      );

      final platformFile = PlatformFile(
        name: routesCSV[0].route.split('/').last,
        path: kIsWeb ? null : routesCSV[5].route,
        bytes: bytes,
        size: bytes.length,
      );
      bool result = await importCsvSafe(context, platformFile);
    } catch (e, s) {
      errorFiles.add("Error al importar empleados");
    }

    try {
      final bytes = Uint8List.fromList(
        utf8.encode(
          await rootBundle.loadString(routesCSV[6].route),
        ),
      );

      final platformFile = PlatformFile(
        name: routesCSV[0].route.split('/').last,
        path: kIsWeb ? null : routesCSV[5].route,
        bytes: bytes,
        size: bytes.length
      );
      bool result = await importCsvSafe(context, platformFile);

    } catch (e, s) {
      print(e);
    errorFiles.add("Error al importar lineas");
    }
  }

  try {
    final bytes = Uint8List.fromList(
      utf8.encode(
        await rootBundle.loadString(routesCSV[6].route),
      ),
    );
    final platformFile = PlatformFile(
      name: routesCSV[0].route.split('/').last,
      path: kIsWeb ? null : routesCSV[6].route,
      bytes: bytes,
      size: bytes.length
    );
    bool result = await importCsvSafe(context, platformFile);
  } catch (e, s) {
    errorFiles.add("Error al importar emails");
  }



  if(isCorrect)
  {
       namesRoutesOrdened = [S.of(context).routes,S.of(context).connections,S.of(context).server,S.of(context).sectors,S.of(context).companies,S.of(context).employees,S.of(context).lines, S.of(context).mails];

       List<RouteCSV> tmp = reorderRouter(namesRoutesOrdened, routesCSV);
       routesCSV = tmp;
  }

  return isCorrect;
}

Future<List<RouteCSV>> createDefaultData(File fRoutes) async {

  final rawData = await rootBundle.loadString(fRoutes.path);

  final converter = CsvToListConverter(fieldDelimiter: ';');
  final List<List<dynamic>> listData = converter.convert(rawData);

  routesCSV.clear();

  for (final row in listData) {
    // Seguridad básica
    if (row.length < 3) continue;

    routesCSV.add(RouteCSV(
      id: row[0].toString(),
      name: row[1].toString(),
      route: row[2].toString(),
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