
import 'dart:io';
import 'dart:typed_data';

import 'package:path/path.dart' as p;

import 'package:crud_factories/Backend/CSV/FileReader.dart';
import 'package:crud_factories/Backend/CSV/csvParse.dart';
import 'package:crud_factories/Backend/DataSources/RoutesBundle.dart';
import 'package:crud_factories/Objects/buldRouteFiles.dart' show RouteFilesBuilder;

import 'IappDataSource.dart';




class FileDataSource implements AppDataSource {

  static const String fileName = 'routes.csv';

  @override
  Future<RoutesBundle> loadRoutes() async {

    final parentDir = Directory.current.parent;

    final path = p.join(parentDir.path, fileName);

    final file = File(path);

    if (!await file.exists()) {
      throw Exception("FILE NOT FOUND: $path");
    }

    final raw = await FileReader.fromFile(path);

    final routes = csvParse.parseRoutes(raw);

    final files = RouteFilesBuilder.buildRouteFiles(routes);

    return RoutesBundle(routes, files);
  }

  @override
  Future<RoutesBundle> loadRoutesFromBytes(Uint8List bytes) async {

    final raw = String.fromCharCodes(bytes);

    final routes = csvParse.parseRoutes(raw);

    final files = RouteFilesBuilder.buildRouteFiles(routes);

    return RoutesBundle(routes, files);
  }
}