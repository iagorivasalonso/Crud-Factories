import 'package:crud_factories/Objects/RouterRegistry.dart' show RouteFileKey;

class RouteNameMapper {

  static RouteFileKey? fromString(String name) {

    switch (name.trim().toLowerCase()) {

      case 'rutas':
        return RouteFileKey.routes;

      case 'conexiones':
        return RouteFileKey.connections;

      case 'sectores':
        return RouteFileKey.sectors;

      case 'empresas':
        return RouteFileKey.factories;

      case 'empleados':
        return RouteFileKey.employees;

      case 'lineas':
        return RouteFileKey.lines;

      case 'emails':
        return RouteFileKey.mails;

      default:
        return null;
    }
  }
}