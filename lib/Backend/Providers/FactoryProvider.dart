import 'package:crud_factories/Backend/Data/controlsMessagesError/errors.dart' show CreateResult, EditResult, DeleteResult;
import 'package:crud_factories/Backend/Repositories/factoryRepository.dart' show FactoryRepository;
import 'package:crud_factories/Functions/createId.dart' show createId;
import 'package:flutter/foundation.dart' hide Factory;
import 'package:crud_factories/Objects/Factory.dart';

class FactoryProvider extends ChangeNotifier {

  FactoryRepository? repository;

  List<Factory> _factories = [];
  Factory? selected;

  List<Factory> get factories => List.unmodifiable(_factories);

  // =========================
  //        LOAD
  // =========================

  Future<void> load() async {
    try {
      final data = await _repo.load();

      _factories = data;

      notifyListeners();
    } catch (e) {
      print("Error cargando factories: $e");
      _factories = [];
      notifyListeners();
    }
  }

  // =========================
  // SELECT
  // =========================

  void select(Factory? f) {

    selected = f;
    notifyListeners();
  }

  // =========================
  //   SET FACTORIES
  // =========================

  void setFactories(List<Factory> data) {
    _factories
      ..clear()
      ..addAll(List.from(data));

    notifyListeners();
  }

  // ==============================
  //   SET FACTORIES BY SECTOR
  // ==============================

  List<Factory> factoriesBySector(String sectorId) {
    if (sectorId == "0") return _factories;

    final cleanSectorId = sectorId.trim();

    return _factories.where((f) {
      final factorySector = f.sector?.toString().trim();
      return factorySector == cleanSectorId;
    }).toList();
  }


  // =========================
  //   ADD FACTORIES
  // =========================

  void addFactories(Factory factory) {
    _factories.add(factory);
    notifyListeners();
  }


  // =========================
  //  EXISTFACTORY
  // =========================

  bool exist(String name, {String? exclude}) {
    final nameLower = name.toLowerCase();

    return _factories.any((f) {
      final factoryMame = f.name.toLowerCase();

      if (exclude != null && factoryMame == exclude.toLowerCase()) {
        return false;
      }

      return factoryMame == nameLower;
    });
  }

  // =========================
  //  CLEAR
  // =========================

  void clear() {
    _factories.clear();
    notifyListeners();
  }

  // =========================
  //  GETREPO
  // =========================

  FactoryRepository get _repo {
    final r = repository;
    if (r == null) {
      throw Exception("Repository not initialized");
    }
    return r;
  }

  // =========================
  //  RELOAD REPO
  // =========================

  Future<void> setRepositoryAndReload(FactoryRepository repo) async {
    repository = repo;
    _factories = [];
    notifyListeners();

    await load();
  }

  // =========================
  //  CREATE
  // =========================

  Future<CreateResult> create(Factory factory) async {
    final name = factory.name?.trim();

    if (name == null || name.isEmpty) {
      return CreateResult.invalidData;
    }

    final exits = exist(name);

    if (exits) {
      return CreateResult.alreadyExists;
    }

    final newFactory = Factory(
        id: factory.id,
        name: factory.name,
        highDate: factory.highDate,
        sector: factory.sector,
        thelephones: factory.thelephones,
        mail: factory.mail,
        web: factory.web,
        address: Address(
            street: factory.address.street,
            number: factory.address.number,
            city: factory.address.city,
            province: factory.address.province,
            postcode: factory.address.postcode
        )
    );

    _factories.add(newFactory);
    notifyListeners();
    await _repo.insert(newFactory);

    return CreateResult.success;
  }

  // =========================
  //  UPDATE
  // =========================
  Future<EditResult> update(Factory update) async {
    if (update.name == null || update.name!.trim().isEmpty) {
      return EditResult.invalidData;
    }

    final name = update.name!.trim();

    final index = _factories.indexWhere((f) => f.id == update.id);
    if (index == -1) {
      return EditResult.notFound;
    }

    final oldFactory = _factories[index];

    if (exist(name, exclude: oldFactory.name)) {
      return EditResult.alreadyExists;
    }


    final newFactory = Factory(
      id: update.id,
      name: update.name,
      highDate: update.highDate,
      sector: update.sector,
      thelephones: update.thelephones,
      mail: update.mail,
      web: update.web,
      address: Address(
        street: update.address.street,
        number: update.address.number,
        city: update.address.city,
        province: update.address.province,
        postcode: update.address.postcode,
      ),
    );

    _factories[index] = newFactory;

    notifyListeners();

    await _repo.upload(newFactory);
    return EditResult.success;
  }

  Future<DeleteResult> delete(String id) async {
    final index = _factories.indexWhere((f) => f.id == id);

    if (index == -1) {
      return DeleteResult.notFound;
    }

    final removed = _factories[index];

    // optimista
    _factories.removeAt(index);
    notifyListeners();

    try {
      await _repo.delete(id);
      return DeleteResult.success;
    } catch (e) {
      // rollback
      _factories.insert(index, removed);
      notifyListeners();
      return DeleteResult.notFound;
    }
  }

}


