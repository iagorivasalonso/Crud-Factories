/*
runApp(
MultiProvider(
providers: DependencyInjection.providers,
child: const MyApp(),
),
);*/
import 'package:crud_factories/Backend/Feature/Connection/Controller/ConnectionController.dart' show Connectioncontroller;
import 'package:crud_factories/Backend/Feature/Connection/Datasource/CsvConnectionDataSource.dart' show CsvConnectionDataSource;
import 'package:crud_factories/Backend/Feature/Connection/Service/sql_connection_service.dart' show SqlConnectionService;
import 'package:crud_factories/Backend/Feature/Connection/Sesion/IConnection_sesion_service.dart' show IConnectionSesionService;
import 'package:crud_factories/Backend/Feature/Connection/Sesion/sql_connection_sesion_service.dart' show SqlConnectionSessionService;
import 'package:crud_factories/Backend/Providers/App_provaider.dart';
import 'package:crud_factories/Backend/Providers/ConectionProvider.dart' show ConnectionProvider;
import 'package:crud_factories/Backend/Providers/EditStateProvider.dart' show EditStateProvider;
import 'package:crud_factories/Backend/Providers/FactoryProvider.dart';
import 'package:crud_factories/Backend/Providers/LineSendProvider.dart';
import 'package:crud_factories/Backend/Providers/NavigationProvider.dart';
import 'package:crud_factories/Backend/Providers/App_provaider.dart' show AppProvider;
import 'package:crud_factories/Backend/Providers/RoutesProvider.dart' show RoutesProvider;
import 'package:crud_factories/Backend/Providers/SectorProvider.dart' show SectorProvider;
import 'package:crud_factories/Backend/Repositories/routesRepository.dart' show routerRepository;
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../../../Providers/EmpleoyeeProvider.dart' show EmployeeProvider;
import '../../../Providers/MailProvider.dart' show MailProvider;
import '../../Router/CsvRouterDataSource.dart';
import '../Datasource/IConnection_repository.dart' show IConnectionDataSource;
import '../Service/IConnectionService.dart';

class DependencyInjection {

   static List<SingleChildWidget> providers = [

     // =========================
     // APP
     // =========================

     ChangeNotifierProvider(
       create: (_) => AppProvider(),
     ),

     ChangeNotifierProvider(
       create: (_) => NavigationProvider(),
     ),

     ChangeNotifierProvider(
       create: (_) => EditStateProvider(),
     ),

     ChangeNotifierProvider(
       create: (_) => RoutesProvider(
         routerRepository(
           CsvRouterDataSource(""),
         ),
       ),
     ),
     // =========================
     // CONNECTION STATE
     // =========================

     ChangeNotifierProvider(
       create: (_) => ConnectionProvider(),
     ),

     ChangeNotifierProvider(
         create: (_) => SectorProvider(),
     ),
     ChangeNotifierProvider(
         create: (_) => FactoryProvider()
     ),

     ChangeNotifierProvider(
         create: (_) => EmployeeProvider()
     ),

     ChangeNotifierProvider(
         create: (_) => LineSendProvider()
     ),


     ChangeNotifierProvider(
         create: (_) => MailProvider()
     ),



     // =========================
     // REPOSITORY
     // =========================

     Provider<IConnectionDataSource>(
       create: (_) => CsvConnectionDataSource(),
     ),

     // =========================
     // SERVICES
     // =========================

     Provider<IConnectionService>(

       create: (_) =>
           SqlConnectionService(),
     ),

     Provider<IConnectionSesionService>(

       create: (_) =>
           SqlConnectionSessionService(),
     ),

     // =========================
     // CONTROLLER
     // =========================

     Provider<Connectioncontroller>(
       create: (context) =>
           Connectioncontroller(
             provider: context.read<ConnectionProvider>(),
             repository: context.read<IConnectionDataSource>(),
             service: context.read<IConnectionService>(),
             sessionService: context.read<IConnectionSesionService>(),
           ),
     ),
   ];
}

