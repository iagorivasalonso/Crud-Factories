
import 'package:crud_factories/Objects/RouteCSV.dart' show RouteCSV;
import 'package:crud_factories/Objects/RouteNameMapper.dart' show RouteNameMapper;

enum RouteFileKey {
  routes,
  connections,
  server,
  employees,
  sectors,
  factories,
  lines,
  mails,
}

class RouterRegistry {

  final Map<RouteFileKey, String> _routes;

  RouterRegistry(this._routes);

  factory RouterRegistry.fromRoutes(List<RouteCSV> routes,){
    final map = <RouteFileKey, String>{};
    for (final r in routes) {
      print(r.route);
      final key = RouteNameMapper.fromString(r.name);

      if (key == null) {
        print("⚠️ Ruta desconocida: ${r.name}");
        continue;
      }

      map[key] =r.route;
    }

    return RouterRegistry(map);
  }

  String? tryGet(RouteFileKey key) {
    return _routes[key];
  }
  String get(RouteFileKey key) {
    final value = _routes[key];

    if (value == null || value.isEmpty) {
      throw Exception("Ruta faltante: $key");
    }

    return value;
  }

}