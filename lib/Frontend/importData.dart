import 'dart:convert';
import 'dart:io';
import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:crud_factories/Alertdialogs/confirm.dart';
import 'package:crud_factories/Alertdialogs/error.dart';
import 'package:crud_factories/Alertdialogs/noFind.dart';
import 'package:crud_factories/Backend/CSV/exportEmpleoyes.dart';
import 'package:crud_factories/Backend/CSV/exportRoutes.dart';
import 'package:crud_factories/Backend/CSV/exportSectors.dart';
import 'package:crud_factories/Backend/CSV/importConections.dart';
import 'package:crud_factories/Backend/CSV/importEmpleoyes.dart';
import 'package:crud_factories/Backend/CSV/importFactories.dart';
import 'package:crud_factories/Backend/CSV/importMails.dart';
import 'package:crud_factories/Backend/CSV/importRoutes.dart';
import 'package:crud_factories/Backend/CSV/importSectors.dart' show readSectorsFromCsv;
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
import 'package:crud_factories/Objects/Conection.dart';
import 'package:crud_factories/Objects/Empleoye.dart';
import 'package:crud_factories/Objects/Factory.dart';
import 'package:crud_factories/Objects/Mail.dart';
import 'package:crud_factories/Objects/LineSend.dart';
import 'package:crud_factories/Objects/Sector.dart';
import 'package:crud_factories/Widgets/headViewsAndroid.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../Backend/CSV/importLines.dart';
import '../Objects/RouteCSV.dart' show RouteCSV;
import '../helpers/localization_helper.dart';

class newImport extends StatefulWidget {


    newImport();
  @override
  State<newImport> createState() => _newImportState();
}

class _newImportState extends State<newImport> {

  final ScrollController horizontalScroll = ScrollController();
  final ScrollController verticalScroll = ScrollController();

  TextEditingController controllerDatePicker = new TextEditingController();

  double widthBar = 10.0;
  int idEndList = 0;

