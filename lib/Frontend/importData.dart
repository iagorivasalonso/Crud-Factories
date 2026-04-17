import 'dart:convert';
import 'package:crud_factories/Alertdialogs/confirm.dart';
import 'package:crud_factories/Alertdialogs/noFind.dart' show noFind;
import 'package:crud_factories/Backend/CSV/ImportGeneral/import_Processor.dart' show processImport;
import 'package:crud_factories/Backend/CSV/exportEmpleoyes.dart';
import 'package:crud_factories/Backend/CSV/exportRoutes.dart';
import 'package:crud_factories/Backend/CSV/exportSectors.dart';
import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Backend/SQL/createEmpleoye.dart';
import 'package:crud_factories/Backend/SQL/createFactory.dart';
import 'package:crud_factories/Backend/SQL/createLine.dart';
import 'package:crud_factories/Backend/SQL/createMail.dart';
import 'package:crud_factories/Backend/SQL/createSector.dart';
import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Backend/CSV/exportConections.dart';
import 'package:crud_factories/Backend/CSV/exportFactories.dart';
import 'package:crud_factories/Backend/CSV/exportLines.dart';
import 'package:crud_factories/Backend/CSV/exportMails.dart';
import 'package:crud_factories/Objects/importResult.dart' show ImportResult;
import 'package:crud_factories/Widgets/headViewsAndroid.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:file_picker/file_picker.dart' show FilePickerResult, FileType, FilePicker;
import 'package:flutter/material.dart';
import 'package:crud_factories/Backend/CSV/ImportGeneral/CsvProcessorService.dart';
import 'package:crud_factories/Functions/isNotAndroid.dart';
import 'package:crud_factories/Widgets/CSVPickerField.dart';
import 'package:crud_factories/Widgets/headView.dart';
import 'package:crud_factories/Widgets/materialButton.dart';
import 'package:crud_factories/helpers/localization_helper.dart';

class newImport extends StatefulWidget {


    newImport();
  @override
  State<newImport> createState() => _newImportState();
}

class _newImportState extends State<newImport> {

  final ScrollController horizontalScroll = ScrollController();
  final ScrollController verticalScroll = ScrollController();

  late TextEditingController controllerImportPicker = TextEditingController();

