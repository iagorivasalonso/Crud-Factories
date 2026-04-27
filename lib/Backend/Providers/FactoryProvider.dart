import 'package:flutter/foundation.dart' hide Factory;
import 'package:crud_factories/Objects/Factory.dart';

class FactoryProvider extends ChangeNotifier {

  final List<Factory> _factories = [];

  List<Factory> get factories => List.unmodifiable(_factories);

  void setFactories(List<Factory> newFactories) {
    _factories
      ..clear()
      ..addAll(List.from(newFactories));

    notifyListeners();
  }

  void addFactory(Factory factory) {
    _factories.add(factory);
    notifyListeners();
  }

  void updateFactory(int index, Factory factory) {
    _factories[index] = factory;
    notifyListeners();
  }

  void deleteBySector(String sectorId) {
    _factories.removeWhere((f) => f.sector == sectorId);
    notifyListeners();
  }

  List<String> getIdsBySector(String sectorId) {
    return _factories
        .where((f) => f.sector == sectorId)
        .map((f) => f.id)
        .toList();
  }

  void delete(String id) {
    _factories.removeWhere((f) => f.id == id);
    notifyListeners();
  }

  void clear() {
    _factories.clear();
    notifyListeners();
  }
}