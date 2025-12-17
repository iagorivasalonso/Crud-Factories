import 'package:crud_factories/Backend/CSV/export.dart';
import 'package:crud_factories/Backend/Global/files.dart';
import 'package:crud_factories/Objects/Mail.dart';
import 'package:csv/csv.dart';
import 'package:flutter/foundation.dart';

import 'export_web.dart';

Future<bool> csvExportatorMails(List<Mail> mails) async {

  bool err = false;

  List<dynamic> associateList = [

    for (int i = 0; i <mails.length; i++)
    {
        "id": mails[i].id,
        "address": mails[i].address,
        "company": mails[i].company,
        "password": mails[i].password
    },
  ];

  List<List<dynamic>> rows = [];

  for (int i = 0; i < associateList.length; i++)
  {
    List<dynamic> row = [];

    row.add(associateList[i]["id"]);
    row.add(associateList[i]["address"]);
    row.add(associateList[i]["company"]);
    row.add(associateList[i]["password"]);
    rows.add(row);
  }

  String csv = const ListToCsvConverter(fieldDelimiter: ';').convert(rows);

  if (kIsWeb) {
    err =  await csvExportweb(csv, fileName: fMails.path);
  } else {

    err = !await csvExport(csv,file: fMails);
  }

  return err;
}