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


Future<bool> chargueDataCSV() async {

  routesManage.clear();
  bool isCorrect = true;


  if (routesManage.isEmpty)
  {
    fRoutes = File('D:/routes.csv');
  }

  final filePathRoutes = fRoutes;

  try {
    routesManage.add(await csvImportRoutes(fileContent, routesManage));
  } catch (Exeption) {

  }

  if (await filePathRoutes.exists())
  {

    allRoutes = ['Routes', 'Conections', 'serverSql', 'Sectors', 'Factories', 'Empleoyes', 'Lines', 'Mails'];
    SQLRoutes = ['Routes', 'Conections', 'serverSql'];

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
       errorFiles.add("No se puede leer el archivo de rutas");
        isCorrect = false;
     }

     if(isCorrect = true)
     {
       conections.clear();
       fConections = File(routesManage[1].route);

       try {
         conections.add(await csvImportConections(fileContent, conections));
       } catch (Exeption) {

       }

       fServer = routesManage[2].route;



       sectors.clear();
       fSectors = File(routesManage[3].route);

       try {
         sectors.add(await csvImportSectors(fileContent, sectors));
       } catch (Exeption) {

       }

       allFactories.clear();
       fFactories = File(routesManage[4].route);

       try {
         allFactories.add(await csvImportFactories(fileContent, allFactories));
       } catch (Exeption) {

       }

       empleoyes.clear();
       fEmpleoyes = File(routesManage[5].route);

       try {
         empleoyes.add(await csvImportEmpleoyes(fileContent, empleoyes));
       } catch (Exeption) {

       }

       allLines.clear();
       fLines = File(routesManage[6].route);

       try {
         allLines.add(await csvImportLines(fileContent, allLines));
       } catch (Exeption) {

       }
       mails.clear();

       fMails = File(routesManage[7].route);

       try {
         mails.add(await csvImportMails(fileContent, mails));
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
