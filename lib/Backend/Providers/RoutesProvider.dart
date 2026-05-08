import 'package:crud_factories/Backend/CSV/exportRoutes.dart' show csvExportatorRoutes;
import 'package:crud_factories/Backend/Providers/ConectionProvider.dart' show ConectionProvider;
import 'package:crud_factories/Backend/Providers/EmpleoyeeProvider.dart' show EmployeeProvider;
import 'package:crud_factories/Backend/Providers/FactoryProvider.dart' show FactoryProvider;
import 'package:crud_factories/Backend/Providers/LineSendProvider.dart' show LineSendProvider;
import 'package:crud_factories/Backend/Providers/MailProvider.dart' show MailProvider;
import 'package:crud_factories/Objects/RouterRegistry.dart' show RouterRegistry, RouteFileKey;
import 'package:crud_factories/Objects/buldRouteFiles.dart' show buildRouteFiles;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:crud_factories/Objects/RouteCSV.dart';
import 'package:crud_factories/Objects/AppRoutesState.dart';
import 'package:crud_factories/Backend/CSV/importRoutes.dart';
import 'package:crud_factories/Backend/CSV/loader.dart';
import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:provider/provider.dart';
import 'package:universal_html/html.dart';

import '../Global/files.dart';
import 'SectorProvider.dart' show SectorProvider;

enum LoadResult {
  success,
  invalidFile,
  routeNotFound,
  error,
}

class RoutesProvider extends ChangeNotifier {
  List<RouteCSV> _baseRoutes = [];

  RouteFiles? _files;

  final Map<String, RouteCSV> _overrides = {};

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // =========================
  // GETTER (SIN List.generate)
  // =========================
  List<RouteCSV> get routes {

    return _baseRoutes.map((base) {
       return _overrides[base.id] ?? base;
    }).toList();
  }
/*
  // =========================
  // LOADING
  // =========================
  void _setLoading(bool v) {
    _isLoading = v;
    notifyListeners();
  }

  // =========================
  // RELOAD CENTRAL (ÚNICO MÉTODO REAL)
  // =========================
  void _reload(List<RouteCSV> routes, RouteFiles? files) {
    _baseRoutes = List.from(routes);
    _files = files;
    _overrides.clear();
    notifyListeners();
  }*/

  // =========================
  // SET / INIT
  // =========================
  void setRoutes(List<RouteCSV> routes, RouteFiles? files) {
    _baseRoutes = List.from(routes);
    _files = buildRouteFiles(routes);
    _overrides.clear();
    notifyListeners();
  }

  // =========================
  // UPDATE SINGLE ROUTE
  // =========================
  void updateRoute(String id, String newPath) {
    final index = _baseRoutes.indexWhere((router) => router.id == id);

    final base = _baseRoutes[index];

    _overrides[base.id] = RouteCSV(
      id: base.id,
      name: base.name,
      route: newPath,
    );

    notifyListeners();
  }

  // =========================
  // CLEAR
  // =========================
  void clear() {
    _baseRoutes = [];
    _files = null;
    _overrides.clear();
    notifyListeners();
  }

  // =========================
  // LOAD FROM FILE
  // =========================
  Future<LoadResult> replaceRoutesFromBytes({
    required BuildContext context,
    required String routeId,
    required Uint8List bytes,
  }) async {

    // 1. parse CSV
   try {
     final csv = await csvLoaderService.loadRoutes(bytes: bytes, context: context);
     final routes = csv.$1;

     if(routes.isEmpty)
       return  LoadResult.invalidFile;

     // 2. actualizar SOLO estado
     final updated = List<RouteCSV>.from(_baseRoutes);

     final index = updated.indexWhere((r) => r.id == routeId);
     if (index == -1) {
       return LoadResult.routeNotFound;
     }

     updated[index] = updated[index].copyWith(
       route: "custom",
     );

     _baseRoutes = updated;

     // 3. generar files (IMPORTANTE para dependencias)
     _files = buildRouteFiles(_baseRoutes);

     notifyListeners();


     return LoadResult.success;
   }catch(e) {
     return LoadResult.success;
   }
  }

  Future<void> exportRoutesCSV() async {
    final routesCSV = _baseRoutes
        .map((base) => _overrides[base.id] ?? base)
        .toList();

    await csvExportatorRoutes(routesCSV);
  }


  }
