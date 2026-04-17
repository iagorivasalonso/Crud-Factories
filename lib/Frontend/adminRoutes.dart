import 'package:crud_factories/Backend/CSV/loader.dart' show csvLoaderService;
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

  @override
  void initState() {
    super.initState();

    selectedOption = S
        .of(context1)
        .csv;
    isAutoFilled = List.generate(routeControllers.length, (_) => false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadRoutes();
    });
  }


  @override
  Widget build(BuildContext context0) {
    BuildContext context = context1;

    final namesRoutesSQL = [
      S
          .of(context)
          .routes,
      S
          .of(context)
          .connections,
      S
          .of(context)
          .server,
    ];


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
                child: GenericRadioGroup<String>(
                  items: [S
                      .of(context)
                      .csv, S
                      .of(context)
                      .sql
                  ],
                  camp: S
                      .of(context)
                      .select,
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
                  itemCount: selectedOption == S
                      .of(context)
                      .sql
                      ? namesRoutesSQL.length
                      : namesRoutesOrdened.length,
                  itemBuilder: (BuildContext context0, int index) {
                    if (index == 2 && kIsWeb) {
                      return const SizedBox
                          .shrink(); // se oculta para web server
                    }
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: CSVPickerField(
                        key: ValueKey(index),
                        controller: routeControllers[index].router,
                        campName: routeControllers[index].name.text,
                        actionName: S
                            .of(context)
                            .examine,
                        automatic: isAutoFilled[index],
                        function: () =>
                            _pickFile(
                              context,
                              index,
                            ),
                      ),
                    );
                  },
                ),
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

  Future<void> _pickFile(BuildContext context, int index) async {
    if (_loadingFromFile) return;
    if (!mounted) return;

    _loadingFromFile = true; // 👈 AQUÍ primero

    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        dialogTitle: S.of(context).select_file,
        type: FileType.custom,
        allowedExtensions: ['csv', 'exe'],
        withData: true,
      );

      if (result == null) return;

      final file = result.files.single;

      final routeValue = kIsWeb
          ? file.name
          : file.path;

      if (routeValue == null) return;

      setState(() {
        routeControllers[index].router.text = routeValue;
      });

      if (index != 0) return;

      final confirm = await warning(
        context,
        S.of(context).other_fields_will_be_autofilled_do_you_want_to_continue,
      );

      if (!confirm) return;


      final routes = await csvLoaderService.loadInitialRoutes(
        context,
        routeValue,
      );

      if (routes.isEmpty) {
        error(context, S.of(context).route_file_cannot_be_read);
        return;
      }

      if (!mounted) return;

      setState(() {
        for (int i = 1;
        i < routeControllers.length && i < routes.length;
        i++) {
          routeControllers[i].router.text = routes[i].route;
          isAutoFilled[i] = true;
        }
      });


    } catch (e) {
      error(context, e.toString());
    } finally {
      _loadingFromFile = false; // 👈 SIEMPRE se libera
    }
  }


  Future<void> _loadRoutes() async {
    if (!mounted) return;

    setState(() {
      for (int i = 0; i < routeControllers.length; i++) {
        if (i < routesCSV.length &&
            routesCSV[i].route.isNotEmpty &&
            routeControllers[i].router.text.isEmpty) {
            routeControllers[i].router.text = routesCSV[i].route;
        }

        isAutoFilled[i] = false;
      }
    });
  }
}