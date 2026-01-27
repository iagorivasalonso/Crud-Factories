import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:crud_factories/Backend/CSV/ImportGeneral/AppFile.dart';
import 'package:fluent_ui/fluent_ui.dart' show BuildContext;
import 'package:flutter/services.dart';

import 'importAppFile.dart';


Future<bool> importCsvSafe(
    BuildContext context,
    AppFile file,
    ) async {

  String content;

  try {
     if(file.assetPath !=null)
     {
       content = await rootBundle.loadString(file.assetPath!);
     }
     else
     {
       final f = File(file.path!);
       content = await f.readAsString(encoding: utf8);
     }
     await importAppFile(context, file);

    return true;
  } catch (e) {
    return false;
  }
}