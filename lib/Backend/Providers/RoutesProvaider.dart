import 'package:crud_factories/Objects/RouteCSV.dart' show RouteCSV;
import 'package:fluent_ui/fluent_ui.dart';

class RoutesProvaider extends ChangeNotifier {

  final List<RouteCSV> _routes = [];

  List<RouteCSV> get routes => List.unmodifiable(_routes);

  void setRoutes(List<RouteCSV> data) {
    _routes
      ..clear()
      ..addAll(List.from(data));

    notifyListeners();
  }

  void addRoute(RouteCSV route) {
    _routes.add(route);
    notifyListeners();
  }

  void delete(RouteCSV route) {
    _routes.remove(route);
    notifyListeners();
  }

  void clear() {
    _routes.clear();
    notifyListeners();
  }
}