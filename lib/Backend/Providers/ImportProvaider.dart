

import 'dart:convert';

import 'package:crud_factories/Backend/Feature/Connection/Controller/ConnectionController.dart' show ConnectionController;
import 'package:crud_factories/Backend/Feature/Connection/Datasource/importConections.dart' show readconnectionsFromCsvContent;
import 'package:crud_factories/Backend/Feature/Employee/importEmployee.dart' show readEmployeeFromCsvContent;
import 'package:crud_factories/Backend/Feature/Factory/importFactories.dart' show readFactoriesFromCsvContent;
import 'package:crud_factories/Backend/Feature/LineSend/importLineSend.dart' show readLinesFromCsvContent;
import 'package:crud_factories/Backend/Feature/Mail/importMail.dart' show readMailsFromCsvContent;
import 'package:crud_factories/Backend/Feature/Router/importRoutes.dart' show readRoutesFromCsvContent;
import 'package:crud_factories/Backend/Feature/Sector/importSectors.dart' show readSectorsFromCsvContent;
import 'package:crud_factories/Backend/Providers/EmployeeProvider.dart';
import 'package:crud_factories/Backend/Providers/FactoryProvider.dart';
import 'package:crud_factories/Backend/Providers/LineSendProvider.dart' show LineSendProvider;
import 'package:crud_factories/Backend/Providers/MailProvider.dart' show MailProvider;
import 'package:crud_factories/Backend/Providers/RoutesProvider.dart' show RoutesProvider;
import 'package:crud_factories/Backend/Providers/SectorProvider.dart';
import 'package:crud_factories/Objects/importResult.dart';
import 'package:crud_factories/generated/l10n.dart' show S;
import 'package:file_picker/file_picker.dart' show FilePicker, FileType, FilePickerResult;
import 'package:fluent_ui/fluent_ui.dart';


class ImportProvaider extends ChangeNotifier {

      final RoutesProvider routesProvider;
      final ConnectionController connectionController;
      final SectorProvider sectorProvider;
      final FactoryProvider factoryProvaider;
      final EmployeeProvider employeeProvider;
      final LineSendProvider lineProvider;
      final MailProvider mailProvider;

      ImportProvaider({
           required this.routesProvider,
           required this.connectionController,
           required this.sectorProvider,
           required this.factoryProvaider,
           required this.employeeProvider,
           required this.lineProvider,
           required this.mailProvider,
       });

      String? _content;

      void clear() {
        _content = null;
      }

      Future<String> importAll({
          required BuildContext context,

      }) async {

        if (_content == null) {
          return "";
        }

          final routesNews = readRoutesFromCsvContent(_content!);
          final connectionsNews = readconnectionsFromCsvContent(_content!);
          final sectorsNews = readSectorsFromCsvContent(_content!);
          final factoriesNews = readFactoriesFromCsvContent(_content!);
          final employeesNews = readEmployeeFromCsvContent(_content!);
          final linesNews = readLinesFromCsvContent(_content!);
          final mailsNews = readMailsFromCsvContent(_content!);

          final results = <ImportResult>[];

          results.add(await routesProvider.import(context: context, routesNew: routesNews));
          results.add(await connectionController.import(context: context, ConnectionsNew: connectionsNews));
          results.add(await sectorProvider.import(context: context, sectorsNew: sectorsNews));
          results.add(await factoryProvaider.import(context: context, factoriesNew: factoriesNews));
          results.add(await employeeProvider.import(context: context, EmployeesNews: employeesNews));
          results.add(await lineProvider.import(context: context, linesNew: linesNews));
          results.add(await mailProvider.import(context: context, mailsNew: mailsNews));

          return showImportSummary(
            results,
          );
      }
      Future<void> pickFile(BuildContext context, TextEditingController controllerDatePicker) async {


        FilePickerResult? result =  await FilePicker.platform.pickFiles(
          dialogTitle: S.of(context).select_file,
          type: FileType.custom,
          allowedExtensions: ['csv'],
          withData: true,
        );

        if(result == null) return;


        final platformFile = result.files.single;

// 🔥 SIEMPRE usamos bytes (multiplataforma)
        if (platformFile.bytes == null) {
          throw Exception("No se pudo leer el archivo CSV");
        }

        _content = utf8.decode(platformFile.bytes!);

// Actualizamos el TextField
        controllerDatePicker.text = platformFile.name;


      }

      String showImportSummary(List<ImportResult> results) {

        final imported = results.where((r) => r.inserted > 0);


         return imported
            .map((r) => "${r.entity}: ${r.inserted}")
            .join("\n");

      }
}

