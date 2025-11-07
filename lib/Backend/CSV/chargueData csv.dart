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
import 'package:flutter/src/widgets/framework.dart';


Future<bool> chargueDataCSV(BuildContext context) async {

  routesCSV.clear();
  bool isCorrect = true;



  if (routesCSV.isEmpty)
  {
    Directory currentDir = Directory.current;
    Directory parentDir = currentDir.parent;

    routeFirst = parentDir.path;
    fRoutes = File(routeFirst);
  }

  fRoutes = File('${fRoutes.path}/rutas.csv');

  if (await fRoutes.exists())
  {

        await csvImportRoutes(context, routesCSV);


  } else
  {

    errorFiles.add(S.of(context).route_file_cannot_be_read);
  }




  if (await routesCSV.isNotEmpty)
  {

     if(routesCSV.isNotEmpty)
     {
       List<String> namesRoutesOrdened= ['Routes', 'Conections', 'serverSql', 'Sectors', 'Factories', 'Empleoyes', 'Lines', 'Mails'];

       List<RouteCSV> tmp = reorderRouter(namesRoutesOrdened, routesCSV);

       routesCSV = tmp;
     }
     else
     {
       errorFiles.add(S.of(context).route_file_cannot_be_read);
        isCorrect = false;
     }

     if(isCorrect)
     {
       sectors.clear();
       fSectors = File(routesCSV[3].route);

       try {
         await csvImportSectors(context, sectors);
       } catch (Exeption) {

       }


       mails.clear();
       fMails = File(routesCSV[7].route);

       try {
         await csvImportMails(context,fileContent, mails);
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