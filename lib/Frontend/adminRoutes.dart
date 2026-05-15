
import 'package:crud_factories/Alertdialogs/error.dart' show error;
import 'package:crud_factories/Backend/Providers/App_provaider.dart' show AppProvider;
import 'package:crud_factories/Backend/Providers/RoutesProvider.dart' show RoutesProvider, LoadResult;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:crud_factories/Objects/RouteCSV.dart';
import 'package:crud_factories/Widgets/CSVPickerField.dart';
import 'package:crud_factories/Widgets/genericRadioGroup.dart';
import 'package:crud_factories/Widgets/headAlertDialog.dart';
import 'package:crud_factories/Widgets/materialButton.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:provider/provider.dart' show WatchContext, ReadContext, Consumer;

import '../Alertdialogs/confirm.dart';

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

  String? selectedOption;
  Uint8List? pendingImportBytes;


  @override
  void initState() {
    super.initState();
    selectedOption = null;

  }

  Map<String, String> getNamesMap(BuildContext context) {
    return {
      "1": S.of(context).routes,
      "2": S.of(context).connections,
      if (!kIsWeb) "3": S.of(context).server,
      "4": S.of(context).sectors,
      "5": S.of(context).companies,
      "6": S.of(context).employees,
      "7": S.of(context).lines,
      "8": S.of(context).mails,
    };
  }
  Map<String, String> getSqlNamesMap(BuildContext context) {
    return {
      "1": S.of(context).routes,
      "2": S.of(context).connections,
      if (!kIsWeb) "3": S.of(context).server,
    };
  }

  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_initialized) {
      selectedOption ??= S.of(context).csv;

        context.read<RoutesProvider>().initialize(context);

      _initialized = true;
    }
  }


  @override
  Widget build(BuildContext context) {

    return Consumer<RoutesProvider>(
          builder: (context, provider,_){

            final routes = provider.routes;

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
                        child:  GenericRadioGroup<String>(
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
                      flex: 3,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: ListView.builder(
                              itemCount: routes.length,
                              itemBuilder: (context, index) {

                                final route = routes[index];

                                if (kIsWeb && route.id == "3") {
                                  return const SizedBox.shrink();
                                }

                                return Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: CSVPickerField(
                                      index: index,
                                      value: routes[index].route,
                                      campName: routes[index].name,
                                      actionName: S.of(context).examine,
                                      function: () => _pickFile(index,route),
                                  ),
                                );
                              }
                          )
                      ),
                    ),
                    const SizedBox(height: kIsWeb ? 40 : 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 150.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          materialButton(
                            nameAction: S
                                .of(context)
                                .import,
                            function: _handleImport

                          ),
                          const SizedBox(width: 20),
                          materialButton(
                            nameAction: S
                                .of(context)
                                .cancel,
                            function: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
            },
    );


  }
  Future<void> _pickFile(int index, RouteCSV route) async {

    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      withData: true,
    );

    if (result == null) return;

    final bytes = result.files.first.bytes;
    final fileName = result.files.first.name;

    setState(() {
      route.route = fileName;

      if (index == 0) {
        pendingImportBytes = bytes;
      }
    });

  }

  Future<void>  _handleImport() async {

    if(pendingImportBytes != null)
    {
       error(context, S.of(context).select_file_first);
    }

    final result = await context.read<RoutesProvider>().importRoutesFromBytes(
      bytes: pendingImportBytes!,
    );

    final app = context.read<AppProvider>();

    await app.reloadFromRoutes(
      context,
      context.read<RoutesProvider>().routes,
    );
    if (mounted) {
      Navigator.pop(context);
    }

    switch(result)
    {
      case LoadResult.invalidFile:
        await error(context, S.of(context).not_valid);
      break;

      case LoadResult.error:
        await error(context, S.of(context).error_loading_route);
      break;

      case LoadResult.success:
        await confirm(context, S.of(context).routes_imported_successfully);
      break;
    }

  }
}

