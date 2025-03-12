import 'dart:convert';
import 'package:crud_factories/Backend/Global/files.dart';
import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Objects/Sector.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:fluent_ui/fluent_ui.dart';


csvImportSectors(BuildContext context, List<String> fileContent, List<Sector> sectors) async {

  try {

    final content = await fSectors.readAsString(encoding: utf8);
    final lines = const LineSplitter().convert(content);

    for (int i = 0; i < lines.length; i++)
    {
      List<String> select  = lines[i].split(";");

          sectors.add(Sector(
              id: select[0].trim(),
              name: select[1].trim()
          ));
    }

  } catch (e) {
    String array = S.of(context).sectors;

    if(e.toString().contains("El sistema no puede encontrar el file especificado"))
    {
      String noFile =  S.of(context).file_not_found;
      errorFiles.add("$noFile $array");
    }
    else
    {
      if(e.toString().contains("Invalid value"))
      {
        String errorFile =  S.of(context).file_format_error;
        errorFiles.add("$errorFile $array");
      }
    }
  }

    return sectors;
}