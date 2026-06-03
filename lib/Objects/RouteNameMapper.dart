import 'package:crud_factories/Objects/RouterRegistry.dart' show RouteFileKey;

class RouteNameMapper {

  static RouteFileKey? fromString(String name) {

    switch (name.toLowerCase()) {

      case 'routes':
      case 'rutas':
        return RouteFileKey.routes;

      case 'connections':
      case 'conexiones':
        return RouteFileKey.connections;

      case 'server':
      case 'servidor':
        return RouteFileKey.server;

      case 'employees':
      case 'empleados':
        return RouteFileKey.employees;

      case 'sectors':
      case 'sectores':
        return RouteFileKey.sectors;

      case 'factories':
      case 'fabricas':
      case 'empresas':
        return RouteFileKey.factories;

      case 'lines':
      case 'lineas':
        return RouteFileKey.lines;

      case 'mails':
      case 'correos':
      case 'emails':
        return RouteFileKey.mails;

      default:
        print("⚠️ Ruta desconocida: $name");
        return null;
    }
  }
}