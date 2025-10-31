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
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../Backend/CSV/importEmpleoyes.dart';
import '../Backend/CSV/importLines.dart';
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

  TextEditingController controllerDatePicker = new TextEditingController();

  late ListController listController;

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

    BuildContext context = Platform.isWindows ? context1 : context0;


    return Platform.isWindows
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
              child: Container(
                height: 400,
                width: 736,
                child: Align(
                  alignment: Alignment.topLeft,
                  child:  Padding(
                    padding: const EdgeInsets.only(left: 30.0,top: 30.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(S.of(context).import_data,
                              style: TextStyle(fontWeight: FontWeight.bold),),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 15.00),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(S.of(context).Import_data_in_CSV_format),
                                ],
                              ),
                            ],
                          ),

                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:80.0, bottom: 30.0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right:10),
                                child: Text(S.of(context).route),
                              ),
                              SizedBox(
                                width: 420,
                                height: 40,
                                child: TextField(
                                  decoration:const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  controller: controllerDatePicker,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 40.0),
                                child: MaterialButton(
                                  color: Colors.lightBlue,
                                  child: Text(S.of(context).examine,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  onPressed: (){
                                    _pickFile(context, controllerDatePicker,listController);
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 130.0,left: 400),
                          child: SizedBox(
                            width: 250,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MaterialButton(
                                  color: Colors.lightBlue,
                                  child: Text(S.of(context).import_data,
                                   style:  const TextStyle(color: Colors.white) ,),
                                  onPressed: ()=> _onSaveList(context,listController)
                                ),
                                MaterialButton(
                                  color: Colors.lightBlue,
                                  child: Text(S.of(context).delete,
                                    style: const TextStyle(color: Colors.white),),
                                  onPressed: () {
                                    setState(() {
                                      controllerDatePicker.text = "";
                                    });
                                  },
                                ),
                              ],
                            ),
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

Future<void> _onSaveList(BuildContext context, ListController listController) async {


  int count = 0;
  List<String> stringDialog = [];

  Map<String,int> importedCount = {};

  if (listController.routesNew.isNotEmpty)
  {
    final entityName = S.of(context).routes;
    count += await processImport(
      newList: listController.routesNew,
      existingList: routesManage,
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

Future<void> _pickFile(BuildContext context, TextEditingController controllerDatePicker, ListController listController) async {


  FilePickerResult? result =  await FilePicker.platform.pickFiles(
    dialogTitle: 'select file',
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


