import 'dart:convert';
import 'dart:io';

import 'package:crud_factories/Objects/Empleoye.dart';

csvImportEmpleoyes(List<String> fileContent, List<Empleoye> empleoyes) async {

  try {
    File file = File('D:/empleoyes.csv');
    final content = await file.readAsString(encoding: utf8);

    final lines = const LineSplitter().convert(content);

    List<String> select = [];

    for (int i = 0; i < lines.length; i++) {

      select = lines[i].split(";");

      empleoyes.add(Empleoye(
        id: select[0],
        name: select[1],
        idFactory: select[2],
      ));
    }
  } catch (e) {
    print('Error reading CSV file empleoye: $e');
  }

  return empleoyes;
}