import 'package:flutter/foundation.dart';
import 'package:crud_factories/Objects/Empleoye.dart';

class EmployeeProvider extends ChangeNotifier {

  final List<Empleoye> _employees = [];

  List<Empleoye> get employees => List.unmodifiable(_employees);

  void setEmployees(List<Empleoye> data) {
    _employees
      ..clear()
      ..addAll(data);

    notifyListeners();
  }

  void addEmployee(Empleoye employee) {
    _employees.add(employee);
    notifyListeners();
  }

  void deleteById(String id) {
    _employees.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  void deleteByFactory(String factoryId) {
    _employees.removeWhere((e) => e.idFactory == factoryId);
    notifyListeners();
  }

  void deleteByFactories(List<String> factoryIds) {
    _employees.removeWhere((e) => factoryIds.contains(e.idFactory));
    notifyListeners();
  }

  void clear() {
    _employees.clear();
    notifyListeners();
  }
}