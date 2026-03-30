import 'package:crud_factories/Frontend/importData.dart' show BaseEntity;

class RouteCSV extends BaseEntity {

  String id;
  String name;
  String route;

  RouteCSV ({
    required this.id,
    required this.name,
    required this.route
  });
}