import 'package:crud_factories/Objects/BaseEntity.dart';

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