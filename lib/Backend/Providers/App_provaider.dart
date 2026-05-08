

import 'package:crud_factories/Alertdialogs/typeConnection.dart';
import 'package:crud_factories/Backend/CSV/importEmpleoyes.dart';
import 'package:crud_factories/Backend/CSV/importFactories.dart';
import 'package:crud_factories/Backend/CSV/importLines.dart';
import 'package:crud_factories/Backend/CSV/importMails.dart' show csvImportMails;
import 'package:crud_factories/Backend/CSV/importRoutes.dart';
import 'package:crud_factories/Backend/CSV/importSectors.dart';
import 'package:crud_factories/Backend/CSV/loader.dart' show csvLoaderService;
import 'package:crud_factories/Backend/Providers/ConectionProvider.dart';
import 'package:crud_factories/Backend/Providers/EmpleoyeeProvider.dart';
import 'package:crud_factories/Backend/Providers/FactoryProvider.dart';
import 'package:crud_factories/Backend/Providers/LineSendProvider.dart';
import 'package:crud_factories/Backend/Providers/MailProvider.dart' show MailProvider;
import 'package:crud_factories/Backend/Providers/RoutesProvider.dart';
import 'package:crud_factories/Backend/Providers/SectorProvider.dart';
import 'package:crud_factories/Objects/AppRoutesState.dart';
import 'package:crud_factories/Objects/RouteCSV.dart' show RouteCSV;
import 'package:crud_factories/Objects/buldRouteFiles.dart';
import 'package:fluent_ui/fluent_ui.dart' show ChangeNotifier;
import 'package:flutter/material.dart' show BuildContext;
import 'package:provider/provider.dart';

import '../CSV/importConections.dart';


class AppProvider extends ChangeNotifier {

  bool loaded = false;
  bool _loading = false;

  bool get isLoading => _loading;

  Future<void> loadApp(BuildContext context) async {
    if (_loading) return;

    _loading = true;
    notifyListeners();


    try {

      final (routes, files) = await csvLoaderService.loadRoutes(context: context);

      if (files == null) {
        print("Error en loadRoutes: files null");
        return;
      }

      // ✅ Set routes
      final routesProvaider = context.read<RoutesProvider>();
      routesProvaider.setRoutes(routes, files);


      // ✅ Load others providers
       await _loadDependencies(context,files);

    } catch (e) {
      print("ERROR loadRoutes: $e");
      rethrow;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void>reloadFromRoutes(BuildContext context, List<RouteCSV>routes) async {

  try{
    final files = buildRouteFiles(routes);  // nombres de ficheros

    //actualizacion provaider
    context.read<RoutesProvider>().setRoutes(routes, files);

    // 3. RELOAD DEPENDENCIES
    await _loadDependencies(context, files);

    print("🔄 RELOAD DONE");

  }catch (e, st) {
    print("💥 ERROR reloadFromRoutes:");
    print(e);
    print(st);
    rethrow;
  }

  }

  Future<void> _loadDependencies(BuildContext context, RouteFiles files) async {

    await context.read<ConectionProvider>().load(files.connections);
    await context.read<SectorProvider>().load(files.sectors);
    await context.read<EmployeeProvider>().load(files.employees);
    await context.read<FactoryProvider>().load(files.factories);
    await context.read<LineSendProvider>().load(files.lines);
    await context.read<MailProvider>().load(files.mails);
  }


}


