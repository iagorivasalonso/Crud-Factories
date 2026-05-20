import 'package:crud_factories/Backend/Repositories/routesRepository.dart' show routerRepository;
import 'package:crud_factories/Objects/RouteCSV.dart' show RouteCSV;
import 'package:crud_factories/Objects/buldRouteFiles.dart';
import 'package:crud_factories/generated/l10n.dart' show S;
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart' show Uint8List;

import '../../Objects/AppRoutesState.dart' show RouteFiles;

enum LoadResult {
  success,
  invalidFile,
  error,
}

class RoutesProvider extends ChangeNotifier {

  routerRepository repository;

  RoutesProvider(this.repository);

  List<RouteCSV> _baseRoutes = [];

  RouteFiles? _files;

  final Map<String, RouteCSV> _overrides = {};


  RouteFiles? get files => _files;

  // =========================
  // INITIALIZE (route master)
  // =========================
  void initialize(BuildContext context) {
    if (_baseRoutes.isNotEmpty) return;

    _baseRoutes.addAll([
      RouteCSV(id: "1", name: S.of(context).routes, route: ''),
    ]);

  }

  // =========================
  // GETTER (SIN List.generate)
  // =========================
  List<RouteCSV> get routes {

    return _baseRoutes.map((base) {
       return _overrides[base.id] ?? base;
    }).toList();
  }

  // =========================
  // SET / INIT
  // =========================
  void setRoutes(List<RouteCSV> update) {
    _baseRoutes = List.from(update);
    _files = RouteFilesBuilder.buildRouteFiles(update);
    _overrides.clear();
    notifyListeners();
  }

  // =========================
  // UPDATE SINGLE ROUTE
  // =========================
  void updateRoute(String id, String newPath) {
    final index = _baseRoutes.indexWhere((router) => router.id == id);

    if(index == -1) return;

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
  // LOAD
  // =========================
  Future<void> load() async {
    final loaded = await repository.load();

    _baseRoutes = loaded;

    notifyListeners();
  }
  void setRepository(routerRepository repo) {

    repository = repo;
  }

  // =========================
  // LOAD FROM FILE
  // =========================
  Future<LoadResult> importRoutesFromBytes({
    required Uint8List bytes,
  }) async {

    try {

      final imported =
      await repository.importFromBytes(bytes);

      if (imported.isEmpty) {
        return LoadResult.invalidFile;
      }



      return LoadResult.success;

    } catch (e, stack) {

      debugPrint(
        "importRoutesFromBytes error: $e",
      );

      debugPrintStack(
        stackTrace: stack,
      );

      return LoadResult.error;
    }
  }




  }
