import 'package:crud_factories/Objects/LineSend.dart' show LineSend;
import 'package:flutter/foundation.dart';


class LineSendProvider extends ChangeNotifier {

  final List<LineSend> _Lines = [];

  List<LineSend> get LineSends => List.unmodifiable(_Lines);

  void setLineSends(List<LineSend> data) {
    _Lines
      ..clear()
      ..addAll(data);

    notifyListeners();
  }

  void addLineSend(LineSend LineSend) {
    _Lines.add(LineSend);
    notifyListeners();
  }

  void deleteById(String id) {
    _Lines.removeWhere((l) => l.id == id);
    notifyListeners();
  }

  void clear() {
    _Lines.clear();
    notifyListeners();
  }
}