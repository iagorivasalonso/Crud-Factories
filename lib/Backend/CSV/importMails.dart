import 'dart:convert';
import 'dart:io';

import 'package:crud_factories/Backend/Global/files.dart';
import 'package:crud_factories/Objects/Mail.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:flutter/material.dart';

import '../Global/list.dart';


Future<void >csvImportMails(BuildContext context, List<Mail> mailf,[dynamic fileOrContent]) async {

  try {

    List<Mail> imported;

    if (fileOrContent == null)
    {
      imported = await readMailsFromCsv(fMails);
    }
    else if (fileOrContent is File)
    {
      imported = await readMailsFromCsv(fileOrContent);
    }
    else if (fileOrContent is String)
    {
      imported = await readMailsFromCsvContent(fileOrContent);
    }
    else
    {
      throw Exception("Invalid value");
    }
    mails.addAll(imported);


  } catch (e) {
    String array = S.of(context).mails;

    if(e.toString().contains("El sistema no puede encontrar el archivo especificado")) {
      errorFiles.add("${S.of(context).file_not_found} $array");
    }
    else if(e.toString().contains("Invalid value")) {
      errorFiles.add("${S.of(context).file_format_error} $array");
    }
  }
}

Future<List<Mail>> readMailsFromCsv(File file) async {

  final content = await file.readAsString(encoding: utf8);
  return readMailsFromCsvContent(content);
}

Future<List<Mail>> readMailsFromCsvContent(String content) async {

  final lines = const LineSplitter()
      .convert(content)
      .where((line) => line.trim().isNotEmpty)
      .toList();

  final mail = <Mail>[];

  for( final line in lines) {
    final parts = line.split(";");
    if (parts.length < 4) continue;
    mail.add(Mail(
      id: parts[0].trim(),
      address: parts[1].trim(),
      company: parts[2].trim(),
      password: parts[3].trim()
    ));
  }
  return mail;
}