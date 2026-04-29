

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
  static Future<void> processCsContent(
      BuildContext context,
      String content
      ) async {

    try {
      // 🔥 NORMALIZACIÓN WEB (CRÍTICO)
      final normalized = content
          .replaceAll('\r\n', '\n')
          .replaceAll('\r', '\n')
          .replaceAll('\ufeff', '');

      final lines = normalized
          .split('\n')
          .where((l) => l.trim().isNotEmpty)
          .toList();

      if (lines.isEmpty) {
        error(context, "CSV vacío");
        return;
      }

      final parts = lines.first.split(';');

      print("CSV FIRST LINE: ${lines.first}");
      print("CSV PARTS LENGTH: ${parts.length}");

      if (parts.isEmpty) {
        error(context, "CSV inválido");
        return;
      }

      switch (parts.length) {

        case 2:

            listController.sectorsNew =
            await readSectorsFromCsvContent(content);

          break;

        case 3:
          if (parts[1].contains("R")) {
            listController.routesNew = await readRoutesFromCsvContent(content);
          } else {
              listController.empleoyesNew =
              await readEmpleoyeFromCsvContent(content);

          }
          break;

        case 4:

            listController.mailsNew =
            await readMailsFromCsvContent(content);

          break;

        case 5:

            listController.linesNew =
            await readLinesFromCsvContent(content);

          break;

        case 6:

            listController.conectionsNew =
            await readConectionsFromCsvContent(content);

          break;

        case 14:

            listController.factoriesNew =
            await readFactoriesFromCsvContent(content);

          break;

        default:
          break;
      }

    } catch (e) {
      error(context, S.of(context).file_not_found);
    }
  }
  }







