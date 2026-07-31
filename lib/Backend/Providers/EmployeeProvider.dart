

import 'package:crud_factories/Backend/ImportGeneral/import_Processor.dart' show processImport;
import 'package:crud_factories/Backend/Repositories/employeeRepository.dart' show EmployeeRepository;
import 'package:crud_factories/Objects/importResult.dart' show ImportResult;
import 'package:crud_factories/generated/l10n.dart' show S;
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:crud_factories/Objects/Empleoye.dart';

class EmployeeProvider extends ChangeNotifier {

  late EmployeeRepository repository;

  List<Empleoyee> _Empleoyees = [];

  List<Empleoyee> get empleoyees => List.unmodifiable(_Empleoyees);

  //======================
  //   LOAD
  //======================

  Future<void> load() async {

    try{
       final data = await _repo.load();

       _Empleoyees = data;

       notifyListeners();
    }catch(e) {
      print("Error load: $e");
    }
  }
  // =========================
  //  IMPORTLIST
  // =========================
  Future<ImportResult> import({
    required BuildContext context,
    required List<Empleoyee> EmployeesNews
  }) async {

    final result = ImportResult(
        entity: S.of(context).employees
    );

    if (EmployeesNews.isEmpty) return result;

    final employees = await _repo.load();

    result.inserted = await processImport(
      newList: EmployeesNews,
      existingList: employees,
      getKey: (e) => e.name,
      setId: (e, id) => e.id = id,
    );

    if (result.inserted > 0) {
      await load();
      await _repo.save(employees);
    }

    return result;
  }

  // =========================
  //  RELOAD REPO
  // =========================

  Future<void> setRepositoryAndReload(EmployeeRepository repo) async {
    repository = repo;
    _Empleoyees = [];
    notifyListeners();

    await load();
  }
  // ====================================
  //    ADD EMPEOYES
  //====================================

  Future<void> addEmployees(List<Empleoyee> employees) async {

    final newEmployees = employees.where(
          (e) => !_Empleoyees.any((x) => x.id == e.id),
    );

    await Future.wait(
      newEmployees.map((e) => repository.insert(e)),
    );

    _Empleoyees.addAll(newEmployees);
    notifyListeners();
  }

  // ====================================
  //    DELETE EMPEOYES
  //====================================
  Future<void> removeEmployees(List<String> ids) async {
    for (final id in ids) {
      await repository.delete(id);
    }

    _Empleoyees.removeWhere((e) => ids.contains(e.id));
    notifyListeners();
  }

  // ====================================
  //    DELETE ALL EMPEOYES FOR FACTORY
  //====================================
  Future<void> removeFactoryEmployees(String factoryId) async {

    try {
      await repository.deleteByFactory(factoryId);

      _Empleoyees.removeWhere(
            (employee) => employee.idFactory == factoryId,
      );

      notifyListeners();
    } catch (e) {
      print("Error deleting employees from factory: $e");
    }
  }


  //======================
  //  GETREPO
  //======================

  EmployeeRepository get _repo {
    final r = repository;
    if (r == null) {
      throw Exception("Repository not initialized");
    }
    return r;
  }
}