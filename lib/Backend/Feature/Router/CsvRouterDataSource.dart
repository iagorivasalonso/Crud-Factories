
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

     final update = routers;

     await csvExportatorRoutes(
         update,
         path: path,
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