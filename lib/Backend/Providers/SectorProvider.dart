
import 'package:crud_factories/Backend/Feature/Sector/IsectorDataSource.dart';
import 'package:crud_factories/Backend/Providers/FactoryProvider.dart' show FactoryProvider;
import 'package:crud_factories/Backend/Repositories/sectorRepository.dart' show SectorRepository;
import 'package:crud_factories/Backend/Data/controlsMessagesError/errors.dart' show CreateResult, EditResult, DeleteResult;
import 'package:crud_factories/Functions/createId.dart';
import 'package:flutter/foundation.dart';
import 'package:crud_factories/Objects/Sector.dart';



class SectorProvider extends ChangeNotifier {


  SectorRepository? repository;


  List<Sector> _sectors = [];

  List<Sector> get sectors => List.unmodifiable(_sectors);

  // =========================
  // LOAD
  // =========================

  Future<void> load() async {
    try {
      final data = await _repo.load();

      _sectors = data;

      notifyListeners();
    } catch (e) {
      print("Error load: $e");
      _sectors = [];
      notifyListeners();
    }
  }


  // =========================
  //  SETSECTORS
  // =========================


  void setSectors(List<Sector> data) {
    _sectors
      ..clear()
      ..addAll(List.from(data));

    notifyListeners();
  }

  // =========================
  //  ADDSECTORS
  // =========================
  void addSector(Sector sector) {
    _sectors.add(sector);
    notifyListeners();
  }

  // =========================
  //  EXISTSECTORS
  // =========================

  bool exist(String name, {String? exclude}) {
    final nameLower = name.toLowerCase();

    return _sectors.any((s) {
      final sectorName = s.name.toLowerCase();

      if (exclude != null && sectorName == exclude.toLowerCase()) {
        return false;
      }

      return sectorName == nameLower;
    });
  }

  // =========================
  //  CLEAR
  // =========================

  void clear() {
    _sectors.clear();
    notifyListeners();
  }

  // =========================
  //  GETREPO
  // =========================

  SectorRepository get _repo {
    final r = repository;
    if (r == null) {
      throw Exception("Repository not initialized");
    }
    return r;
  }

  // =========================
  //  RELOAD REPO
  // =========================

  Future<void> setRepositoryAndReload(SectorRepository repo) async {
     repository = repo;
    _sectors = [];
    notifyListeners();

    await load();
  }
  // =========================
  //  CREATE
  // =========================
  Future<CreateResult> create(Sector sector) async {

    final name = sector.name?.trim();

    if (name == null || sector.name.isEmpty) {
      return CreateResult.invalidData;
    }

    final exits = exist(name);

    if (exits) {
      return CreateResult.alreadyExists;
    }

    final idNew = sectors.isNotEmpty
        ? createId(sectors.last.id)
        : "1";

    final newSector = Sector(
        id: idNew,
        name: name
    );

    _sectors.add(newSector);
    notifyListeners();
    await  _repo.insert(newSector);

    return CreateResult.success;
  }

  // =========================
  //  UPDATE
  // =========================
  Future<EditResult> update(Sector update) async {

    if(update.name == null || update.name!.trim().isEmpty){
       return EditResult.invalidData;
    }

    final name = update.name!.trim();

    final index = _sectors.indexWhere((s) => s.id == update.id);
    if (index == -1) {
      return EditResult.notFound;
    }

    final oldSector = _sectors[index];

    if (exist(name, exclude: oldSector.name)) {
      return EditResult.alreadyExists;
    }


    final newSector = Sector(
      id: update.id,
      name: name,
    );

    _sectors[index] = newSector;

    notifyListeners();

    await _repo.upload(newSector);
    return EditResult.success;
  }

  Future<DeleteResult> delete(
      int index,
      FactoryProvider factoryProvider,
      ) async {

     if(_sectors.isEmpty || index >= _sectors.length)
       return DeleteResult.notFound;

     final sector = _sectors[index];

     final hasFactories = factoryProvider.factories.any(
           (f) => f.sector == sector.id,
     );

     if (hasFactories) {
       return DeleteResult.hasDependencies;
     }

     final removed = _sectors.removeAt(index);
     try {
       //  persistencia
       await _repo.delete(
           sector.id
       );
       notifyListeners();

     } catch (e) {
        _sectors.insert(index,removed);
        notifyListeners();
       return DeleteResult.notFound;
     }
     return DeleteResult.success;
  }
}