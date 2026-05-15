import 'package:crud_factories/Backend/DataSources/BootstrapService.dart';
import 'package:crud_factories/Backend/Feature/Router/CsvRouterDataSource.dart' show CsvRouterDataSource;
import 'package:crud_factories/Backend/Providers/ConectionProvider.dart';
import 'package:crud_factories/Backend/Providers/EmpleoyeeProvider.dart';
import 'package:crud_factories/Backend/Providers/FactoryProvider.dart';
import 'package:crud_factories/Backend/Providers/LineSendProvider.dart';
import 'package:crud_factories/Backend/Providers/MailProvider.dart' show MailProvider;
import 'package:crud_factories/Backend/Providers/RoutesProvider.dart';
import 'package:crud_factories/Backend/Providers/SectorProvider.dart';
import 'package:crud_factories/Backend/Repositories/routesRepository.dart' show routerRepository;
import 'package:crud_factories/Backend/Repositories/sectorRepository.dart';
import 'package:crud_factories/Backend/Feature/Sector/CsvSectorDataSource.dart' show CsvSectorDataSource;
import 'package:crud_factories/Objects/AppRoutesState.dart';
import 'package:crud_factories/Objects/RouteCSV.dart' show RouteCSV;
import 'package:crud_factories/Objects/buldRouteFiles.dart';
import 'package:fluent_ui/fluent_ui.dart' show ChangeNotifier;
import 'package:flutter/material.dart' show BuildContext;
import 'package:provider/provider.dart';



class AppProvider extends ChangeNotifier {

  bool loaded = false;
  bool _loading = false;

  bool get isLoading => _loading;

  Future<void> loadApp(BuildContext context) async {
    if (_loading) return;

    _loading = true;
    notifyListeners();


    try {

      final source = await BootstrapService().resolve(context);


       if(source == null)
       {
         return;
       }

      final bundle = await source.loadRoutes();

      await _applyRoutes(context, bundle.routes);


    } catch (e) {
      print("ERROR loadRoutes: $e");
      rethrow;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> reloadFromRoutes(
      BuildContext context,
      List<RouteCSV> routes,
      ) async {

    try {
      print("eee routes reload");

      await _applyRoutes(context, routes);

      print("🔄 RELOAD DONE");

    } catch (e, st) {
      print("💥 ERROR reloadFromRoutes:");
      print(e);
      print(st);
      rethrow;
    }
  }

  Future<void> _loadDependencies(BuildContext context, RouteFiles files) async {


    final routesRepo = routerRepository(
      CsvRouterDataSource(files.routes),
    );

    context.read<RoutesProvider>().setRepository(routesRepo);
    await context.read<ConectionProvider>().load(files.connections);
   // await context.read<SectorProvider>().load(files.sectors);
    await context.read<EmployeeProvider>().load(files.employees);
    await context.read<FactoryProvider>().load(files.factories);
    await context.read<LineSendProvider>().load(files.lines);
    await context.read<MailProvider>().load(files.mails);
  }

  Future<void> _applyRoutes(BuildContext context, List<RouteCSV> routes) async {

    final files = RouteFilesBuilder.buildRouteFiles(routes);

    context.read<RoutesProvider>().setRoutes(routes);

    await _loadDependencies(context, files);

  }


}


