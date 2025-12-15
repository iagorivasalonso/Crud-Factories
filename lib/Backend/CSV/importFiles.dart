
import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart' show PlatformFile;
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import '../../Alertdialogs/error.dart';
import '../../generated/l10n.dart';
import 'importConections.dart';
import 'importMails.dart';
import 'importRoutes.dart';
import 'importSectors.dart';

Future<void> importFiles(BuildContext context, PlatformFile platformFile, listController, [index]) async {

  String ext = platformFile.name.split('.').last.toLowerCase();

  if(ext == "csv")
  {
    try {
      String content;
      String fullPath;


      if (kIsWeb) {
        content = utf8.decode(platformFile.bytes!);
        fullPath = platformFile.name;
      }
      else {
        final file = File(platformFile.path!);
        content = await file.readAsString(encoding: utf8);
        fullPath = platformFile.path!;
      }

      listController[index].router.text = fullPath;

      final lines = const LineSplitter().convert(content);
      final parts = lines.first.split(";");

      switch (parts) {
        case 0:
          if (kIsWeb) {
            await csvImportRoutes(context, listController.routesNew, content);
          }
          else {
            listController.routesNew.addAll(
                await readRoutesFromCsvContent(content));
          }

          break;

        case 1:
          if (kIsWeb) {
            await csvImportConections(
                context, listController.conectionsNew, content);
          }
          else {
            listController.conectionsNew.addAll(
                await readConectionsFromCsvContent(content));
          }

          break;

        case 3:
          if (kIsWeb) {
            await csvImportSectors(context, listController.sectorsNew, content);
          }
          else {
            listController.sectorsNew.addAll(
                await readSectorsFromCsvContent(content));
          }

          break;

        case 7:
          if (kIsWeb) {
            await csvImportMails(context, listController.mailsNew, content);
          }
          else {
            listController.mailsNew.addAll(
                await readMailsFromCsvContent(content));
          }
          break;

        default:
          String action = S.of(context).file_not_found;
          error(context, action);
          break;
      }
    } catch (e) {
      error(context, S.of(context).file_not_found);
    }
  }
}