  @override
  void initState (){
    super.initState();

  }
  @override
  Widget build(BuildContext context0) {

    BuildContext context = isNotAndroid() ? context0 :  context1;

    return !isNotAndroid()
        ? Scaffold(
      body: Scrollbar(
        controller: verticalScroll,
        thumbVisibility: true,
        child: Scrollbar(
          controller: horizontalScroll,
          thumbVisibility: true,
          notificationPredicate: (notification) =>
          notification.metrics.axis == Axis.horizontal,
          child: SingleChildScrollView(
            controller: verticalScroll,
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              controller: horizontalScroll,
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(left: 30.0, top: 30.0),
                child: Container(
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width,
                    minHeight: MediaQuery.of(context).size.height,
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                      width: 680,
                      child: Column(
                        children: [
                          headView(
                              title: S.of(context).import_data
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top:10.0,bottom: 30.0),
                            child: Row(
                              children: [
                                Text(S.of(context).Import_data_in_CSV_format)
                              ] ,
                            ),
                          ),

                              SizedBox(
                                width: 700,
                                child: CSVPickerField(
                                    controller: controllerImportPicker,
                                    campName: S.of(context).route,
                                    actionName: S.of(context).examine,
                                    function: () => _pickFile(context, controllerImportPicker)
                                ),
                              ),

                             Padding(
                                padding: const EdgeInsets.only(left: 450.0, top: 260.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    materialButton(
                                        nameAction: S.of(context).import_data,
                                        function: () => _onSaveList(context)
                                    ),

                                   Padding(
                                        padding: const EdgeInsets.only(left: 20.0),
                                        child: materialButton(
                                          nameAction:S.of(context).delete,
                                          function: () async{
                                            setState(() {
                                              controllerImportPicker.text = "";
                                            });
                                          },

                                        ),
                                      ),
                                  ],
                                ),
                              ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    )
        : Scaffold(
      appBar: appBarAndroid(context, name: S.of(context).sending_mails),
      body: Text("creart email"),
    );

  }

}

Future<void> _pickFile(BuildContext context, TextEditingController controllerDatePicker) async {


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

  final String content = utf8.decode(platformFile.bytes!);

// Procesamos el CSV
  await CsvProcessorService.processCsvContent(context, content, true);

// Actualizamos el TextField
  controllerDatePicker.text = platformFile.name;


}


Future<void> _onSaveList(BuildContext context) async {

  List<ImportResult> results = [];

  results.add(await _importSectors(context));      // primero sectores
  results.add(await _importFactories(context));    // luego factories
  results.add(await _importRoutes(context));       // después routes
  results.add(await _importEmployees(context));    // luego employees
  results.add(await _importLines(context));        // luego lines
  results.add(await _importMails(context));        // luego mails
  results.add(await _importConnections(context));  // finalmente connections

  _showImportSumary(context, results);
}

Future<ImportResult> _importRoutes(BuildContext context) async {

  final result = ImportResult(entity: S.of(context).routes);

  if (listController.routesNew.isEmpty) return result;

  result.inserted = await processImport(
    newList: listController.routesNew,
    existingList: routesCSV,
    getKey: (r) => r.route,
    setId: (r, id) => r.id = id,
    csvExport: csvExportatorRoutes,
    conn: executeQuery,
  );

  return result;
}

Future<ImportResult> _importSectors(BuildContext context) async {

  final result = ImportResult(entity: S.of(context).sectors);

  if (listController.sectorsNew.isEmpty) return result;


  result.inserted = await processImport(
    newList: listController.sectorsNew,
    existingList: sectors,
    getKey: (s) => s.name,
    setId: (s, id) => s.id = id,
    csvExport: csvExportatorSectors,
    sqlExport: sqlCreateSector,
    conn: executeQuery,
  );

  return result;
}

Future<ImportResult> _importEmployees(BuildContext context) async {

  final result = ImportResult(entity: S.of(context).employees);

  if (listController.empleoyesNew.isEmpty) return result;

  if (allFactories.isEmpty) {
    result.errors.add(
      LocalizationHelper.fieldInAnother(
        context,
        result.entity.toLowerCase(),
        S.of(context).companies.toLowerCase(),
      ),
    );
    return result;
  }

  final valid = listController.empleoyesNew
      .where((e) => allFactories.any((f) => f.id == e.idFactory))
      .toList();

  final invalid = listController.empleoyesNew
      .where((e) => !allFactories.any((f) => f.id == e.idFactory))
      .toList();

  if (valid.isNotEmpty) {
    result.inserted = await processImport(
      newList: valid,
      existingList: empleoyes,
      getKey: (e) => e.name,
      setId: (e, id) => e.id = id,
      csvExport: csvExportatorEmpleoyes,
      sqlExport: sqlCreateEmpleoye,
      conn: executeQuery,
    );
  }

  for (var e in invalid) {
    result.errors.add(
      LocalizationHelper.empleoyesBeFactory(context, e.name),
    );
  }

  return result;
}

Future<ImportResult> _importMails(BuildContext context) async {

  final result = ImportResult(entity: S.of(context).mails);

  if (listController.mailsNew.isEmpty) return result;

  result.inserted = await processImport(
    newList: listController.mailsNew,
    existingList: mails,
    getKey: (m) => m.address,
    setId: (m, id) => m.id = id,
    csvExport: csvExportatorMails,
    sqlExport: sqlCreateMail,
    conn: executeQuery,
  );

  return result;
}

Future<ImportResult> _importLines(BuildContext context) async {

  final result = ImportResult(entity: S.of(context).lines);

  if (listController.linesNew.isEmpty) return result;

  if (allFactories.isEmpty) {
    result.errors.add(
      LocalizationHelper.fieldInAnother(
        context,
        result.entity.toLowerCase(),
        S.of(context).companies.toLowerCase(),
      ),
    );
    return result;
  }

  final valid = listController.linesNew
      .where((l) => allFactories.any((f) => f.name == l.factory))
      .toList();

  final invalid = listController.linesNew
      .where((l) => !allFactories.any((f) => f.name == l.factory))
      .toList();

  if (valid.isNotEmpty) {
    result.inserted = await processImport(
      newList: valid,
      existingList: allLines,
      getKey: (l) => l.factory,
      setId: (l, id) => l.id = id,
      csvExport: csvExportatorLines,
      sqlExport: (lines) => sqlCreateLine(lines, context),
      conn: executeQuery,
    );
  }

  for (var l in invalid) {
    result.errors.add(
      LocalizationHelper.factoryBeSector(context, l.factory),
    );
  }

  return result;
}

Future<ImportResult> _importConnections(BuildContext context) async {

  final result = ImportResult(entity: S.of(context).connection);

  if (listController.conectionsNew.isEmpty) return result;

  result.inserted = await processImport(
    newList: listController.conectionsNew,
    existingList: conections,
    getKey: (c) => c.database,
    setId: (c, id) => c.id = id,
    csvExport: csvExportatorConections,
    sqlExport: null,
    conn: executeQuery,
  );

  return result;
}

Future<ImportResult> _importFactories(BuildContext context) async {

  final result = ImportResult(entity: S.of(context).company);

  if (listController.factoriesNew.isEmpty) return result;

  if (sectors.isEmpty) {
    result.errors.add(
      LocalizationHelper.fieldInAnother(
        context,
        result.entity.toLowerCase(),
        S.of(context).sector.toLowerCase(),
      ),
    );
    return result;
  }

  final valid = listController.factoriesNew
      .where((f) => sectors.any((s) => s.id == f.sector))
      .toList();

  final invalid = listController.factoriesNew
      .where((f) => !sectors.any((s) => s.id == f.sector))
      .toList();

  if (valid.isNotEmpty) {
    result.inserted = await processImport(
      newList: valid,
      existingList: allFactories,
      getKey: (f) => f.name,
      setId: (f, id) => f.id = id,
      csvExport: csvExportatorFactories,
      sqlExport: sqlCreateFactory,
      conn: executeQuery,
    );
  }

  for (var f in invalid) {
    result.errors.add(
      LocalizationHelper.factoryBeSector(context, f.name),
    );
  }

  return result;
}

void _showImportSumary(BuildContext context, List<ImportResult> results) async {

      final success = results.where((r) => r.inserted > 0).toList();
      final errors = results.expand((r) => r.errors).toList();

      String summaryText = '';

      if (success.isNotEmpty) {
            final message = success
                .map((e) => LocalizationHelper.importData(context, e.entity, e.inserted))
                .join('\n');
            summaryText += message;
            print(message);
            confirm(context, message);
      }

      if (errors.isNotEmpty) {
          final errorMessage = errors.join('\n');
          summaryText += (summaryText.isNotEmpty ? '\n\n' : '') + errorMessage;
          await noFind(context, true, errorMessage);
      }

}


