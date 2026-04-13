

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
  static Future<void> processCsvContent(
      BuildContext context,
      String content,
      bool importOrtherFiles,
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
          if (!importOrtherFiles) {
            await csvImportSectors(context, listController.sectorsNew, content);
          } else {
            listController.sectorsNew =
            await readSectorsFromCsvContent(content);
          }
          break;

        case 3:
          if (parts[1].contains("R")) {
            await csvImportRoutes(context, listController.routesNew, content);
          } else {
            if (!importOrtherFiles) {
              await csvImportEmpleoyes(context, listController.empleoyesNew, content);
            } else {
              listController.empleoyesNew =
              await readEmpleoyeFromCsvContent(content);
            }
          }
          break;

        case 4:
          if (!importOrtherFiles) {
            await csvImportMails(context, listController.mailsNew, content);
          } else {
            listController.mailsNew =
            await readMailsFromCsvContent(content);
          }
          break;

        case 5:
          if (!importOrtherFiles) {
            await csvImportLines(context, listController.linesNew, content);
          } else {
            listController.linesNew =
            await readLinesFromCsvContent(content);
          }
          break;

        case 6:
          if (!importOrtherFiles) {
            await csvImportConections(context, listController.conectionsNew, content);
          } else {
            listController.conectionsNew =
            await readConectionsFromCsvContent(content);
          }
          break;

        case 14:
          if (!importOrtherFiles) {
            await csvImportFactories(context, listController.factoriesNew, content);
          } else {
            listController.factoriesNew =
            await readFactoriesFromCsvContent(content);
          }
          break;

        default:
          break;
      }

    } catch (e) {
      error(context, S.of(context).file_not_found);
    }
  }
  }







