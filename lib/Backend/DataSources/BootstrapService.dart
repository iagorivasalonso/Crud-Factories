
import 'package:crud_factories/Alertdialogs/typeConnection.dart' show TypeConnection, TypeConnectionDialog;
import 'package:crud_factories/Backend/DataSources/IappDataSource.dart' show AppDataSource;
import 'package:crud_factories/Backend/DataSources/fileSystem.dart' show filesDataSource, FileDataSource;
import 'package:crud_factories/Backend/DataSources/filesDataWeb.dart' show WebUploadDataSource, AssetDataSource;
import 'package:crud_factories/Backend/Providers/App_provaider.dart';
import 'package:crud_factories/Backend/Providers/NavigationProvider.dart';
import 'package:crud_factories/Frontend/adminRoutes.dart' show AdminRoutesDialog;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as context show read;
import 'package:provider/provider.dart';



class BootstrapService {

  Future<AppDataSource?> resolve(BuildContext context) async {

    final app = context.read<AppProvider>();

    if(app.initialized)
    {
       return fromMode(app.mode);
    }


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
         return FileDataSource();

      case TypeConnection.sql:
           context.read<NavigationProvider>().go(AppView.connections);      //si es sql que vaya a la ventana
           return FileDataSource();

      case TypeConnection.empty:

        showDialog(
          context: context,
          builder: (_) => const AdminRoutesDialog(),
        );

        return null;     // si es vsacio que vaya a la ventana
    }
  }

  static AppDataSource fromMode(DataSourceMode mode) {

      switch(mode)
      {
         case DataSourceMode.csv:
            return FileDataSource();

        case DataSourceMode.sql:
              return FileDataSource();

        case DataSourceMode.api:
          return FileDataSource();
      }
  }
}