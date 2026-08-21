import 'package:crud_factories/Backend/DataSources/BootstrapService.dart';
import 'package:crud_factories/Backend/Feature/Connection/Controller/ConnectionController.dart' show ConnectionController;
import 'package:crud_factories/Backend/Feature/Connection/Datasource/CsvConnectionDataSource.dart' show CsvConnectionDataSource;
import 'package:crud_factories/Backend/Feature/Connection/Datasource/IConnection_repository.dart';
import 'package:crud_factories/Backend/Feature/Employee/employee_service.dart' show RepositoryEmployee;
import 'package:crud_factories/Backend/Feature/Factory/factory_service.dart' show RepositoryFactory;
import 'package:crud_factories/Backend/Feature/LineSend/lineSend_service.dart';
import 'package:crud_factories/Backend/Feature/Mail/mail_service.dart';
import 'package:crud_factories/Backend/Feature/Router/CsvRouterDataSource.dart' show CsvRouterDataSource;
import 'package:crud_factories/Backend/Feature/Sector/sector_service.dart' show Repository, RepositorySector;
import 'package:crud_factories/Backend/Global/controllers/Conection.dart';
import 'package:crud_factories/Backend/Providers/ConectionProvider.dart';
import 'package:crud_factories/Backend/Providers/EmployeeProvider.dart' show EmployeeProvider;
import 'package:crud_factories/Backend/Providers/FactoryProvider.dart';
import 'package:crud_factories/Backend/Providers/LineSendProvider.dart';
import 'package:crud_factories/Backend/Providers/MailProvider.dart' show MailProvider;



import 'package:crud_factories/Backend/Providers/SectorProvider.dart';
import 'package:crud_factories/Backend/Repositories/connectionRepository.dart' show ConnectionRepository;
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

  DataSourceMode mode;

  AppProvider({
     required this.mode
  });

  bool loaded = false;
  bool _loading = false;
  bool initialized = false;
  RouteFiles? files;
  bool get isLoading => _loading;

  bool get isApi => mode == DataSourceMode.api;


  Future switchSource(
      BuildContext context,
      DataSourceMode newMode,
      ) async {

    // Guardamos la conexión actualmente seleccionada
    final connectionProvider = context.read<ConnectionProvider>();
    final selectedConnection = connectionProvider.selected;
    final selectedId = selectedConnection?.id;

    // 1. Bootstrap
    final source = BootstrapService.fromMode(newMode);
    if (source == null) return;

    final bundle = await source.loadRoutes();
    final files = RouteFilesBuilder.buildRouteFiles(bundle.routes);

    mode = newMode;
    initialized = true;

    notifyListeners();

    // 2. Cargar dependencias
    await _loadDependencies(context, files, newMode);

    // 3. Restaurar la conexión seleccionada
    if (selectedId != null) {

      final newSelected = connectionProvider.connections.firstWhere(
            (c) => c.id == selectedId,
        orElse: () => selectedConnection!,
      );

      connectionProvider.select(newSelected);
    }
  }

  Future<void> loadApp(BuildContext context) async {
    if (_loading) return;

    _loading = true;
    notifyListeners();


    try {

      final source = await BootstrapService().resolve(context,isApi);


       if(source == null)
       {
         return;
       }

      final bundle = await source.loadRoutes();
      print('ROUTES CARGADAS: ${bundle.routes.length}');

      for (final r in bundle.routes) {
        print('ROUTE -> id=${r.id}, name=${r.name}, route=${r.route}');
      }
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
  Future<void> _loadDependencies(
      BuildContext context,
      RouteFiles files,
      DataSourceMode newMode,
      ) async {

    // =========================
    // 1. ROUTES
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


    final dataSource =
    context.read<IConnectionDataSource>() as CsvConnectionDataSource;

    dataSource.init(files.connections);

    final repository = context.read<ConnectionRepository>();

    final controller = ConnectionController(
      provider: context.read<ConnectionProvider>(),
      service: context.read<IConnectionService>(),
      repository: repository,
      sessionService: context.read<IConnectionSesionService>(),
    );

    final provider = context.read<ConnectionProvider>();
    final executeQuery = provider.executeQuery;

    final efectiveMode = switch (mode) {
      DataSourceMode.csv => DataSourceMode.csv,
      DataSourceMode.sql => DataSourceMode.sql,
      DataSourceMode.api =>
      provider.hasConfig ? DataSourceMode.api : DataSourceMode.csv,
    };

    final config = provider.configOrNull;

    if (efectiveMode == DataSourceMode.csv &&
        files.connections.isNotEmpty) {
      await controller.load();
    }

    // =========================
    // 3. SECTORS
    // =========================

    final sectorProvider = context.read<SectorProvider>();

    if (efectiveMode != DataSourceMode.csv ||
        files.sectors.isNotEmpty) {

      await sectorProvider.setRepositoryAndReload(
        RepositorySector.create(
          efectiveMode,
          files,
          db: executeQuery,
          config: config,
        ),
      );

      await sectorProvider.load();
    }

    // =========================
    // 4. FACTORIES
    // =========================

    final factoryProvider = context.read<FactoryProvider>();

    if (efectiveMode != DataSourceMode.csv ||
        files.factories.isNotEmpty) {

      await factoryProvider.setRepositoryAndReload(
        RepositoryFactory.create(
          efectiveMode,
          files,
          db: executeQuery,
          config: config,
        ),
      );

      await factoryProvider.load();
    }

    // =========================
    // 5. EMPLOYEES
    // =========================

    final employeeProvider = context.read<EmployeeProvider>();

    if (efectiveMode != DataSourceMode.csv ||
        files.employees.isNotEmpty) {

      await employeeProvider.setRepositoryAndReload(
        RepositoryEmployee.create(
          efectiveMode,
          files,
          db: executeQuery,
          config: config,
        ),
      );

      await employeeProvider.load();
    }

    // =========================
    // 6. LINES
    // =========================

    final lineProvider = context.read<LineSendProvider>();

    if (efectiveMode != DataSourceMode.csv ||
        files.linesSends.isNotEmpty) {

      await lineProvider.setRepositoryAndReload(
        RepositoryLineSend.create(
          efectiveMode,
          files,
          db: executeQuery,
          config: config,
        ),
      );

      await lineProvider.load();

      lineProvider.enrichWithFactories(
        context.read<FactoryProvider>().factories,
      );
    }

    // =========================
    // 7. MAILS
    // =========================

    final mailProvider = context.read<MailProvider>();

    if (efectiveMode != DataSourceMode.csv ||
        files.mails.isNotEmpty) {

      await mailProvider.setRepositoryAndReload(
        RepositoryMail.create(
          efectiveMode,
          files,
          db: executeQuery,
          config: config,
        ),
      );

      await mailProvider.load();
    }
  }

  Future<void> _applyRoutes(BuildContext context, List<RouteCSV> routes) async {

    final files = RouteFilesBuilder.buildRouteFiles(routes);


    await _loadDependencies(context, files,mode);

  }


}



