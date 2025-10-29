import 'dart:convert';
import 'dart:io';
import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Backend/Global/files.dart';
import 'package:crud_factories/Objects/Empleoye.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:flutter/material.dart';


Future<void>csvImportEmpleoyes(BuildContext context, List<Empleoye> empleoyes) async {

  try {

   empleoyes.addAll(await readEmpleoyeFromCsv(fEmpleoyes));

  } catch (e) {
    String array = S.of(context).employees;
    
    if(e.toString().contains("El sistema no puede encontrar el archivo especificado")) {
      errorFiles.add("${S.of(context).file_not_found} $array");
    }
    else if(e.toString().contains("Invalid value")) {
      errorFiles.add("${S.of(context).file_format_error} $array");
    }
  }
}

Future<List<Empleoye>> readEmpleoyeFromCsv(File file) async {

  final content = await file.readAsString(encoding: utf8);
  final lines = const LineSplitter()
      .convert(content)
      .where((line) => line.trim().isNotEmpty)
      .toList();

  final empleoye = <Empleoye>[];

  for( final line in lines) {
    final parts = line.split(";");
    if (parts.length < 3) continue;
    empleoye.add(Empleoye(
      id: parts[0].trim(),
      name: parts[1].trim(),
      idFactory: parts[2].trim(),
    ));
  }
  return empleoye;
}