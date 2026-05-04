

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
import 'package:crud_factories/Objects/Mail.dart';
import 'package:crud_factories/Objects/RouteCSV.dart' show RouteCSV;
import 'package:fluent_ui/fluent_ui.dart' show ChangeNotifier;
import 'package:flutter/material.dart' show BuildContext;
import 'package:provider/provider.dart';

import '../CSV/importConections.dart';

class AppProvider extends ChangeNotifier {

  bool loaded = false;
  bool _loading = false;

  bool get isLoading => _loading;

  Future<void> loadRoutes(BuildContext context) async {
    if (_loading) return;

    _loading = true;
    notifyListeners();


    try {

      final routes = await csvImportRoutes();
      final connections = await csvImportConections(assetPath: routes[1].route);
      final sectors = await csvImportSectors(assetPath: routes[3].route);
      final factories = await csvImportFactories(assetPath: routes[4].route);
      final employees = await csvImportEmpleoyees(assetPath: routes[5].route);
      final lines = await csvImportLines(assetPath: routes[6].route);
      final mails = await csvImportMails(assetPath: routes[7].route);

      context.read<RoutesProvider>().setRoutes(routes);
      context.read<ConectionProvider>().setConections(connections);
      context.read<SectorProvider>().setSectors(sectors);
      context.read<FactoryProvider>().setFactories(factories);
      context.read<EmployeeProvider>().setEmployees(employees);
      context.read<LineSendProvider>().setLineSends(lines);
      context.read<MailProvider>().setMails(mails);

    } catch (e) {
      print("ERROR loadRoutes: $e");
      rethrow;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}

