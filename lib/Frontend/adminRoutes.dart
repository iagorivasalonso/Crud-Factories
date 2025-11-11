
import 'dart:convert';
import 'dart:io';

import 'package:crud_factories/Backend/Global/files.dart';
import 'package:file_picker/file_picker.dart' show FilePickerResult, FilePicker, FileType;
import 'package:flutter/material.dart';

import '../Alertdialogs/confirm.dart';
import '../Alertdialogs/error.dart';
import '../Backend/CSV/chargueData csv.dart';
import '../Backend/CSV/exportRoutes.dart';
import '../Backend/CSV/importConections.dart';
import '../Backend/CSV/importEmpleoyes.dart';
import '../Backend/CSV/importFactories.dart';
import '../Backend/CSV/importLines.dart';
import '../Backend/CSV/importMails.dart';
import '../Backend/CSV/importRoutes.dart';
import '../Backend/CSV/importSectors.dart';
import '../Backend/Global/controllers/List.dart';
import '../Backend/Global/controllers/Router.dart';
import '../Backend/Global/list.dart';
import '../Backend/Global/variables.dart';
import '../Objects/RouteCSV.dart';
import '../Widgets/CSVPickerField.dart';
import '../Widgets/genericRadioGroup.dart';
import '../Widgets/headAlertDialog.dart';
import '../Widgets/materialButton.dart';
import '../generated/l10n.dart';
import '../helpers/localization_helper.dart';

class adminRoutes extends StatefulWidget {
  const adminRoutes({super.key});

  @override
  State<adminRoutes> createState() => _adminRoutesState();
}

class _adminRoutesState extends State<adminRoutes> {

  late List<RouterController> routeControllers;
  late ListController listController;

  String? get selectedOption => null;

  @override
  void initState() {
    super.initState();
    routeControllers = List.generate(namesRoutesOrdened.length,
            (_) =>
            RouterController(
              name: TextEditingController(),
              router: TextEditingController(),
            ));

    listController = new ListController(
        routesNew: [],
        sectorsNew: [],
        empleoyesNew: [],
        mailsNew: [],
        linesNew: [],
        conectionsNew: [],
        factoriesNew: []);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showRouteDialog(context);
    });
    routeControllers[0].router.text = fRoutes.path;
  }

  @override
  void dispose() {
    for (final line in routeControllers) {
      line.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context0) {

    BuildContext context = Platform.isWindows ? context1 : context0;

    for (int i = 0; i < routesCSV.length; i++)
    {
      routeControllers[i].name.text =  routesCSV[i].name;

      if(routesCSV[i].route.isNotEmpty)
      {
        routeControllers[i].router.text = routesCSV[i].route;
      }
    }

      return Text("");
    }

    Future<void> _showRouteDialog(BuildContext context) async {

      return showDialog(
        context: context,
        builder: (BuildContext context) {
          String? selectedOption = S.of(context).csv;

          return StatefulBuilder(
            builder: (BuildContext context0, void Function(void Function()) setState) => Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.8,
                  maxWidth: 500,
                ),
                child: Column(
                  children: [
                    headAlert(title: S.of(context).route_selector),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: SizedBox(
                        width: 320,
                        child: GenericRadioGroup<String>(
                          items: [S.of(context).csv, S.of(context).sql],
                          camp: S.of(context).select,
                          selectedItem: selectedOption,
                          label: (item) => item,
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                selectedOption = value;
                              });
                            }
                          },
                          direction: Axis.horizontal,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Flexible(
                      flex:3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: ListView.builder(
                          itemCount: selectedOption == S.of(context).sql
                                     ?  3
                                     : routeControllers.length,
                          itemBuilder: (BuildContext context0, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(10),
                              child: CSVPickerField(
                                controller: routeControllers[index].router,
                                campName: routeControllers[index].name.text,
                                actionName: S.of(context).examine,
                                function: () => _pickFile(
                                  context,
                                  index,
                                  routeControllers,
                                  listController,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 150.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          materialButton(
                            nameAction: S.of(context).import,
                            function: () => importedRoutes(context,routeControllers),
                          ),
                          const SizedBox(width: 20),
                          materialButton(
                            nameAction: S.of(context).cancel,
                            function: () => reloadRoutes(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );

    }
  Future<void> _pickFile(BuildContext context,index, routeControllers, listControllers) async {


    FilePickerResult? result =  await FilePicker.platform.pickFiles(
      dialogTitle: S.of(context).select_file,
      type: FileType.custom,
      allowedExtensions: ['csv','exe'],
    );

    if(result == null) return;

    final file = File(result.files.single.path!);
    routeControllers[index].router.text = file.path;

    String prepareExt = file.toString().split(".").toString();
    String ext = prepareExt[prepareExt.length-1];

    if(ext == ".csv")
    {

      final content = await file.readAsString(encoding: utf8);

      final lines = const LineSplitter().convert(content);
      final parts = lines.first.split(";");

      try{

        switch(index)
        {
          case 0:
            listController.routesNew.addAll(await readRoutesFromCsv(file));
            break;

          case 1:
            listController.conectionsNew.addAll(await readConectionsFromCsv(file));
            break;

          case 2:

            break;

          case 3:
            listController.sectorsNew.addAll(await readSectorsFromCsv(file));
            break;

          case 4:
            listController.factoriesNew.addAll(await readFactoriesFromCsv(file));
            break;

          case 5:
            listController.empleoyesNew.addAll(await readEmpleoyeFromCsv(file));
            break;

          case 6:
            listController.linesNew.addAll(await readLinesFromCsv(file));
            break;

          case 7:
            listController.mailsNew.addAll(await readMailsFromCsv(file));
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




  }
  Future<void> reloadRoutes() async {


  }

  Future<void> importedRoutes(BuildContext context, List<RouterController> routeControllers) async{

    List<RouteCSV> routesNew = [];

    int idNew = -1;

    for(int i = 0; i < routeControllers.length; i++)
    {
      idNew = i + 1;

      routesNew.add(RouteCSV(
          id: idNew.toString(),
          name: routeControllers[i].name.text,
          route: routeControllers[i].router.text,
      ));
    }

    String array = S.of(context).routes;
    String actionArray = S.of(context).saved;

    String action = LocalizationHelper.manage_array(context, array, actionArray);

    await confirm(context, action);
    chargueDataCSV(context);
    csvExportatorRoutes(routesNew);


    setState((){
      Navigator.of(context).pop(true);
    });
  }
}