  @override
  Widget build(BuildContext context0) {

    BuildContext context = Platform.isWindows ? context1 : context0;

    List<Sector> sectorsNew = [];

    List<Empleoye> empleoyesNew = [];
    List<RouteCSV> routesNew = [];
    List<Mail> mailsNew = [];
    List<LineSend> linesNew = [];
    List<Conection> conectionsNew = [];
    List<Factory> factoriesNew =[];
    if(idEndList == 0)
    {
      for(int i = 0; i < allFactories.length; i++)
      {
        idEndList = int.parse(allFactories[i].id);
      }
    }

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
                                    _pickFile(context, controllerDatePicker,routesNew,sectorsNew,factoriesNew,empleoyesNew,mailsNew,linesNew,conectionsNew);
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
                                  onPressed: () async {
                                    String array = '';
                                    int count = 0;
                                    String action = "";

                                    if (routesNew.isNotEmpty)
                                    {
                                        array = S.of(context).routes;
                                        count += await processImport(
                                          newList: routesNew,
                                          existingList: routesManage,
                                          getKey: (r) => r.route,
                                          setId: (r, id) => r.id = id,
                                          csvExport: csvExportatorRoutes,
                                          conn: conn,
                                      );
                                    }

                                    if (sectorsNew.isNotEmpty)
                                    {
                                        array = S.of(context).sectors;
                                        count += await processImport(
                                          newList: sectorsNew,
                                          existingList: sectors,
                                          getKey: (s) => s.name,
                                          setId: (s, id) => s.id = id,
                                          csvExport: csvExportatorSectors,
                                          sqlExport: sqlCreateSector,
                                          conn: conn,
                                        );
                                    }

                                    if (empleoyesNew.isNotEmpty)
                                    {
                                         List<Empleoye> tmp =
                                             empleoyesNew.where((e) => allFactories.any((f)=> f.id == e.idFactory))
                                             .toList();

                                         empleoyesNew = tmp;

                                         if(empleoyesNew.isNotEmpty)
                                         {
                                           array = S.of(context).mails;
                                           count += await processImport(
                                             newList: empleoyesNew,
                                             existingList: empleoyes,
                                             getKey: (e) => e.name,
                                             setId: (e, id) => e.id = id,
                                             csvExport: csvExportatorEmpleoyes,
                                             sqlExport: sqlCreateEmpleoye,
                                             conn: conn,
                                           );
                                         }
                                    }

                                    if (mailsNew.isNotEmpty)
                                    {
                                        array = S.of(context).mails;
                                        count += await processImport(
                                          newList: mailsNew,
                                          existingList: mails,
                                          getKey: (m) => m.addrres,
                                          setId: (s, id) => s.id = id,
                                          csvExport: csvExportatorMails,
                                          sqlExport: sqlCreateMail,
                                          conn: conn,
                                        );
                                    }

                                    if (linesNew.isNotEmpty)
                                    {
                                        List<LineSend> tmp =
                                        linesNew.where((l) => allFactories.any((e)=> l.factory == e.id))
                                            .toList();

                                        linesNew = tmp;

                                        if(linesNew.isNotEmpty)
                                        {
                                          array = S.of(context).lines;
                                          count += await processImport(
                                            newList: linesNew,
                                            existingList: allLines,
                                            getKey: (l) => l.factory,
                                            setId: (e, id) => e.id = id,
                                            csvExport: csvExportatorLines,
                                            sqlExport: (lines) => sqlCreateLine(lines, context),
                                            conn: conn,
                                          );
                                        }
                                    }

                                    if (conectionsNew.isNotEmpty)
                                    {
                                      array = S.of(context).connection;
                                      count += await processImport(
                                        newList: conectionsNew,
                                        existingList: conections,
                                        getKey: (c) => c.database,
                                        setId: (c, id) => c.id = id,
                                        csvExport: csvExportatorConections,
                                        conn: conn,
                                      );
                                    }

                                    if (factoriesNew.isNotEmpty)
                                    {
                                      List<Factory> tmp =
                                      factoriesNew.where((f) => sectors.any((e)=> f.sector == e.id))
                                          .toList();

                                      factoriesNew = tmp;

                                      if(factoriesNew.isNotEmpty)
                                      {
                                        array = S.of(context).company;
                                        count += await processImport(
                                          newList: factoriesNew,
                                          existingList: allFactories,
                                          getKey: (f) => f.name,
                                          setId: (e, id) => e.id = id,
                                          csvExport: csvExportatorFactories,
                                          sqlExport: sqlCeateFactory,
                                          conn: conn,
                                        );
                                      }
                                    }

                                    array = array.toLowerCase();

                                    if(count > 0)
                                    {
                                      action = LocalizationHelper.importData(context,array, count);
                                      confirm(context,action);
                                    }
                                    else
                                    {
                                      action = LocalizationHelper.no_do_import(context, array);
                                      confirm(context, action);
                                    }
                                  }
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

Future<void> _onSaveList() async {

}

Future<void> _pickFile(BuildContext context, TextEditingController controllerDatePicker,List<RouteCSV> routesNew,List<Sector> sectors, List<Factory> factories, List<Empleoye> empleoyes, List<Mail> mails, List<LineSend> lines, List<Conection> conections) async {


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
        sectors.addAll(await readSectorsFromCsv(file));
        break;

      case 3:
        if(file.path.contains('routes.csv'))
        {

          routesCSV.addAll(await readRoutesFromCsv(file));
        }
        else
        {
          empleoyes.addAll(await readEmpleoyeFromCsv(file));
        }
        break;

      case 4:
        mails.addAll(await readMailsFromCsv(file));
        break;

      case 5:
        lines.addAll(await readLinesFromCsv(file));
        break;

      case 6:
        conections.addAll(await readConectionsFromCsv(file));
        break;

      case 14:
        factories.addAll(await readFactoriesFromCsv(file));
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


