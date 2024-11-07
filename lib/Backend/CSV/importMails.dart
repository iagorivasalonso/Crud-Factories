import 'dart:convert';
import 'dart:io';
import 'package:crud_factories/Objects/Mail.dart';

csvImportMails(List<String> fileContent, List<Mail> mails) async {

  try {
    final file = File('D:/mails.csv');
    final content = await file.readAsString(encoding: utf8);

    final lines = const LineSplitter().convert(content);

    List<String> select = [];

    for (int i = 0; i < lines.length; i++) {

      select = lines[i].split(";");
      mails.add(Mail(
          id: select[0],
          addrres: select[1],
          company: select[2],
          password: select[3]));

    }
  } catch (e) {
    print('Error reading CSV file mails: $e');
  }
  return mails;
}
