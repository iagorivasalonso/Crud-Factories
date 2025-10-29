import 'dart:convert';
import 'dart:io';
import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Backend/Global/files.dart';
import 'package:crud_factories/Objects/Mail.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:flutter/material.dart';


Future<void >csvImportMails(BuildContext context, List<String> fileContent, List<Mail> mails) async {

  try {

    mails.addAll(await readMailsFromCsv(fMails));

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
      addrres: parts[1].trim(),
      company: parts[2].trim(),
      password: parts[3].trim()
    ));
  }
  return mail;
}