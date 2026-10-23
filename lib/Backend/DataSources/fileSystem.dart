
import 'dart:io';
import 'dart:typed_data';

import 'package:crud_factories/Alertdialogs/error.dart';
import 'package:crud_factories/Backend/Feature/Router/RouterStorage.dart';
import 'package:crud_factories/generated/l10n.dart' show S;
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;

import 'package:crud_factories/Backend/CSV/FileReader.dart';
import 'package:crud_factories/Backend/CSV/csvParse.dart';
import 'package:crud_factories/Backend/DataSources/RoutesBundle.dart';
import 'package:crud_factories/Objects/buldRouteFiles.dart' show RouteFilesBuilder;

import 'IappDataSource.dart';




class FileDataSource implements AppDataSource {

  @override
  Future<RoutesBundle> loadRoutes(BuildContext context) async {

    final routePath = await RoutersStorage.loadRoutesPath();

    if(routePath.isEmpty)
    {
      throw Exception(
        'No se ha configurado la ruta de routes.csv en SharedPreferences',
      );
    }

    final path = routePath;

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
