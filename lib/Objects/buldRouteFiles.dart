
import 'package:crud_factories/Objects/AppRoutesState.dart' show RouteFiles;
import 'package:crud_factories/Objects/RouteCSV.dart' show RouteCSV;
import 'package:crud_factories/Objects/RouterRegistry.dart' show RouterRegistry, RouteFileKey;

class RouteFilesBuilder  {

  static RouteFiles buildRouteFiles(List<RouteCSV> routes) {
    final registry = RouterRegistry.fromRoutes(routes);

    return RouteFiles(
      routes: registry.get(RouteFileKey.routes),
      connections: registry.get(RouteFileKey.connections),
      server: registry.tryGet(RouteFileKey.server),
      employees: registry.get(RouteFileKey.employees),
      sectors: registry.get(RouteFileKey.sectors),
      factories: registry.get(RouteFileKey.factories),
      lines: registry.get(RouteFileKey.lines),
      mails: registry.get(RouteFileKey.mails),
    );
  }
}
