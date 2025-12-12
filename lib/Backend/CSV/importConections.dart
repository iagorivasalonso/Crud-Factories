import 'dart:convert';
import 'dart:io';
import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Backend/Global/files.dart';
import 'package:crud_factories/Objects/Conection.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:flutter/material.dart';

import '../../Objects/RouteCSV.dart';

Future<void>csvImportConections(BuildContext context,List<Conection> conection,[dynamic fileOrContent]) async {

  try {

    List<Conection> imported;

    if (fileOrContent == null)
    {
      imported = await readConectionsFromCsv(fConections);
    }
    else if (fileOrContent is File)
    {
      imported = await readConectionsFromCsv(fileOrContent);
    }
    else if (fileOrContent is String)
    {
      imported = await readConectionsFromCsvContent(fileOrContent);
    }
    else
    {
      throw Exception("Invalid value");
    }
    conections.addAll(imported);

  } catch (e) {
    String array = S.of(context).connections;

    if(e.toString().contains("El sistema no puede encontrar el archivo especificado")) {
      errorFiles.add("${S.of(context).file_not_found} $array");
    }
    else if(e.toString().contains("Invalid value")) {
      errorFiles.add("${S.of(context).file_format_error} $array");
    }
  }
}
Future<List<Conection>> readConectionsFromCsv(File file) async {

  final content = await file.readAsString(encoding: utf8);
  return readConectionsFromCsvContent(content);
}


Future<List<Conection>> readConectionsFromCsvContent(String content) async {

  final lines = const LineSplitter()
      .convert(content)
      .where((line) => line.trim().isNotEmpty)
      .toList();

  final conection = <Conection>[];

  for( final line in lines) {
    final parts = line.split(";");
    if (parts.length < 6) continue;
    conection.add(Conection(
      id: parts[0].trim(),
      database: parts[1],
      host: parts[2],
      port: parts[3],
      user: parts[4],
      password: parts[5]
    ));
  }
  return conection;
}