
import 'dart:convert';
import 'dart:io';
import 'package:crud_factories/Backend/CSV/importFactories.dart';
import 'package:file_picker/file_picker.dart' show PlatformFile;
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import '../../../Alertdialogs/error.dart';
import '../../../generated/l10n.dart';
import '../../Global/controllers/List.dart';
import '../../Global/list.dart';
import '../importConections.dart';
import '../importEmpleoyes.dart';
import '../importLines.dart';
import '../importMails.dart';
import '../importRoutes.dart';
import '../importSectors.dart';

Future<void> importFiles(  BuildContext context, PlatformFile platformFile) async {

  String ext = platformFile.name.split('.').last.toLowerCase();


    String content;
    String fullPath;


  if(ext == "csv") {

    if (kIsWeb) {
      content = utf8.decode(platformFile.bytes!);
      fullPath = platformFile.name;
    }
    else {
      final file = File(platformFile.path!);
      content = await file.readAsString(encoding: utf8);
      fullPath = platformFile.path!;
    }

    final lines = const LineSplitter().convert(content);
print(lines);
    final parts = lines.first.split(";");
          try {


                  switch (parts.length) {
                    case 2:
                        await csvImportSectors(context, listController.sectorsNew, content);
                      break;

                    case 3:
                      if (parts[1].contains("R")) {
                        await csvImportRoutes(
                            context, listController.routesNew, content);
                      } else {

                          await csvImportEmpleoyes(
                              context, listController.empleoyesNew, content);

                      }
                      break;

                    case 4:
                        await csvImportMails(context, listController.mailsNew, content);

                      break;

                    case 5:
                        await csvImportLines(context, listController.linesNew, content);
                      break;

                    case 6:
                        await csvImportConections(
                            context, listController.conectionsNew, content);

                      break;

                    case 14:
                        await csvImportFactories(
                            context, listController.factoriesNew, content);

                      break;

                    default:

                      break;
                  }
          }catch (e) {
                 error(context, S.of(context).file_not_found);
          }
   }



  }

