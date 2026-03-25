

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:crud_factories/Backend/CSV/loader.dart' show csvLoaderService;
import 'package:crud_factories/Backend/Global/files.dart';
import 'package:file_picker/file_picker.dart' show FilePickerResult, FilePicker, FileType;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../Alertdialogs/confirm.dart';
import '../Alertdialogs/error.dart';
import '../Alertdialogs/errorList.dart';
import '../Alertdialogs/warning.dart';
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

class Adminroutes {

   static Future<void> show (BuildContext context) {

       return showDialog(
           context: context,
           builder: (_) => const AdminRoutesDialog(),
       );
   }
}

class AdminRoutesDialog extends StatefulWidget {
  const AdminRoutesDialog({super.key});

  @override
  State<AdminRoutesDialog> createState() => _AdminRoutesDialogState();
}

class _AdminRoutesDialogState extends State<AdminRoutesDialog> {

  late List<bool> isAutoFilled;
  List<RouteCSV> routesNoSave = [];

  String? selectedOption;

  @override
  void initState() {
    super.initState();

    selectedOption = S.of(context1).csv;
    isAutoFilled = List.generate(routeControllers.length, (_) => false);

    routeControllers[0].router.text = routeFirst;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initialize();
    });
  }

// Método async separado
  Future<void> _initialize() async {
    if (!mounted) return;

    await _loadRoutes();
  }

  @override
  Widget build(BuildContext context0) {

    BuildContext context = context1;

    final namesRoutesSQL = [
      S.of(context).routes,
      S.of(context).connections,
      S.of(context).server,
    ];




      return Dialog(
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
                                     ? namesRoutesSQL.length
                                     : namesRoutesOrdened.length,
                          itemBuilder: (BuildContext context0, int index) {
                            if (index == 2 && kIsWeb) {
                              return const SizedBox.shrink(); // se oculta para web server
                            }
                            return Padding(
                              padding: const EdgeInsets.all(10),
                              child: CSVPickerField(
                                controller: routeControllers[index].router,
                                campName: routeControllers[index].name.text,
                                actionName: S.of(context).examine,
                                automatic: isAutoFilled[index],
                                function: () => _pickFile(
                                  context,
                                  index,
                                  setState,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: kIsWeb? 40 : 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 150.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          materialButton(
                            nameAction: S.of(context).import,
                            function: () => csvLoaderService.importedRoutes(context),
                          ),
                          const SizedBox(width: 20),
                          materialButton(
                            nameAction: S.of(context).cancel,
                            function: () => _loadRoutes(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
    }

  Future<void> _pickFile(BuildContext context,index, void Function(void Function()) setState) async {

          if (!mounted) return;

          FilePickerResult? result =  await FilePicker.platform.pickFiles(
            dialogTitle: S.of(context).select_file,
            type: FileType.custom,
            allowedExtensions: ['csv','exe'],
             withData: true,
          );

          if(result == null) return;

          final file = result.files.single;

          if (file.path == null) return;
          routeControllers[index].router.text = file.path!;

          bool isMainRoute = index == 0;

          if (isMainRoute) {
            String message = S.of(context)
                .other_fields_will_be_autofilled_do_you_want_to_continue;

            bool confirmAuto = await warning(context, message);

            if (confirmAuto) {
              await _autoFillRoutes(context, index);
            }
          }

          setState(() {});

     }

Future<void> _autoFillRoutes(BuildContext context, int index) async {

    try {
       routesNoSave = await csvLoaderService.loadInitialRoutes(
           context,
           routeControllers[index].router.text
       );


         await csvLoaderService.loadRemainingRoutes(context, routesNoSave);


       for(int i = 1; i < routeControllers.length && i < routesNoSave.length; i++) {
         routeControllers[i].router.text = routesNoSave[i].route;
       }

       if (!mounted) return;

       setState(() {
         for (int i = 1; i < routeControllers.length; i++) {
           isAutoFilled[i] = true;
         }
       });
    } catch (e) {
       error(context, e.toString());
    }
}
Future<void> _loadRoutes() async {

  for (int i = 0; i < routeControllers.length && i < routesCSV.length; i++)
  {
    routeControllers[i].name.text =  namesRoutesOrdened[i];

    if(routesCSV[i].route.isNotEmpty)
    {
      routeControllers[i].router.text = routesCSV[i].route;
    }
  }

  setState(() {});
  }

}
