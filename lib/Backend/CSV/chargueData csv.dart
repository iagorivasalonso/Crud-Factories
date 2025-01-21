import 'dart:io';

import 'package:crud_factories/Backend/CSV/importConections.dart';
import 'package:crud_factories/Backend/CSV/importRoutes.dart';
import 'package:crud_factories/Backend/CSV/importEmpleoyes.dart';
import 'package:crud_factories/Backend/CSV/importFactories.dart';
import 'package:crud_factories/Backend/CSV/importLines.dart';
import 'package:crud_factories/Backend/CSV/importMails.dart';
import 'package:crud_factories/Backend/CSV/importSectors.dart';
import 'package:crud_factories/Backend/data.dart';


Future<void> chargueDataCSV() async {

  routesManage.clear();

  if(routesManage.isEmpty)
  {
    fRoutes  = File('D:/routes.csv');
  }


  try {
    routesManage.add( await csvImportRoutes(fileContent, routesManage));
  } catch (Exeption) {

  }

  conections.clear();
  fConections = File(routesManage[1].route);

  try {
    conections.add(await csvImportConections(fileContent, conections));

  } catch (Exeption) {

  }

  fServer =routesManage[2].route;

    if(routesManage.isNotEmpty)
    {
              sectors.clear();
              fSectors = File(routesManage[3].route);

              try {
                sectors.add(await csvImportSectors(fileContent,sectors));
              } catch (Exeption) {

              }

              allFactories.clear();
              fFactories = File(routesManage[4].route);

              try {
                allFactories.add(csvImportFactories(fileContent, allFactories));
              } catch (Exeption) {

              }

              empleoyes.clear();
              fEmpleoyes = File(routesManage[5].route);

              try{
                empleoyes.add(csvImportEmpleoyes(fileContent, empleoyes));
              } catch (Exeption) {

              }

              allLines.clear();
              fLines = File(routesManage[6].route);

              try {
                allLines.add(csvImportLines(fileContent, allLines));
              } catch (Exeption) {

              }
              mails.clear();
              fMails = File(routesManage[7].route);

              try {
                mails.add(csvImportMails(fileContent, mails));
              } catch (Exeption) {

              }
    }

}

