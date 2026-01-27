

import 'dart:convert';

import 'package:fluent_ui/fluent_ui.dart';

import '../../../Alertdialogs/error.dart';
import '../../../generated/l10n.dart';
import '../../Global/list.dart';
import '../importConections.dart';
import '../importEmpleoyes.dart';
import '../importFactories.dart';
import '../importLines.dart';
import '../importMails.dart';
import '../importRoutes.dart';
import '../importSectors.dart';

class CsvProcessorService {

  static  processCsvContent(BuildContext context, String content, bool importOrtherFiles) async {
    String fullPath;

    final lines = const LineSplitter().convert(content);
    final parts = lines.first.split(";");
    try {
              switch (parts.length) {
              case 2:
                    if (importOrtherFiles ==  false)
                    await csvImportSectors(context, listController.sectorsNew, content);
                    else
                    listController.sectorsNew.addAll(await readSectorsFromCsvContent(content));
                    break;

              case 3:
                    if (parts[1].contains("R")) {
                    await csvImportRoutes(context, listController.routesNew, content);
                    } else {
                    if (importOrtherFiles ==  false)
                    await csvImportEmpleoyes(context, listController.empleoyesNew, content);
                    else
                    listController.empleoyesNew.addAll(await readEmpleoyeFromCsvContent(content));
                    }
              break;

              case 4:
                  if (importOrtherFiles ==  false)
                  await csvImportMails(context, listController.mailsNew, content);
                  else
                  listController.mailsNew.addAll(await readMailsFromCsvContent(content));
              break;

              case 5:
                  if (importOrtherFiles ==  false)
                  await csvImportLines(context, listController.linesNew, content);
                  else
                  listController.linesNew.addAll(await readLinesFromCsvContent(content));
              break;

              case 6:
                  if (importOrtherFiles ==  false)
                  await csvImportConections(context, listController.conectionsNew, content);
                  else
                  listController.conectionsNew.addAll(await readConectionsFromCsvContent(content));
                  break;

              case 14:

                  if (importOrtherFiles ==  false)
                  await csvImportFactories(context, listController.factoriesNew, content);
                  else
                  listController.factoriesNew.addAll(await readFactoriesFromCsvContent(content));

              break;

              default:

              break;
              }
    }catch (e) {
      error(context, S.of(context).file_not_found);
    }

      }
  }







