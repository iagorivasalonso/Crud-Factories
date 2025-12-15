import 'dart:convert';
import 'dart:io';

import 'package:crud_factories/Backend/CSV/importConections.dart';
import 'package:crud_factories/Backend/CSV/importRoutes.dart';
import 'package:crud_factories/Backend/CSV/importEmpleoyes.dart';
import 'package:crud_factories/Backend/CSV/importFactories.dart';
import 'package:crud_factories/Backend/CSV/importLines.dart';
import 'package:crud_factories/Backend/CSV/importMails.dart';
import 'package:crud_factories/Backend/CSV/importSectors.dart';
import 'package:crud_factories/Backend/Global/files.dart';
import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Objects/RouteCSV.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';


Future<bool> chargueDataCSV(BuildContext context) async {

  //routesCSV.clear();
  bool isCorrect = true;

  if(!kIsWeb)
  {
    File tmp = File('${fRoutes.path}/routes.csv');

    if (!await tmp.exists())
    {
      Directory currentDir = Directory.current;
      Directory parentDir = currentDir.parent;

      routeFirst = parentDir.path;
      fRoutes = File(routeFirst);


      try {
        await tmp.create(recursive: true);
        isCorrect = true;
      } catch (e) {
        errorFiles.add(S.of(context).error_creating_file);
        isCorrect = false;
      }

    }
    else
    {
      errorFiles.add(S.of(context).error_creating_file);
      isCorrect = true;
    }
    fRoutes = tmp;
  }

  if (isCorrect)
  {
        await csvImportRoutes(context, routesCSV);
        isCorrect = true;
  }
  else
  {
    errorFiles.add(S.of(context).route_file_cannot_be_read);
    isCorrect = false;
  }

  if(isCorrect)
  {
       namesRoutesOrdened = [S.of(context).routes,S.of(context).connections,S.of(context).server,S.of(context).sectors,S.of(context).companies,S.of(context).employees,S.of(context).lines, S.of(context).mails];

       List<RouteCSV> tmp = reorderRouter(namesRoutesOrdened, routesCSV);
       routesCSV = tmp;
  }
  else
  {
      errorFiles.add(S.of(context).route_file_cannot_be_read);
      isCorrect = false;
  }

   if(isCorrect && !kIsWeb)
   {
       sectors.clear();
       fSectors = File(routesCSV[3].route);

       try {
        await csvImportSectors(context, sectors);
       } catch (Exeption) {

       }

       empleoyes.clear();
       fEmpleoyes = File(routesCSV[3].route);

       try {
         await csvImportEmpleoyes(context, empleoyes);
       } catch (Exeption) {

       }

       mails.clear();
       fMails = File(routesCSV[7].route);

       try {
         await csvImportMails(context, mails);
       } catch (Exeption) {

       }

       allLines.clear();
       fLines = File(routesCSV[6].route);

       try {
         await csvImportLines(context, allLines);
       } catch (Exeption) {

       }

       conections.clear();
       fConections = File(routesCSV[1].route);

       try {
         await csvImportConections(context,conections);
       } catch (Exeption) {

       }

       try {

         dynamic routeServer = routesCSV[2].route;
         fServer = File(routeServer);

       } catch (Exeption) {

       }

       allFactories.clear();
       fFactories = File(routesCSV[4].route);

       await csvImportFactories(context, allFactories);
     }
   else
   {
         isCorrect = false;
   }

  return isCorrect;
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