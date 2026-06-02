import 'package:crud_factories/Backend/DataSources/BootstrapService.dart';
import 'package:crud_factories/Backend/Feature/Connection/Controller/ConnectionController.dart' show Connectioncontroller;
import 'package:crud_factories/Backend/Feature/Connection/Datasource/CsvConnectionDataSource.dart' show CsvConnectionDataSource;
import 'package:crud_factories/Backend/Feature/Connection/Datasource/IConnection_repository.dart';
import 'package:crud_factories/Backend/Feature/Router/CsvRouterDataSource.dart' show CsvRouterDataSource;
import 'package:crud_factories/Backend/Feature/Sector/sector_service_factory.dart' show SectorRepositoryFactory;
import 'package:crud_factories/Backend/Global/controllers/Conection.dart';
import 'package:crud_factories/Backend/Providers/ConectionProvider.dart';
import 'package:crud_factories/Backend/Providers/EmpleoyeeProvider.dart';
import 'package:crud_factories/Backend/Providers/FactoryProvider.dart';
import 'package:crud_factories/Backend/Providers/LineSendProvider.dart';
import 'package:crud_factories/Backend/Providers/MailProvider.dart' show MailProvider;



import 'package:crud_factories/Backend/Providers/SectorProvider.dart';
import 'package:crud_factories/Backend/Repositories/routesRepository.dart';
import 'package:crud_factories/Objects/AppRoutesState.dart';
import 'package:crud_factories/Objects/RouteCSV.dart' show RouteCSV;
import 'package:crud_factories/Objects/buldRouteFiles.dart';
import 'package:fluent_ui/fluent_ui.dart' show ChangeNotifier;
import 'package:flutter/material.dart' show BuildContext;
import 'package:provider/provider.dart';

import '../Feature/Connection/Service/IConnectionService.dart' show IConnectionService;
import '../Feature/Connection/Sesion/IConnection_sesion_service.dart';

import 'RoutesProvider.dart';

enum DataSourceMode {
  csv,
  sql,
  api
}


class AppProvider extends ChangeNotifier {

  bool isApi;

  AppProvider({
     required this.isApi
  });

  bool loaded = false;
  bool _loading = false;
  bool initialized = false;
  RouteFiles? files;
  bool get isLoading => _loading;

  DataSourceMode mode = DataSourceMode.csv;



  Future<void> switchSource (
      BuildContext context,
      DataSourceMode newMode,
      ) async {

    // 1. Bootstrap (elige origen base: CSV bundle, etc)
    final source = BootstrapService.fromMode(newMode);
    if (source == null) return;

    final bundle = await source.loadRoutes();
    final files = RouteFilesBuilder.buildRouteFiles(bundle.routes);

    mode = newMode;
    initialized = true;

    notifyListeners();
    // 3. inyectar repos según modo
    await _loadDependencies(context, files, newMode);


  }


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
      files = RouteFilesBuilder.buildRouteFiles(bundle.routes);

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
      print(" routes reload");

      await _applyRoutes(context, routes);

      print("🔄 RELOAD DONE");

    } catch (e, st) {
      print("💥 ERROR reloadFromRoutes:");
      print(e);
      print(st);
      rethrow;
    }
  }

  Future<void> _loadDependencies(BuildContext context, RouteFiles files, DataSourceMode newMode) async {


    print("modo$isApi");
    // =========================
    // 1. ROUTES (SIEMPRE PRIMERO)
    // =========================

    final routesProvider = context.read<RoutesProvider>();
    routesProvider.setRepository(
      routerRepository(
        CsvRouterDataSource(files.routes),
      ),
    );
    await routesProvider.load();

    // =========================
    // 2. CONNECTION PROVIDER
    // =========================

    final repo = context.read<IConnectionDataSource>() as CsvConnectionDataSource;

    repo.init(files.connections);

    final controller = Connectioncontroller(
      provider: context.read<ConnectionProvider>(),
      service: context.read<IConnectionService>(),
      repository: context.read<IConnectionDataSource>(),
      sessionService: context.read<IConnectionSesionService>(),
    );


    await controller.load(); //solo csv
    final session = controller.provider.selected;

    final provider = context.read<ConnectionProvider>();
    final executeQuery = provider.executeQuery;

    // =========================
    // 3. SECTOR PROVIDER
    // =========================

    final sectorProvider = context.read<SectorProvider>();

     if(executeQuery != null)
     {
       final config = provider.config;

       await sectorProvider.setRepositoryAndReload(
         SectorRepositoryFactory.create(
             mode,
             files,
             db:executeQuery,
             config:config
         ),
       );

     }


    await sectorProvider.load();


    await context.read<EmployeeProvider>().load(files.employees);
    await context.read<FactoryProvider>().load(files.factories);
    await context.read<LineSendProvider>().load(files.lines);
    await context.read<MailProvider>().load(files.mails);
  }

  Future<void> _applyRoutes(BuildContext context, List<RouteCSV> routes) async {

    final files = RouteFilesBuilder.buildRouteFiles(routes);


    await _loadDependencies(context, files,mode);

  }


}


