
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

    final parts = lines.first.split(";");
          try {


                  switch (parts.length) {
                    case 2:
                        await csvImportSectors(context, listController.sectorsNew, content);
                      break;

                    case 3:
                      if (parts[1].contains("R")) {
                        if (kIsWeb) {
                          await csvImportRoutes(context, listController.routesNew, content);
                        }
                        else {
                          listController.routesNew.addAll(
                              await readRoutesFromCsvContent(content));
                        }
                      }
                      else {
                        if (kIsWeb) {
                          await csvImportEmpleoyes(
                              context, listController.empleoyesNew, content);
                        }
                        else {
                          listController.empleoyesNew.addAll(
                              await readEmpleoyeFromCsvContent(content));
                        }
                      }
                      break;

                    case 4:
                      if (kIsWeb) {
                        await csvImportMails(context, listController.mailsNew, content);
                      }
                      else {
                        listController.mailsNew.addAll(
                            await readMailsFromCsvContent(content));
                      }
                      break;

                    case 5:
                      if (kIsWeb) {
                        await csvImportLines(context, listController.linesNew, content);
                      }
                      else {
                        listController.linesNew.addAll(
                            await readLinesFromCsvContent(content));
                      }
                      break;

                    case 6:
                      if (kIsWeb) {
                        await csvImportConections(
                            context, listController.conectionsNew, content);
                      }
                      else {
                        listController.conectionsNew.addAll(
                            await readConectionsFromCsvContent(content));
                      }
                      break;

                    case 14:
                      if (kIsWeb) {
                        await csvImportFactories(
                            context, listController.factoriesNew, content);
                      }
                      else {
                        listController.factoriesNew.addAll(
                            await readFactoriesFromCsvContent(content));
                      }
                      break;

                    default:
                      String action = S.of(context).file_not_found;
                      error(context, action);
                      break;
                  }
          }catch (e) {
                 error(context, S.of(context).file_not_found);
          }
   }



  }

