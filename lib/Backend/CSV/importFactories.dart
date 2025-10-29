import 'dart:convert';
import 'dart:io';
import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Backend/Global/files.dart';
import 'package:crud_factories/Objects/Factory.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:flutter/material.dart';


Future<void> csvImportFactories(BuildContext context, List<Factory> factories) async {

  try {

    factories.addAll(await readFactoriesFromCsv(fFactories));

  } catch (e) {
    String array = S.of(context).companies;

    if(e.toString().contains("El sistema no puede encontrar el archivo especificado")) {
      errorFiles.add("${S.of(context).file_not_found} $array");
    }
    else if(e.toString().contains("Invalid value")) {
      errorFiles.add("${S.of(context).file_format_error} $array");
    }
  }
}

Future<List<Factory>> readFactoriesFromCsv(File file) async {

  final content = await file.readAsString(encoding: utf8);
  final lines = const LineSplitter()
      .convert(content)
      .where((line) => line.trim().isNotEmpty)
      .toList();

  final factory = <Factory>[];

  for( final line in lines) {
    final parts = line.split(";");
    if (parts.length < 14) continue;
    factory.add(Factory(
      id: parts[0],
      name: parts[1],
      highDate: parts[2],
      sector: parts[3],
      thelephones: [parts[4], parts[5]],
      mail: parts[6],
      web: parts[7],
      address: {
        'street': parts[8],
        'number': parts[9],
        'apartament': parts[10],
        'city': parts[11],
        'postalCode': parts[12],
        'province': parts[13],
      },
    ));
  }
  return factory;
}