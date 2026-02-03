
import 'dart:convert';
import 'dart:io';
import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/helpers/localization_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:crud_factories/Backend/CSV/ImportGeneral/AppFile.dart';
import 'CsvProcessorService.dart';


Future<bool> importAppFile (BuildContext context, AppFile file , [bool importOtherFiles = false]) async {

  String content;
  String array="";

  try{
     final path = file.path ?? file.assetPath ?? '';

      if(path.toLowerCase().endsWith('.exe'))
      {
        return true;
      }
      if(file.assetPath!=null)
      {
        content = await rootBundle.loadString(file.assetPath!);
      }
      else
      {
        final f = File(file.path!);
        content = await f.readAsString(encoding: utf8);
      }

      if (content.trim().isEmpty)
      {
           var match = routesCSV.firstWhere(
                 (route) => route.route == file.name,
             // si no hay coincidencia devuelve null
          );

           array=match.name;


       return true;
     }
     else
     {
       await CsvProcessorService.processCsvContent(
         context, content, importOtherFiles
        );
         return false;
     }

 }catch (e) {
    errorFiles.add(LocalizationHelper.noFile(context,array));
    return false;
  }

}
