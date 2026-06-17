import 'package:fluent_ui/fluent_ui.dart';

class FilterProvider extends ChangeNotifier {
  String sectorId = "0"; // siempre inicializado

  bool get isAll => sectorId == "0";

  void setSector(String id) {
    sectorId = id;
    notifyListeners();
  }

  void setAll() {
    sectorId = "0";
    notifyListeners();
  }
}