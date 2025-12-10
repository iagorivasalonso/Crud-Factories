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
import 'package:crud_factories/Backend/CSV/importSectors.dart' show readSectorsFromCsv;
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
import '../Backend/CSV/importEmpleoyes.dart';
import '../Backend/CSV/importLines.dart';
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


  late ListController listController;

  late TextEditingController controllerImportPicker = TextEditingController();
  @override
  void initState (){

     listController = new ListController(
         routesNew: [],
         sectorsNew: [],
         empleoyesNew: [],
         mailsNew: [],
         linesNew: [],
         conectionsNew: [],
         factoriesNew: []);

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
                              function: () => _pickFile(context, controllerImportPicker, listController)
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
                                    function: () => _onSaveList(context, listController)
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
Future<void> _pickFile(BuildContext context, TextEditingController controllerDatePicker, ListController listController) async {


  FilePickerResult? result =  await FilePicker.platform.pickFiles(
    dialogTitle: S.of(context).select_file,
    type: FileType.custom,
    allowedExtensions: ['csv'],
  );

  if(result == null) return;

  final file = File(result.files.single.path!);


  controllerDatePicker.text =file.path!;

  final content = await file.readAsString(encoding: utf8);
  final linesSend = const LineSplitter().convert(content);
  final parts = linesSend.first.split(";");

  try{

    switch(parts.length)
    {
      case 2:
        listController.sectorsNew.addAll(await readSectorsFromCsv(file));
        break;

      case 3:
        if(file.path.contains('routes.csv'))
        {

          listController.routesNew.addAll(await readRoutesFromCsv(file));
        }
        else
        {
          listController.empleoyesNew.addAll(await readEmpleoyeFromCsv(file));
        }
        break;

      case 4:
        listController.mailsNew.addAll(await readMailsFromCsv(file));
        break;

      case 5:
        listController.linesNew.addAll(await readLinesFromCsv(file));
        break;

      case 6:
        listController.conectionsNew.addAll(await readConectionsFromCsv(file));
        break;

      case 14:
        listController.factoriesNew.addAll(await readFactoriesFromCsv(file));
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

Future<void> _onSaveList(BuildContext context, ListController listController) async {


  int count = 0;
  List<String> stringDialog = [];

  Map<String,int> importedCount = {};

  if (listController.routesNew.isNotEmpty)
  {
    final entityName = S.of(context).routes;
    count += await processImport(
      newList: listController.routesNew,
      existingList: routesCSV,
      getKey: (r) => r.route,
      setId: (r, id) => r.id = id,
      csvExport: csvExportatorRoutes,
      conn: conn,
    );
    importedCount[entityName] = count;
  }

  if (listController.sectorsNew.isNotEmpty)
  {
    final entityName = S.of(context).sectors;
    count += await processImport(
      newList: listController.sectorsNew,
      existingList: sectors,
      getKey: (s) => s.name,
      setId: (s, id) => s.id = id,
      csvExport: csvExportatorSectors,
      sqlExport: sqlCreateSector,
      conn: conn,
    );
    importedCount[entityName] = count;
  }

  if (listController.empleoyesNew.isNotEmpty)
  {
    final entityName = S.of(context).employees;
    List<Empleoye> tmp =
    listController.empleoyesNew.where((e) => allFactories.any((f)=> f.id == e.idFactory))
        .toList();

    List<Empleoye> empExc =
    listController.empleoyesNew.where((e) => !allFactories.any((f)=> f.id == e.idFactory))
        .toList();

    List<Empleoye> empleoyesNew = tmp;


    if (allFactories.isNotEmpty)
    {
      if(empleoyesNew.isNotEmpty)
      {
        count += await processImport(
          newList: empleoyesNew,
          existingList: empleoyes,
          getKey: (e) => e.name,
          setId: (e, id) => e.id = id,
          csvExport: csvExportatorEmpleoyes,
          sqlExport: sqlCreateEmpleoye,
          conn: conn,
        );
        importedCount[entityName] = count;
        if(empExc.isNotEmpty)
        {
          for(int i = 0; i <empExc.length; i++)
          {
            stringDialog.add(LocalizationHelper.empleoyesBeFactory(context, empExc[i].name));
          }
        }
      }
    }
    else
    {
       stringDialog.add(LocalizationHelper.fieldInAnother(context, entityName.toLowerCase(), S.of(context).companies.toLowerCase()));
    }

  }

  if (listController.mailsNew.isNotEmpty)
  {
    final entityName = S.of(context).mails;
    count += await processImport(
      newList: listController.mailsNew,
      existingList: mails,
      getKey: (m) => m.address,
      setId: (s, id) => s.id = id,
      csvExport: csvExportatorMails,
      sqlExport: sqlCreateMail,
      conn: conn,
    );
    importedCount[entityName] = count;
  }

  if (listController.linesNew.isNotEmpty)
  {
    final entityName = S.of(context).lines;
    List<LineSend> tmp =
    listController.linesNew.where((l) =>
        allFactories.any((e) => l.factory == e.name))
        .toList();

    List<LineSend> linesExcl =
    listController.linesNew.where((l) => !allFactories.any((e) => l.factory == e.name))
        .toList();


    List<LineSend> linesNew = tmp;

    if (allFactories.isNotEmpty)
    {
      if(linesNew.isNotEmpty)
      {
        count += await processImport(
          newList: linesNew,
          existingList: allLines,
          getKey: (l) => l.factory,
          setId: (e, id) => e.id = id,
          csvExport: csvExportatorLines,
          sqlExport: (lines) => sqlCreateLine(lines, context),
          conn: conn,
        );
        importedCount[entityName] = count;

        if(linesExcl.isNotEmpty)
        {
          for(int i = 0; i <linesExcl.length; i++)
          {
            stringDialog.add(LocalizationHelper.factoryBeSector(context, linesExcl[i].factory));
          }
        }
      }
    }
    else
    {
       stringDialog.add(LocalizationHelper.fieldInAnother(context, entityName.toLowerCase(), S.of(context).companies.toLowerCase()));
    }
  }

  if (listController.conectionsNew.isNotEmpty)
  {
    final entityName = S.of(context).connection;
    count += await processImport(
      newList: listController.conectionsNew,
      existingList: conections,
      getKey: (c) => c.database,
      setId: (c, id) => c.id = id,
      csvExport: csvExportatorConections,
      conn: conn,
    );
    importedCount[entityName] = count;
  }

  if (listController.factoriesNew.isNotEmpty)
  {
    final entityName = S.of(context).company;
    List<Factory> tmp = listController.factoriesNew.where((f) => sectors.any((e)=> f.sector == e.id))
        .toList();

    List<Factory> factExc = listController.factoriesNew.where((f) => !sectors.any((e)=> f.sector == e.id))
        .toList();

    List<Factory> factoriesNew = tmp;

       if(sectors.isNotEmpty)
       {
         if(listController.factoriesNew.isNotEmpty)
         {
           count += await processImport(
             newList: factoriesNew,
             existingList: allFactories,
             getKey: (f) => f.name,
             setId: (e, id) => e.id = id,
             csvExport: csvExportatorFactories,
             sqlExport: sqlCreateFactory,
             conn: conn,
           );
           importedCount[entityName] = count;
         }

         if(factExc.isNotEmpty)
         {
           for(int i = 0; i <factExc.length; i++)
           {
             stringDialog.add(LocalizationHelper.factoryBeSector(context, factExc[i].name));
           }
         }
       }
       else
       {
         stringDialog.add(LocalizationHelper.fieldInAnother(context, entityName.toLowerCase(), S.of(context).sector.toLowerCase()));
       }
  }



  if(count > 0 && importedCount.isNotEmpty)
  {
        String message = importedCount.entries
                    .map((e) => LocalizationHelper.importData(context,e.key,e.value))
                    .join();

        confirm(context,message);
  }
  else
  {
       for (int i = 0; i<stringDialog.length; i++)
       {
           await noFind(context, true, stringDialog[i]);
       }
  }
  stringDialog.clear();
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

      setId(
          iten,
          existingList.isNotEmpty ? createId(existingList.last.id) : "1"
      );
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


