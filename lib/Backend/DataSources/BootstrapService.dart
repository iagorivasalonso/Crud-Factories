import 'package:crud_factories/Backend/DataSources/filesDataWeb.dart' show WebUploadDataSource, AssetDataSource;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'AppDataSource.dart';

class BootstrapService {

  AppDataSource resolve(BuildContext context) {

    // 🌐 WEB
   // if (kIsWeb) {
      return AssetDataSource();
  //  }
/*
    // 🪟 WINDOWS / DESKTOP
    final type = await showTypeConnectionDialog(context);

    switch (type) {

      case TypeConnection.csv:
        return FileDataSource("ruta");

      case TypeConnection.sql:
        throw UnimplementedError("SQL not implemented yet");
    }**/
  }
}