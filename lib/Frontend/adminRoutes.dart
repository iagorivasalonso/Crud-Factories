

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:crud_factories/Backend/CSV/loader.dart' show csvLoaderService;
import 'package:crud_factories/Backend/Global/files.dart';
import 'package:file_picker/file_picker.dart' show FilePickerResult, FilePicker, FileType;
import 'package:flutter/material.dart';
import '../Alertdialogs/confirm.dart';
import '../Backend/CSV/ImportGeneral/CsvProcessorService.dart';
import '../Backend/CSV/exportRoutes.dart';
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


  @override
  void initState() {
    super.initState();

    // Inicialización de variables simple

    // Ejecutar async después del primer frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initialize();
    });
  }

// Método async separado
  Future<void> _initialize() async {
    if (!mounted) return;

    await _showRouteDialog();
  }



  @override
  Widget build(BuildContext context0) {

    BuildContext context = context1;

    return SizedBox.shrink();

    }

    Future<void> _showRouteDialog() async {

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
                    headDialog(title: S.of(context).route_selector),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: SizedBox(
                        width: 325,
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
                            function: () => importedRoutes(context),
                          ),
                          const SizedBox(width: 20),
                          materialButton(
                            nameAction: S.of(context).cancel,
                            function: () => chargueRoutes(),
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

  Future<void> _pickFile(BuildContext context,index) async {
    if (!mounted) return;

    FilePickerResult? result =  await FilePicker.platform.pickFiles(
      dialogTitle: S.of(context).select_file,
      type: FileType.custom,
      allowedExtensions: ['csv','exe'],
       withData: true,
    );

    if(result == null) return;

    final platformFile = result.files.single;

    final file = File(result.files.single.path!);
    final content = await file.readAsString(encoding: utf8);
    CsvProcessorService.processCsvContent(context, content,false);
    routeControllers[index].router.text =platformFile.name;

     }
  }

Future<void> chargueRoutes() async {

  for (int i = 0; i < routesCSV.length; i++)
  {
    routeControllers[i].name.text =  namesRoutesOrdened[i];

    if(routesCSV[i].route.isNotEmpty)
    {
      routeControllers[i].router.text = routesCSV[i].route;
    }
  }

}


Future<void> importedRoutes(BuildContext context, [bool initialChargue = false]) async{

  int idNew = -1;
  routesCSV.clear();

  for(int i = 0; i < routeControllers.length; i++)
  {
    idNew = i + 1;

    routesCSV.add(RouteCSV(
      id: idNew.toString(),
      name: routeControllers[i].name.text,
      route: routeControllers[i].router.text,
    ));
  }

  String array = S.of(context).routes;
  String actionArray = S.of(context).saved;

  String action = LocalizationHelper.manage_array(context, array, actionArray);
  csvExportatorRoutes(routesCSV);
  await csvLoaderService.loadRemainingRoutes(context);

  if(initialChargue==false)
  await confirm(context, action);


}

