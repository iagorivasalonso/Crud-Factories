
import 'package:crud_factories/Objects/AppRoutesState.dart' show RouteFiles;
import 'package:crud_factories/Objects/RouteCSV.dart' show RouteCSV;
import 'package:crud_factories/Objects/RouterRegistry.dart' show RouterRegistry, RouteFileKey;

class RouteFilesBuilder  {


  static RouteFiles buildRouteFiles(List<RouteCSV> routes) {
  final registry = RouterRegistry.fromRoutes(routes);

  return RouteFiles(
  routes: registry.tryGet(RouteFileKey.routes) ?? '',
  connections: registry.tryGet(RouteFileKey.connections) ?? '',
  server: registry.tryGet(RouteFileKey.server),
  employees: registry.tryGet(RouteFileKey.employees) ?? '',
  sectors: registry.tryGet(RouteFileKey.sectors) ?? '',
  factories: registry.tryGet(RouteFileKey.factories) ?? '',
  linesSends: registry.tryGet(RouteFileKey.lines) ?? '',
  mails: registry.tryGet(RouteFileKey.mails) ?? '',
  );
  }
}