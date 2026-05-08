import 'package:crud_factories/Objects/AppRoutesState.dart' show RouteFiles;
import 'package:crud_factories/Objects/RouteCSV.dart' show RouteCSV;

class RoutesBundle {
  final List<RouteCSV> routes;
  final RouteFiles files;

  RoutesBundle(this.routes, this.files);
}