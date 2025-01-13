import 'dart:convert';
import 'dart:io';
import 'package:crud_factories/Backend/data.dart';
import 'package:crud_factories/Objects/Sector.dart';

csvImportSectors(List<String> fileContent, List<Sector> sectors) async{

  try {

    final content = await fSectors.readAsString(encoding: utf8);

    final lines = const LineSplitter().convert(content);

    List<String> select = [];

    for (int i = 0; i < lines.length; i++) {

      select = lines[i].split(";");
      sectors.add(Sector(
          id: select[0],
          name: select[1]
      ));
    }

  } catch (e) {
    print('Error reading CSV file sectors: $e');
  }






    return sectors;
}