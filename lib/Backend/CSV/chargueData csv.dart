import 'dart:io';

import 'package:crud_factories/Backend/CSV/importConections.dart';
import 'package:crud_factories/Backend/CSV/importRoutes.dart';
import 'package:crud_factories/Backend/CSV/importEmpleoyes.dart';
import 'package:crud_factories/Backend/CSV/importFactories.dart';
import 'package:crud_factories/Backend/CSV/importLines.dart';
import 'package:crud_factories/Backend/CSV/importMails.dart';
import 'package:crud_factories/Backend/CSV/importSectors.dart';
import 'package:crud_factories/Backend/data.dart';
import 'package:crud_factories/Objects/RouteCSV.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:flutter/src/widgets/framework.dart';


Future<bool> chargueDataCSV(BuildContext context) async {

  routesManage.clear();
  bool isCorrect = true;

  allRoutes = ['Routes', 'Conections', 'serverSql', 'Sectors', 'Factories', 'Empleoyes', 'Lines', 'Mails'];
  SQLRoutes = ['Routes', 'Conections', 'serverSql'];

  if (routesManage.isEmpty)
  {
    Directory currentDir = Directory.current;
    Directory parentDir = currentDir.parent;

    routeFirst = '${parentDir.path}routes.csv';
    fRoutes = File(routeFirst);
  }

  final filePathRoutes = fRoutes;

  try {
    routesManage.add(await csvImportRoutes(context,fileContent, routesManage));
  } catch (Exeption) {

  }

  if (await filePathRoutes.exists())
  {

     if(routesManage.isNotEmpty)
     {
         String current = " ";
         List<RouteCSV> routesOrd = [];

         for(int i = 0; i < allRoutes.length; i++)
         {
               current = allRoutes[i];
               bool exist = false;

               for(int y = 0; y < routesManage.length; y++)
               {
                     if(current == routesManage[y].name)
                     {
                       routesOrd.add(routesManage[y]);
                       exist = true;
                       break;
                     }
               }
               if(!exist)
               {
                 routesOrd.add(RouteCSV(
                   id: '',
                   name: '',
                   route: '',
                 ));
               }
         }

         routesManage = routesOrd;
     }
     else
     {
       errorFiles.add(S.of(context).route_file_cannot_be_read);
        isCorrect = false;
     }

     if(isCorrect = true)
     {
       conections.clear();
       fConections = File(routesManage[1].route);

       try {
         conections.add(await csvImportConections(context,fileContent, conections));
       } catch (Exeption) {

       }

       try {

         dynamic routeServer = routesManage[2].route;

         fServer = File(routeServer);

       } catch (Exeption) {

       }



       sectors.clear();
       fSectors = File(routesManage[3].route);

       try {
         sectors.add(await csvImportSectors(context,fileContent, sectors));
       } catch (Exeption) {

       }

       allFactories.clear();
       fFactories = File(routesManage[4].route);

       try {
         allFactories.add(await csvImportFactories(context,fileContent, allFactories));
       } catch (Exeption) {

       }

       empleoyes.clear();
       fEmpleoyes = File(routesManage[5].route);

       try {
         empleoyes.add(await csvImportEmpleoyes(context,fileContent, empleoyes));
       } catch (Exeption) {

       }

       allLines.clear();
       fLines = File(routesManage[6].route);

       try {
         allLines.add(await csvImportLines(context,fileContent, allLines));
       } catch (Exeption) {

       }
       mails.clear();

       fMails = File(routesManage[7].route);

       try {
         mails.add(await csvImportMails(context,fileContent, mails));
       } catch (Exeption) {

       }

     }
  }
  else
  {
     isCorrect = false;

  }

  return isCorrect;
}
