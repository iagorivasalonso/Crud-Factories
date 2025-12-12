import 'dart:convert';
import 'dart:io';
import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Backend/Global/files.dart';
import 'package:crud_factories/Functions/manageState.dart';
import 'package:crud_factories/Objects/LineSend.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:flutter/material.dart';
Future<void> csvImportLines(BuildContext context, List<LineSend> line, [dynamic fileOrContent] ) async {

  try {

    List<LineSend> imported;

    if (fileOrContent == null)
    {
      imported = await readLinesFromCsv(fLines);
    }
    else if (fileOrContent is File)
    {
      imported = await readLinesFromCsv(fileOrContent);
    }
    else if (fileOrContent is String)
    {
      imported = await readLinesFromCsvContent(fileOrContent);
    }
    else
    {
      throw Exception("Invalid value");
    }
    allLines.addAll(imported);



  } catch (e) {
    String array = S.of(context).lines;

    if(e.toString().contains("El sistema no puede encontrar el archivo especificado")) {
      errorFiles.add("${S.of(context).file_not_found} $array");
    }
    else if(e.toString().contains("Invalid value")) {
      errorFiles.add("${S.of(context).file_format_error} $array");
    }

  }
}

Future<List<LineSend>> readLinesFromCsv(File file) async {

  final content = await file.readAsString(encoding: utf8);
  return readLinesFromCsvContent(content);
}

Future<List<LineSend>> readLinesFromCsvContent(String content) async {

  final lines = const LineSplitter()
      .convert(content)
      .where((line) => line.trim().isNotEmpty)
      .toList();

  final lineSend = <LineSend>[];

  for( final line in lines) {
    final parts = line.split(";");
    if (parts.length < 5) continue;
    lineSend.add(LineSend(
      id: parts[0],
      date:parts[1],
      factory:parts[2] ,
      observations: parts[3] ,
      state: parts[4],
    ));
  }
  return lineSend;
}