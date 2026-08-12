import 'package:crud_factories/Objects/BaseEntity.dart';

class RouteCSV extends BaseEntity {


  final String name;
  final String route;

  RouteCSV ({
    required super.id,
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