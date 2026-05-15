
import 'dart:typed_data';

import 'package:crud_factories/Objects/RouteCSV.dart';

abstract class IRouterDataSource {

  Future<void> save (List<RouteCSV> routers);

  Future<List<RouteCSV>> load();

  Future<List<RouteCSV>> loadRoutesFromBytes(Uint8List bytes);
}