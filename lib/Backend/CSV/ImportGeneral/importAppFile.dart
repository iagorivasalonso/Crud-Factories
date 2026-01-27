
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:crud_factories/Backend/CSV/ImportGeneral/AppFile.dart';

import 'AppFile.dart';
import 'CsvProcessorService.dart';


Future<void> importAppFile (BuildContext context, AppFile file , [bool importOtherFiles = false]) async {

  String content;

  try{
      if(file.assetPath!=null)
      {
        content = await rootBundle.loadString(file.assetPath!);
      }
      else
      {
        final f = File(file.path!);
        content = await f.readAsString(encoding: utf8);
      }
     await CsvProcessorService.processCsvContent(context, content, importOtherFiles);
  }catch (e) {

  }
}
