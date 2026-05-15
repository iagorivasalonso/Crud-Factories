
import 'dart:typed_data';

import 'package:crud_factories/Backend/Feature/Router/IRouterDataSource.dart';
import 'package:crud_factories/Objects/RouteCSV.dart';

class routerRepository {

  final IRouterDataSource dataSource;

  routerRepository(this.dataSource);

  Future<void> save(List<RouteCSV>routes) {
    return dataSource.save(routes);
  }

  Future<List<RouteCSV>> load () {
     return dataSource.load();
  }

  Future<List<RouteCSV>> importFromBytes(
      Uint8List bytes,
      ) {

    return dataSource.loadRoutesFromBytes(bytes);
  }
}