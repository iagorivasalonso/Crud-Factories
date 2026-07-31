
import 'package:crud_factories/Backend/Repositories/routesRepository.dart' show routerRepository;
import 'package:crud_factories/Objects/AppRoutesState.dart';
import 'package:crud_factories/Objects/RouteCSV.dart' show RouteCSV;
import 'package:crud_factories/Backend/ImportGeneral/import_Processor.dart' show processImport;
import 'package:crud_factories/Objects/importResult.dart' show ImportResult;
import 'package:crud_factories/generated/l10n.dart' show S;
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart' show Uint8List;

import '../Data/controlsMessagesError/errors.dart';
import '../ImportGeneral/import_Processor.dart';



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
  //  IMPORTLIST
  // =========================
  Future<ImportResult> import({
    required BuildContext context,
    required List<RouteCSV> routesNew
  }) async {

    final result = ImportResult(
        entity: S.of(context).route
    );

    if (routesNew.isEmpty) return result;

    final route = await _repo.load();

    result.inserted = await processImport(
      newList: routesNew,
      existingList: route,
      getKey: (r) => r.route,
      setId: (r, id) => r.id = id,
    );

    if (result.inserted > 0) {
      await _repo.save(route);
      await load();
    }

    return result;
  }

  // ======================
  //    UPDATE
  // ======================

  void updateRoute(int index, String fileName) {
    routes[index] = routes[index].copyWith(
      route: fileName,
    );

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

  // =========================
  //  GETREPO
  // =========================

  routerRepository get _repo {
    final r = repository;
    if (r == null) {
      throw Exception("Repository not initialized");
    }
    return r;
  }

  // =========================
  //  SETREPO
  // =========================
  void setRepository(routerRepository repo) {

    repository = repo;
  }


  // =========================
  // LOAD FROM FILE
  // =========================
  Future<(LoadResult, List<dynamic>)> importRoutesFromBytes({
    required Uint8List bytes,
  }) async {

    try {

      final imported = await repository.importFromBytes(bytes);

      if (imported.isEmpty) {
        return (LoadResult.invalidFile, []);
      }

      return (LoadResult.success, imported);

    } catch (e, stack) {

      debugPrint("importRoutesFromBytes error: $e");
      debugPrintStack(stackTrace: stack);

      return (LoadResult.error, []);
    }
  }

  void setRoutes(List<RouteCSV> newRoutes) {
    _baseRoutes = newRoutes;
    notifyListeners();
  }


  }
