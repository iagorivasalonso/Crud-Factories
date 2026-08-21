
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

    _baseRoutes = [
      RouteCSV(id: "1", name: "routes", route: ""),
      RouteCSV(id: "2", name: "connections", route: ""),
      RouteCSV(id: "3", name: "server", route: ""),
      RouteCSV(id: "4", name: "employees", route: ""),
      RouteCSV(id: "5", name: "sectors", route: ""),
      RouteCSV(id: "6", name: "factories", route: ""),
      RouteCSV(id: "7", name: "lines", route: ""),
      RouteCSV(id: "8", name: "mails", route: ""),
    ];
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
  //  SAVE ROUTES
  // =========================

  Future<void> saveRoutes() async {
    await repository.save(routes);
    await load();
  }

  // =========================
  //  IMPORTLIST
  // =========================
  Future<ImportResult> import({
    required BuildContext context,
    required List<RouteCSV> routesNew,
  }) async {

    final result = ImportResult(
      entity: S.of(context).route,
    );

    if (routesNew.isEmpty) return result;

    final routes = await _repo.load();

    final newRoutes = await processImport(
      newList: routesNew,
      existingList: routes,
      getKey: (r) => r.route,
      setId: (r, id) => r.id = id,
    );

    result.inserted = newRoutes.length;

    if (newRoutes.isNotEmpty) {
      await _repo.save(newRoutes);
      await load();
    }

    return result;
  }
  // ======================
  //   ADD ROUTE
  // ======================
  void addRoute(RouteCSV route) {
    _baseRoutes.add(route);
    notifyListeners();
  }

  // ======================
  //    UPDATE
  // ======================
  void updateRoute(int index, String fileName) {
    if (index < 0 || index >= _baseRoutes.length) return;

    final route = _baseRoutes[index];

    _baseRoutes[index] = route.copyWith(
      route: fileName,
    );

    notifyListeners();
  }

  // =========================
  // LOAD
  // =========================
  Future<void> load() async {
    final loaded = await repository.load();

    _baseRoutes = List<RouteCSV>.from(loaded);

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

      for (final r in imported) {
        print("➡️ ${r.id} | ${r.name} | ${r.route}");
      }

      if (imported.isEmpty) {
        return (LoadResult.invalidFile, []);
      }

      _baseRoutes = List<RouteCSV>.from(imported);

      notifyListeners();

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

