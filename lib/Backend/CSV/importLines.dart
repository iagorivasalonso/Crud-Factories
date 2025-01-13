import 'dart:convert';
import 'dart:io';
import 'package:crud_factories/Backend/data.dart';
import 'package:crud_factories/Objects/LineSend.dart';


csvImportLines(List<String> fileContent, List<LineSend> line ) async {

  try {
    final content = await fLines.readAsString(encoding: utf8);

    final lines1 = const LineSplitter().convert(content);

    List<String> select = [];

    for (int i = 0; i < lines1.length; i++) {

      select = lines1[i].split(";");

      line.add(LineSend(
          id: select[0],
          date:select[1],
          factory:select[2] ,
          observations: select[3] ,
          state: select[4]));
    }
  } catch (e) {
    print('Error reading CSV file lines: $e');
  }
  return line;
}