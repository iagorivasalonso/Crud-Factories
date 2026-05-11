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

  RouteCSV copyWith({
    String? id,
    String? name,
    String? route,
  }) {
    return RouteCSV(
      id: id ?? this.id,
      name: name ?? this.name,
      route: route ?? this.route,
    );
  }


}