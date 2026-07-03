import 'package:crud_factories/Backend/DataSources/BootstrapService.dart';
import 'package:crud_factories/Backend/Feature/Connection/Controller/ConnectionController.dart' show Connectioncontroller;
import 'package:crud_factories/Backend/Feature/Connection/Datasource/CsvConnectionDataSource.dart' show CsvConnectionDataSource;
import 'package:crud_factories/Backend/Feature/Connection/Datasource/IConnection_repository.dart';
import 'package:crud_factories/Backend/Feature/Employee/employee_service.dart' show RepositoryEmployee;
import 'package:crud_factories/Backend/Feature/Factory/factory_service.dart' show RepositoryFactory;
import 'package:crud_factories/Backend/Feature/LineSend/lineSend_service.dart';
import 'package:crud_factories/Backend/Feature/Router/CsvRouterDataSource.dart' show CsvRouterDataSource;
import 'package:crud_factories/Backend/Feature/Sector/sector_service.dart' show Repository, RepositorySector;
import 'package:crud_factories/Backend/Global/controllers/Conection.dart';
import 'package:crud_factories/Backend/Providers/ConectionProvider.dart';
import 'package:crud_factories/Backend/Providers/EmployeeProvider.dart' show EmployeeProvider;
import 'package:crud_factories/Backend/Providers/FactoryProvider.dart';
import 'package:crud_factories/Backend/Providers/LineSendProvider.dart';
import 'package:crud_factories/Backend/Providers/MailProvider.dart' show MailProvider;



import 'package:crud_factories/Backend/Providers/SectorProvider.dart';
import 'package:crud_factories/Backend/Repositories/routesRepository.dart';
import 'package:crud_factories/Backend/Repositories/sectorRepository.dart' show SectorRepository;
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

    final provider = context.read<ConnectionProvider>();
    final executeQuery = provider.executeQuery;

    // =========================
    // 3. SECTOR PROVIDER
    // =========================

    final sectorProvider = context.read<SectorProvider>();

    await sectorProvider.setRepositoryAndReload(
      RepositorySector.create(
        mode,
        files,
        db: executeQuery,
        config:  mode == DataSourceMode.api
                   ? provider.config
                   : null,
       ),
    );

    await sectorProvider.load();

    // =========================
    // 4. FACTORY PROVIDER
    // =========================

    final factoryProvider = context.read<FactoryProvider>();

        await factoryProvider.setRepositoryAndReload(
           RepositoryFactory.create(
               mode,
               files,
               db: executeQuery,
               config: mode == DataSourceMode.api
                   ? provider.config
                   : null,
           ),
        );

        await factoryProvider.load();

    // =========================
    // 5. EMPLOYEE PROVIDER
    // =========================

    final employeeProvider = context.read<EmployeeProvider>();

        await employeeProvider.setRepositoryAndReload(
           RepositoryEmployee.create(
               mode,
               files,
               db: executeQuery,
               config:mode == DataSourceMode.api
                   ? provider.config
                   : null,
           )
        );

    await employeeProvider.load();

    // =========================
    // 6. LINES PROVIDER
    // =========================

    final lineProvider = context.read<LineSendProvider>();

        await lineProvider.setRepositoryAndReload(
             RepositoryLineSend.create(
                 mode,
                 files,
                 db: executeQuery,
                 config:mode == DataSourceMode.api
                     ? provider.config
                     : null,
             )
        );

    await lineProvider.load();

   lineProvider.enrichWithFactories(
      context.read<FactoryProvider>().factories,
    );

    //await context.read<MailProvider>().load(files.mails);
  }

  Future<void> _applyRoutes(BuildContext context, List<RouteCSV> routes) async {

    final files = RouteFilesBuilder.buildRouteFiles(routes);


    await _loadDependencies(context, files,mode);

  }


}


