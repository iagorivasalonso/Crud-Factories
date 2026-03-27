import 'dart:convert';
import 'dart:io';
import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:crud_factories/Alertdialogs/confirm.dart';
import 'package:crud_factories/Alertdialogs/error.dart';
import 'package:crud_factories/Alertdialogs/noFind.dart' show noFind;
import 'package:crud_factories/Backend/CSV/exportEmpleoyes.dart';
import 'package:crud_factories/Backend/CSV/exportRoutes.dart';
import 'package:crud_factories/Backend/CSV/exportSectors.dart';
import 'package:crud_factories/Backend/CSV/importConections.dart';
import 'package:crud_factories/Backend/CSV/importFactories.dart';
import 'package:crud_factories/Backend/CSV/importMails.dart';
import 'package:crud_factories/Backend/CSV/importRoutes.dart';
import 'package:crud_factories/Backend/CSV/importSectors.dart' show readSectorsFromCsv, csvImportSectors, readSectorsFromCsvContent;
import 'package:crud_factories/Backend/Global/controllers/List.dart' show ListController;
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
import 'package:crud_factories/Functions/createId.dart';
import 'package:crud_factories/Objects/Empleoye.dart';
import 'package:crud_factories/Objects/Factory.dart';
import 'package:crud_factories/Objects/LineSend.dart';
import 'package:crud_factories/Widgets/headViewsAndroid.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:file_picker/file_picker.dart' show FilePickerResult, FileType, FilePicker;
import 'package:flutter/material.dart';
import '../Backend/CSV/ImportGeneral/CsvProcessorService.dart';
import '../Functions/isNotAndroid.dart';
import '../Widgets/CSVPickerField.dart';
import '../Widgets/headView.dart';
import '../Widgets/materialButton.dart';
import '../helpers/localization_helper.dart';

class newImport extends StatefulWidget {


    newImport();
  @override
  State<newImport> createState() => _newImportState();
}

class _newImportState extends State<newImport> {

  final ScrollController horizontalScroll = ScrollController();
  final ScrollController verticalScroll = ScrollController();

  double widthBar = 10.0;
  int idEndList = 0;


  late TextEditingController controllerImportPicker = TextEditingController();

  @override
  void initState (){

     if(idEndList == 0)
     {
       for(int i = 0; i < allFactories.length; i++)
       {
         idEndList = int.parse(allFactories[i].id);
       }
     }

  }
  @override
  Widget build(BuildContext context0) {

    BuildContext context = isNotAndroid() ? context0 :  context1;


    return  !isNotAndroid()
        ? Scaffold(
           body: AdaptiveScrollbar(
        controller: verticalScroll,
        width: widthBar,
        child: AdaptiveScrollbar(
          controller: horizontalScroll,
          width: widthBar,
          position: ScrollbarPosition.bottom,
          underSpacing: EdgeInsets.only(bottom: 8),
          child: SingleChildScrollView(
            controller: verticalScroll,
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              controller: horizontalScroll,
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: 770,
                height: 470,
                child: Align(
                  alignment: Alignment.topLeft,
                  child:  Padding(
                    padding: const EdgeInsets.only(left: 30.0,top: 30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        headView(
                            title: S.of(context).import_data
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top:10.0, bottom: 30.0),
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
                          padding: const EdgeInsets.only(left: 500.0, top: 260.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: materialButton(
                                    nameAction: S.of(context).import_data,
                                    function: () => _onSaveList(context)
                                ),
                              ),

                              Flexible(
                                child: Padding(
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
    )
        : Scaffold(
            appBar: appBarAndroid(context, name: S.of(context).import_data),
            body: Text("conection"),
       );
  }

}
Future<void> _pickFile(BuildContext context, TextEditingController controllerDatePicker) async {


  FilePickerResult? result =  await FilePicker.platform.pickFiles(
    dialogTitle: S.of(context).select_file,
    type: FileType.custom,
    allowedExtensions: ['csv'],
  );

  if(result == null) return;



  final platformFile = result.files.single;

  String content;

  if (platformFile.bytes != null) {
    // Web y algunas plataformas
    content = utf8.decode(platformFile.bytes!);
  } else if (platformFile.path != null) {
    // Android / Desktop
    final file = File(platformFile.path!);
    content = await file.readAsString(encoding: utf8);
  } else {
    throw Exception("No se pudo leer el archivo CSV");
  }
  // Procesamos el CSV para llenar los listController
  CsvProcessorService.processCsvContent(context, content, true);

  // Actualizamos el TextField con el nombre del archivo
  controllerDatePicker.text = platformFile.name;

  // Forzamos rebuild para que se vea reflejado en la UI
  if (context.mounted) {
   // setState(() {});
  }

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
print(results.toString());
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

  print('Sectors new: ${listController.sectorsNew}');
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

void _showImportSumary(BuildContext context, List<ImportResult> results) async{
print("resu$results");
      final success = results.where((r) => r.inserted > 0).toList();
      final errors = results.expand((r) => r.errors).toList();
print("deasfd$success");
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





abstract class BaseEntity {
  late String id;
}

Future<int> processImport<T extends BaseEntity>({
      required List<T> newList,
      required List<T> existingList,
      required String Function(T) getKey,
      required void Function(T, String) setId,
      required Future<void> Function(List<T>) csvExport,
      Future<void> Function(List<T>)? sqlExport,
      dynamic conn,
}) async {

  int count = 0;

  for(final iten in newList) {
    bool exists = existingList.any((x) => getKey(x) == getKey(iten));

    if (!exists)
    {
      final maxId = existingList.isNotEmpty
          ? existingList.map((e) => int.parse(e.id)).reduce((a, b) => a > b ? a : b)
          : 0;

      setId(iten, (maxId + 1).toString());

      existingList.add(iten);
      count++;
    }
  }
    if (count > 0) {
      if (conn != null && sqlExport != null) {
        await sqlExport(newList);
      } else {
        await csvExport(existingList);
      }
  }
    return count;
}


class ImportResult {

   final String entity;
   int inserted;
   List<String> errors;

   ImportResult({
       required this.entity,
       this.inserted = 0,
       List<String>? errors,
   }) : errors = errors ?? [];


   @override
   String toString() {
     return 'ImportResult(entity: $entity, inserted: $inserted, errors: $errors)';
   }
}