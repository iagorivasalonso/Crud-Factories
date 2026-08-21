
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
import 'package:provider/provider.dart';

import '../Alertdialogs/confirm.dart';
import '../Backend/Data/controlsMessagesError/errors.dart';


class AdminRoutesDialog extends StatefulWidget {
  const AdminRoutesDialog({super.key});

  @override
  State<AdminRoutesDialog> createState() => _AdminRoutesDialogState();
}

class _AdminRoutesDialogState extends State<AdminRoutesDialog> {

  String? selectedOption;
  final Map<String, Uint8List> pendingFiles = {};

  @override
  void initState() {
    super.initState();
    selectedOption = null;
  }

  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_initialized) {
      selectedOption ??= S
          .of(context)
          .csv;

      context.read<RoutesProvider>().initialize(context);

      _initialized = true;
    }
  }

  List<RouteCSV> get defaultRoutes =>
      [
        RouteCSV(id: "1", name: "routes", route: ""),
        RouteCSV(id: "2", name: "connections", route: ""),
        RouteCSV(id: "3", name: "server", route: ""),
        RouteCSV(id: "4", name: "employees", route: ""),
        RouteCSV(id: "5", name: "sectors", route: ""),
        RouteCSV(id: "6", name: "factories", route: ""),
        RouteCSV(id: "7", name: "lines", route: ""),
        RouteCSV(id: "8", name: "mails", route: ""),
      ];

  @override
  Widget build(BuildContext context) {
    final isApi = context
        .read<AppProvider>()
        .isApi;

    return Consumer<RoutesProvider>(
      builder: (context, provider, _) {
        final isSql = selectedOption == S
            .of(context)
            .sql;

        final routes = isSql
            ? provider.routes
            .where((route) => ["1", "2", "3"].contains(route.id))
            .toList()
            : provider.routes;

        final routesToShow = isApi
            ? routes.where((route) => route.id != "3").toList()
            : routes;

        final routesDisplay = routesToShow.isEmpty
            ? defaultRoutes
            : routesToShow;
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
                      itemCount: routesDisplay.length,
                      itemBuilder: (context, index) {
                        final route = routesDisplay[index];

                        if (kIsWeb && route.id == "3") {
                          return const SizedBox.shrink();
                        }

                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: CSVPickerField(
                            index: index,
                            value: route.route,
                            campName: route.name,
                            actionName: S
                                .of(context)
                                .examine,
                            function: () => _pickFile(index, route),
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
    if (!mounted) return;

    final file = result.files.first;
    final bytes = file.bytes;

    if (bytes == null) return;

    setState(() {
      pendingFiles[route.name] = bytes;
    });

    final provider = context.read<RoutesProvider>();

    final existingIndex = provider.routes.indexWhere(
          (r) => r.id == route.id,
    );

    if (existingIndex != -1) {
      provider.updateRoute(
        existingIndex,
        file.name,
      );
    } else {
      provider.addRoute(
        RouteCSV(
          id: route.id,
          name: route.name,
          route: file.name,
        ),
      );
    }
  }

  Future<void> _handleImport() async {
    if (pendingFiles.isEmpty) {
      await error(
        context,
        S
            .of(context)
            .select_file_first,
      );
      return;
    }

    final bytes = pendingFiles.values.first;

    final routesProvider = context.read<RoutesProvider>();
    final app = context.read<AppProvider>();

    try {
      final result = await routesProvider.importRoutesFromBytes(
        bytes: bytes,
      );

      if (result.$1 != LoadResult.success) {
        if (!mounted) return;

        await error(
          context,
          result.$1 == LoadResult.invalidFile
              ? S
              .of(context)
              .not_valid
              : S
              .of(context)
              .error_loading_route,
        );
        return;
      }

      await app.reloadFromRoutes(
        context,
        routesProvider.routes,
      );

      if (!mounted) return;

      Navigator.pop(context);

      await confirm(
        context,
        S
            .of(context)
            .routes_imported_successfully,
      );
    } catch (e, st) {
      debugPrint("ERROR IMPORTANDO RUTAS: $e");
      debugPrintStack(stackTrace: st);

      if (!mounted) return;

      await error(
        context,
        S
            .of(context)
            .error_loading_route,
      );
    }
  }
}
