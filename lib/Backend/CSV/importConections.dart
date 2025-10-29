import 'dart:convert';
import 'dart:io';
import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Backend/Global/files.dart';
import 'package:crud_factories/Objects/Conection.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:flutter/material.dart';

Future<void>csvImportConections(BuildContext context,List<Conection> conections) async {

  try {

    conections.addAll(await readConectionsFromCsv(fConections));

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