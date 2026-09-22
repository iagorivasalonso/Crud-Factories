import 'package:crud_factories/Backend/DataSources/BootstrapService.dart';
import 'package:crud_factories/Backend/Feature/Connection/Controller/ConnectionController.dart' show ConnectionController;
import 'package:crud_factories/Backend/Feature/Connection/Datasource/CsvConnectionDataSource.dart' show CsvConnectionDataSource;
import 'package:crud_factories/Backend/Feature/Connection/Datasource/IConnection_repository.dart';
import 'package:crud_factories/Backend/Feature/Employee/employee_service.dart' show RepositoryEmployee;
import 'package:crud_factories/Backend/Feature/Factory/factory_service.dart' show RepositoryFactory;
import 'package:crud_factories/Backend/Feature/LineSend/lineSend_service.dart';
import 'package:crud_factories/Backend/Feature/Mail/mail_service.dart';
import 'package:crud_factories/Backend/Feature/Sector/sector_service.dart' show Repository, RepositorySector;
import 'package:crud_factories/Backend/Feature/User/UserService.dart' show RepositoryUser;
import 'package:crud_factories/Backend/Providers/ConectionProvider.dart';
import 'package:crud_factories/Backend/Providers/EmployeeProvider.dart' show EmployeeProvider;
import 'package:crud_factories/Backend/Providers/FactoryProvider.dart';
import 'package:crud_factories/Backend/Providers/LineSendProvider.dart';
import 'package:crud_factories/Backend/Providers/MailProvider.dart' show MailProvider;
import 'package:crud_factories/Backend/Providers/SectorProvider.dart';
import 'package:crud_factories/Backend/Providers/UserProvider.dart';
import 'package:crud_factories/Backend/Repositories/connectionRepository.dart' show ConnectionRepository;
import 'package:crud_factories/Objects/AppRoutesState.dart';
import 'package:crud_factories/Objects/RouteCSV.dart' show RouteCSV;
import 'package:crud_factories/Objects/User.dart';
import 'package:crud_factories/Objects/buldRouteFiles.dart';
import 'package:fluent_ui/fluent_ui.dart' show ChangeNotifier;
import 'package:flutter/material.dart' show BuildContext;
import 'package:provider/provider.dart';
import '../Feature/Connection/Service/IConnectionService.dart' show IConnectionService;
import '../Feature/Connection/Sesion/IConnection_sesion_service.dart';
import 'RoutesProvider.dart';
import 'SessionProvaider.dart';

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

  final localUser = User(           //se usa para trabajar con la app en local
    id: 'local',
    username: 'local',
    role: 'admin',
    active: true,
  );


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

    final user = newMode == DataSourceMode.csv
        ? localUser
        : context.read<SessionProvider>().user;

    await _loadDependencies(context, files, newMode, user);

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
      files = RouteFilesBuilder.buildRouteFiles(bundle.routes);

      // =========================
      // 1. ROUTES
      // =========================

      final routesProvider = context.read<RoutesProvider>();

      routesProvider.setRoutes(bundle.routes);


      // =========================
      // 2. CONNECTIONS
      // =========================

      await loadConnections(context, files!);

      // =========================
      // 3. LOCAL DATA
      // =========================

      if (mode == DataSourceMode.csv) {

        await _loadDependencies(
          context,
          files!,
          mode,
          localUser,
        );
      }


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
      User? user
      ) async {

     final userID = user?.id;

     print("el user es$userID");
     await context.read<AppProvider>().loadUsers(context);
     // =========================
     // CONFIGURACIÓN DE DATOS
     // =========================

     final provider = context.read<ConnectionProvider>();

     final executeQuery = provider.executeQuery;


     final config = provider.configOrNull;
     final efectiveMode = getEffectiveMode(context);


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
          userId: userID,
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
          userId: userID,
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
          userId: userID,
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
          userId: userID,
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
          userId: userID,
        ),
      );

      await mailProvider.load();
    }
  }

  Future<void> _applyRoutes(BuildContext context, List<RouteCSV> routes) async {

    final files = RouteFilesBuilder.buildRouteFiles(routes);

    this.files = files;

    final user = localUser;

    if(mode==DataSourceMode.csv)
    await _loadDependencies(
        context,
        files,
        mode,
        user
    );

  }

  Future<void> loadConnections(
      BuildContext context,
      RouteFiles files,
      ) async {

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


    if (files.connections.isNotEmpty) {
      await controller.load();
    }

  }

  Future<void> loadUserData(BuildContext context, User user) async {

      if(files== null) return;

      await _loadDependencies(context, files!,mode,user);
  }

  DataSourceMode getEffectiveMode(BuildContext context) {
    final provider = context.read<ConnectionProvider>();

    return switch (mode) {
      DataSourceMode.csv => DataSourceMode.csv,
      DataSourceMode.sql => DataSourceMode.sql,
      DataSourceMode.api =>
      provider.hasConfig ? DataSourceMode.api : DataSourceMode.csv,
    };
  }

  Future<void> loadUsers(BuildContext context) async {
    if (files == null) return;

    final connectionProvider = context.read<ConnectionProvider>();

    final userProvider = context.read<UserProvider>();

    await userProvider.setRepositoryAndReload(
      RepositoryUser.create(
        getEffectiveMode(context),
        files!,
        db: connectionProvider.executeQuery,
        config: connectionProvider.configOrNull,
      ),
    );
  }
}



