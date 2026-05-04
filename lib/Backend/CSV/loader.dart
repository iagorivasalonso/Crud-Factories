import 'dart:io';
import 'package:crud_factories/Alertdialogs/defaultData.dart';
import 'package:crud_factories/Alertdialogs/error.dart' show error;
import 'package:crud_factories/Backend/Global/files.dart';
import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Backend/Providers/ConectionProvider.dart';
import 'package:crud_factories/Backend/Providers/EmpleoyeeProvider.dart' show EmployeeProvider;
import 'package:crud_factories/Backend/Providers/FactoryProvider.dart' show FactoryProvider;
import 'package:crud_factories/Backend/Providers/MailProvider.dart' show MailProvider;
import 'package:crud_factories/Backend/Providers/RoutesProvider.dart' show RoutesProvider;
import 'package:crud_factories/Backend/Providers/SectorProvider.dart' show SectorProvider;
import 'package:crud_factories/Objects/AppRoutesState.dart' show RouteFiles;
import 'package:crud_factories/Objects/RouteCSV.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:crud_factories/Alertdialogs/confirm.dart';
import 'package:crud_factories/Alertdialogs/errorList.dart';
import 'package:crud_factories/helpers/localization_helper.dart';
import '../Global/controllers/Conection.dart';
import 'ImportGeneral/AppFile.dart';
import 'exportRoutes.dart';
import 'package:path/path.dart' as p;

class csvLoaderService {

  static RouteFiles buildRouteFiles(List<RouteCSV> routes) {
    String get(String name) {
      return routes.firstWhere(
            (r) => r.name == name,
        orElse: () => RouteCSV(id: '', name: name, route: ''),
      ).route;
    }

    return RouteFiles(
      routes: get("routes"),
      connections: get("connections"),
      server: get("server"),
      sectors: get("sectors"),
      factories: get("companies"),
      employees: get("employees"),
      lines: get("lines"),
      mails: get("mails"),
    );
  }

  static Future<(List<RouteCSV>, RouteFiles?)> loadInitialRoutes(BuildContext context,[String? newRoutePath]) async {

    errorFiles.clear();

    final fileName = 'routes.csv';

    final parentDir = kIsWeb ? null : Directory.current.parent;

    final defaultPath = parentDir != null
        ? p.join(parentDir.path,fileName)
        : '';

    final basePath = newRoutePath ?? defaultPath;

    final pathToLoad = await resolveRoutesPath(context, basePath);
    routeFirst = pathToLoad;
print(routeFirst);
    if (pathToLoad == 'fail') {
      return (<RouteCSV>[], null);
    }

    final routes = await _createData(pathToLoad);

    if (routes.isEmpty) {
      errorFiles.add(S.of(context).route_file_cannot_be_read);
      return (<RouteCSV>[], null);
    }

    final files = buildRouteFiles(routes);

    return (routes, files);
  }


  static Future<String> resolveRoutesPath(BuildContext context, [String? newRoutePath]) async {

    final String userPath = newRoutePath ?? '';
    final String assetPath = 'assets/dataDefault/routes.csv';

    // 🌐 WEB → siempre default
    if (kIsWeb) {
      bool errData = (newRoutePath ?? '').isEmpty
             ? await defaultData(context)
             : true;

      if (errData == true) {
        useDataDefault = true;
        return assetPath;
      } else {
        return assetPath;
      }
    }

    // 🟢 CASO IMPORTANTE: VIENE UNA RUTA DEL USUARIO
    if (userPath.isNotEmpty) {
      final file = File(userPath);

      if (await file.exists()) {
        return userPath; // ✅ usar la que viene
      } else {
        // ❌ NO usar default si el usuario ya pasó una ruta
        return 'fail';
      }
    }

    // 🟡 NO HAY RUTA → usar default si existe
    final file = File(assetPath);

    if (await file.exists()) {
      return assetPath;
    }

    return 'fail';
  }
  static Future<List<RouteCSV>> _createData(String path) async {

    final String rawData = path.startsWith('assets/')
        ? await rootBundle.loadString(path)
        : await File(path).readAsString();

    final List<List<dynamic>> listData = CsvToListConverter(fieldDelimiter: ';').convert(rawData);

    List<RouteCSV> routes = [];

    for (final row in listData) {
      // Seguridad básica
      if (row.length < 3) continue;

      routes.add(RouteCSV(
        id: row[0].toString(),
        name: row[1],
        route: row[2],
      ));
    }


    return routes;

  }

  static Future<List<RouteCSV>> importedRoutes(BuildContext context, [bool initialChargue = false]) async {

    final List<RouteCSV> updatedRoutes = [];

    for (int i = 0; i < routeControllers.length; i++) {
      updatedRoutes.add(RouteCSV(
        id: (i + 1).toString(),
        name: routeControllers[i].name.text,
        route: routeControllers[i].router.text,
      ));
    }



    String array = S.of(context).routes;
    String actionArray = S.of(context).saved;

    String action = LocalizationHelper.manage_array(context, array, actionArray);

    if (!initialChargue) {

      if (errorFiles.isNotEmpty) {
        errors(context, errorFiles);
      }

      await confirm(context, action);
      Navigator.of(context).pop(false);

      bool errorExp = await csvExportatorRoutes(updatedRoutes);

      if (!kIsWeb && errorExp) {
        String action = LocalizationHelper.no_file(
          context,
          S.of(context).routes,
        );
        error(context, action);
      }
    }

    return updatedRoutes;
  }

  static AppFile fromAsset(String assetPath) {
    return AppFile(
      name: p.basename(assetPath),
      assetPath: assetPath,
    );
  }

  static AppFile fromPath(String path) {
    return AppFile(
      name:  p.basename(path),
      path: path,
    );
  }

  static AppFile fromPlatformFile(PlatformFile file) {
    return AppFile(
      name: file.name,
      path: file.path,
      bytes: file.bytes,
    );
  }


  static void createControllerBD() {

    controlerConex = connectionControler(
        namebd: TextEditingController(),
        hostbd: TextEditingController(),
        portbd: TextEditingController(),
        userbd: TextEditingController(),
        passbd: TextEditingController()
    );

  }
}

Future<void> clearAllProviders(BuildContext context) async {

  context.read<FactoryProvider>().clear();
  context.read<EmployeeProvider>().clear();
  context.read<SectorProvider>().clear();
  context.read<RoutesProvider>().clear();
  context.read<MailProvider>().clear();
  context.read<ConectionProvider>().clear();
}