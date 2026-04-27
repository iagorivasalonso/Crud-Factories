

import 'package:crud_factories/Alertdialogs/typeConnection.dart';
import 'package:crud_factories/Backend/CSV/loader.dart' show csvLoaderService;
import 'package:crud_factories/Objects/RouteCSV.dart' show RouteCSV;
import 'package:fluent_ui/fluent_ui.dart' show ChangeNotifier;
import 'package:flutter/material.dart' show BuildContext;

class AppProvider extends ChangeNotifier {

  List<RouteCSV> routes = [];
  bool loaded = false;
  bool loading = false;

  Future<void> loadRoutes(BuildContext context) async {
    if (loaded || loading) return;

    loading = true;
    notifyListeners();


    try {
      // 1. cargar base
      final initial = await csvLoaderService.loadInitialRoutes(context);

      csvLoaderService.createControllerList(initial);

      // 2. conexión
      await typeConection(context);

      // 3. IMPORTANTE: ya no dependes de controllers
      final imported = await csvLoaderService.importedRoutes(context,true);

      routes = imported.isNotEmpty ? imported : initial;

      loaded = true;

    } catch (e) {
      print("ERROR loadRoutes: $e");
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}