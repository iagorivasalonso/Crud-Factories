

import 'dart:convert';

import 'package:crud_factories/Backend/CSV/csvParse.dart' show csvParse;
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
      String? _fileName;

      void clear() {
        _content = null;
      }

      Future<List<ImportResult>> importAll({
        required BuildContext context,
      }) async {

        if (_content == null || _fileName == null) {
          return [];
        }

        final results = <ImportResult>[];

        switch (_fileName) {

          case 'routes.csv':
            final data = csvParse.parseRoutes(_content!);

            results.add(
              await routesProvider.import(
                context: context,
                routesNew: data,
              ),
            );
            break;

          case 'connections.csv':
            final data = readconnectionsFromCsvContent(_content!);

            results.add(
              await connectionController.import(
                context: context,
                connectionsNew: data,
              ),
            );
            break;

          case 'sectors.csv':
            final data = readSectorsFromCsvContent(_content!);

            results.add(
              await sectorProvider.import(
                context: context,
                sectorsNew: data,
              ),
            );
            break;

          case 'factories.csv':
            final data = readFactoriesFromCsvContent(_content!);

            results.add(
              await factoryProvaider.import(
                context: context,
                factoriesNew: data,
              ),
            );
            break;

          case 'employees.csv':
            final data = readEmployeeFromCsvContent(_content!);

            results.add(
              await employeeProvider.import(
                context: context,
                EmployeesNews: data,
              ),
            );
            break;

          case 'lines.csv':
            final data = readLinesFromCsvContent(_content!);

            results.add(
              await lineProvider.import(
                context: context,
                linesNew: data,
              ),
            );
            break;

          case 'mails.csv':
            final data = readMailsFromCsvContent(_content!);

            results.add(
              await mailProvider.import(
                context: context,
                mailsNew: data,
              ),
            );
            break;
        }

        return results;
      }


      Future<void> pickFile(
          BuildContext context,
          TextEditingController controllerDatePicker,
          ) async {

        FilePickerResult? result =
        await FilePicker.platform.pickFiles(
          dialogTitle: S.of(context).select_file,
          type: FileType.custom,
          allowedExtensions: ['csv'],
          withData: true,
        );

        if (result == null) return;

        final platformFile = result.files.single;

        if (platformFile.bytes == null) {
          throw Exception("No se pudo leer el archivo CSV");
        }

        _fileName = platformFile.name;
        _content = utf8.decode(platformFile.bytes!);

        controllerDatePicker.text = platformFile.name;
      }

}


