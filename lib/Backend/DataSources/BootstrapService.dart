
import 'package:crud_factories/Alertdialogs/typeConnection.dart' show TypeConnection, TypeConnectionDialog;
import 'package:crud_factories/Backend/DataSources/fileSystem.dart' show filesDataSource, FileDataSource;
import 'package:crud_factories/Backend/DataSources/filesDataWeb.dart' show WebUploadDataSource, AssetDataSource;
import 'package:crud_factories/Backend/Providers/NavigationProvider.dart';
import 'package:crud_factories/Frontend/adminRoutes.dart' show AdminRoutesDialog;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as context show read;
import 'package:provider/provider.dart';

import 'AppDataSource.dart';

class BootstrapService {

  Future<AppDataSource?> resolve(BuildContext context) async {

    // 🌐 WEB
    if (kIsWeb) {
      return AssetDataSource();
    }



    // 🪟 WINDOWS / DESKTOP
    final type = await TypeConnectionDialog(context);

    if (type == null) {
      return null;
    }

    switch(type){
      case TypeConnection.csv:
         return FileDataSource(); //si es sql que vaya a la ventana

      case TypeConnection.sql:
           context.read<NavigationProvider>().go(AppView.connections);
           return null;

      case TypeConnection.empty:

        showDialog(
          context: context,
          builder: (_) => const AdminRoutesDialog(),
        );

        return null;     // si es vsacio que vaya a la ventana
    }
  }
}