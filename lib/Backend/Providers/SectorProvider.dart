import 'package:flutter/foundation.dart';
import 'package:crud_factories/Objects/Sector.dart';

class SectorProvider extends ChangeNotifier {

  final List<Sector> _sectors = [];

  List<Sector> get sectors => List.unmodifiable(_sectors);

  void setSectors(List<Sector> data) {
    _sectors
      ..clear()
      ..addAll(List.from(data));

    notifyListeners();
  }

  void addSector(Sector sector) {
    _sectors.add(sector);
    notifyListeners();
  }

  void delete(String id) {
    _sectors.removeWhere((s) => s.id == id);
    notifyListeners();
  }

  void clear() {
    _sectors.clear();
    notifyListeners();
  }
}