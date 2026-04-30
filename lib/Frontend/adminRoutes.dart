import 'package:crud_factories/Backend/CSV/loader.dart' show csvLoaderService;
import 'package:crud_factories/Backend/Global/controllers/Router.dart' show RouterController;
import 'package:crud_factories/Backend/Providers/RoutesProvider.dart' show RoutesProvider;
import 'package:crud_factories/Objects/AppRoutesState.dart';
import 'package:file_picker/file_picker.dart' show FilePickerResult, FilePicker, FileType;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:crud_factories/Alertdialogs/error.dart';
import 'package:crud_factories/Alertdialogs/warning.dart';
import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Objects/RouteCSV.dart';
import 'package:crud_factories/Widgets/CSVPickerField.dart';
import 'package:crud_factories/Widgets/genericRadioGroup.dart';
import 'package:crud_factories/Widgets/headAlertDialog.dart';
import 'package:crud_factories/Widgets/materialButton.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:provider/provider.dart' show WatchContext, ReadContext;

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


  bool _loadingFromFile = false;

  get files => null;

  @override
  void initState() {
    super.initState();

    selectedOption = null;
    isAutoFilled = List.generate(8, (_) => false);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    selectedOption ??= S.of(context).csv;
  }

  @override
  Widget build(BuildContext context0) {
    BuildContext context = context1;

    final routes = context.watch<RoutesProvider>().routes;

    final sqlNames = [
      S.of(context).routes,
      S.of(context).connections,
      S.of(context).server,
    ];

    final isSql = selectedOption == S.of(context).sql;
    final routeList = context.watch<RoutesProvider>().routes;

    //final itemCount = isSql ? sqlNames.length : routes.length;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery
              .of(context)
              .size
              .height * 0.8,
          maxWidth: 500,
        ),
        child: Column(
          children: [
            headDialog(title: S
                .of(context)
                .route_selector),
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

                    itemCount: isSql ? 3 : routeList.length,
                    itemBuilder: (context, index) {

                      final routeList = context.watch<RoutesProvider>().routes;
                      final isSql = selectedOption == S.of(context).sql;
                      final campName = isSql
                          ? sqlNames[index]
                          : (index < routeList.length ? routeList[index].name : '');

                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: CSVPickerField(
                          index: index,
                          value: routeList[index].route,
                          campName: campName,
                          actionName: S.of(context).examine,
                          onChanged: (value) {
                            context.read<RoutesProvider>().updateRoute(index, value);
                          },
                          function: () => _pickFile(context, index),
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
                    function: () => csvLoaderService.importedRoutes(context),
                  ),
                  const SizedBox(width: 20),
                  materialButton(
                    nameAction: S
                        .of(context)
                        .cancel,
                    function: () => null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickFile(BuildContext context, int index) async {
    if (_loadingFromFile) return;
    _loadingFromFile = true;

    try {
      final result = await FilePicker.platform.pickFiles(
        dialogTitle: S.of(context).select_file,
        type: FileType.custom,
        allowedExtensions: ['csv', 'exe'],
        withData: true,
      );

      if (result == null) return;

      final file = result.files.single;

      final routeValue = kIsWeb ? file.name : file.path;
      if (routeValue == null) return;

      context.read<RoutesProvider>().updateRoute(index, routeValue);

      // SOLO auto-fill desde el primero
      if (index != 0) return;

      final confirm = await warning(
        context,
        S.of(context).other_fields_will_be_autofilled_do_you_want_to_continue,
      );

      if (!confirm) return;

      final (routes, files) = await csvLoaderService.loadInitialRoutes(
        context,
        routeValue,
      );

      if (routes.isEmpty) {
        error(context, S.of(context).route_file_cannot_be_read);
        return;
      }

      context.read<RoutesProvider>().setRoutes(routes);

      if (files != null) {
        context.read<RoutesProvider>().setFiles(files);
      }
    } finally {
      _loadingFromFile = false;
    }
  }

}

