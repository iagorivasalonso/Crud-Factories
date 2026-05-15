import 'dart:convert';
import 'dart:typed_data';

import 'package:crud_factories/Backend/CSV/csvReader.dart';
import 'package:crud_factories/Backend/CSV/csvParse.dart';
import 'package:crud_factories/Backend/DataSources/RoutesBundle.dart' show RoutesBundle;
import 'package:crud_factories/Objects/buldRouteFiles.dart';

import 'IappDataSource.dart';

class AssetDataSource  implements AppDataSource {
  
  static const String path = 'assets/dataDefault/routes.csv';

  @override
  Future<RoutesBundle> loadRoutes() async {

    final raw = await CsvReader.fromAsset(path);

    final routes = csvParse.parseRoutes(raw);

    final files = RouteFilesBuilder.buildRouteFiles(routes);

    return RoutesBundle(routes, files);
  }

  @override
  Future<RoutesBundle> loadRoutesFromBytes(
      Uint8List bytes,
      ) async {

    final raw =
    utf8.decode(bytes);

    final routes =
    csvParse.parseRoutes(raw);

    final files =
    RouteFilesBuilder.buildRouteFiles(
      routes,
    );

    return RoutesBundle(
      routes,
      files,
    );
  }



}