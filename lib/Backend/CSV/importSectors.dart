import 'dart:convert';
import 'dart:io';
import 'package:crud_factories/Backend/Global/files.dart';
import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Objects/Sector.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:fluent_ui/fluent_ui.dart';


Future<void> csvImportSectors(BuildContext context, List<Sector> sector, [dynamic fileOrContent]) async {

  try {

    List<Sector> imported;

    if (fileOrContent == null)
    {
      imported = await readSectorsFromCsv(fSectors);
    }
    else if (fileOrContent is File)
    {
      imported = await readSectorsFromCsv(fileOrContent);
    }
    else if (fileOrContent is String)
    {
      imported = await readSectorsFromCsvContent(fileOrContent);
    }
    else
    {
      throw Exception("Invalid value");
    }
    sectors.addAll(imported);

  } catch (e) {
    String array = S.of(context).sectors;

    if(e.toString().contains("El sistema no puede encontrar el archivo especificado")) {
      errorFiles.add("${S.of(context).file_not_found} $array");
    }
    else if(e.toString().contains("Invalid value")) {
      errorFiles.add("${S.of(context).file_format_error} $array");
    }
  }
}

Future<List<Sector>> readSectorsFromCsv(File file) async {

  final content = await file.readAsString(encoding: utf8);
  return readSectorsFromCsvContent(content);
}


Future<List<Sector>> readSectorsFromCsvContent(String content) async {

  final lines = const LineSplitter()
      .convert(content)
      .where((line) => line.trim().isNotEmpty)
      .toList();

  final sector = <Sector>[];

   for( final line in lines) {
     final parts = line.split(";");
     if (parts.length < 2) continue;
     sector.add(Sector(
       id: parts[0].trim(),
       name: parts[1].trim(),
     ));
   }

   return sector;
}