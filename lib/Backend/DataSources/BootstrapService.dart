import 'package:crud_factories/Alertdialogs/defaultData.dart' show FuenteData, defaultData;
import 'package:crud_factories/Alertdialogs/typeConnection.dart' show TypeConnection, TypeConnectionDialog;
import 'package:crud_factories/Backend/DataSources/IappDataSource.dart' show AppDataSource;
import 'package:crud_factories/Backend/DataSources/fileSystem.dart' show FileDataSource;
import 'package:crud_factories/Backend/DataSources/filesDataWeb.dart' show AssetDataSource;
import 'package:crud_factories/Backend/Providers/App_provaider.dart';
import 'package:crud_factories/Backend/Providers/NavigationProvider.dart';
import 'package:crud_factories/Frontend/adminRoutes.dart' show AdminRoutesDialog;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class BootstrapService {

  Future<AppDataSource?> resolve(BuildContext context, bool isApi) async {

    final app = context.read<AppProvider>();

    if(app.initialized)
    {
       return fromMode(app.mode);
    }


    // 🌐 WEB/API
    if (isApi) {

         final type = await defaultData(context);

         if (type == null) {
           return null;
         }

           switch(type){

             case FuenteData.defaultData:
                         return AssetDataSource();
             case FuenteData.newData:

               showDialog(
                 context: context,
                 builder: (_) => const AdminRoutesDialog(),
               );

               return null;

           }
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
           return null;

      case TypeConnection.empty:

        showDialog(
          context: context,
          builder: (_) => const AdminRoutesDialog(),
        );

        return null;     // si es vacio que vaya a la ventana
    }
  }

  static AppDataSource fromMode(DataSourceMode newMode) {

      return FileDataSource();
  }
}