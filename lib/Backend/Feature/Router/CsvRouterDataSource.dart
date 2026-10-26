
import 'dart:typed_data';

import 'package:crud_factories/Backend/Feature/Router/exportRoutes.dart';
import 'package:crud_factories/Backend/Feature/Router/importRoutes.dart';
import 'package:crud_factories/Backend/Feature/Router/IRouterDataSource.dart';
import 'package:crud_factories/Objects/RouteCSV.dart';

class CsvRouterDataSource implements IRouterDataSource{

  final String path;

  CsvRouterDataSource(this.path);

  @override
  Future<List<RouteCSV>> load() async {

    return await csvImportRoutes(
      path: path,
    );
  }

  @override
  Future<void> save(List<RouteCSV> routers) async {

    final directory = routers[0].route;
    final newPath = '$directory';

    await csvExportatorRoutes(
      routers,
      path: newPath,
    );

  }

  @override
  Future<List<RouteCSV>> loadRoutesFromBytes(Uint8List bytes) {
    // TODO: implement loadRoutesFromBytes
      return csvImportRoutes(
          bytes: bytes,
          path: this.path
      );
  }

}
