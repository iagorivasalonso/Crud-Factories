import 'package:crud_factories/Alertdialogs/typeConnection.dart' show FuentData, TypeConnectionDialog;
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



    final type = await TypeConnectionDialog(context);

    if (type == null) {
      return null;
    }

    switch(type){
      case FuentData.csv:

         app.mode = DataSourceMode.csv;
         return isApi == true
                    ? AssetDataSource()
                    : FileDataSource();

      case FuentData.sql:

        app.mode = isApi
            ? DataSourceMode.api
            : DataSourceMode.sql;

        return isApi == true
            ? AssetDataSource()
            : FileDataSource();


      case FuentData.empty:

        showDialog(
          context: context,
          builder: (_) => const AdminRoutesDialog(),
        );

        return null;     // si es vacio que vaya a la ventana
    }
  }

  static AppDataSource fromMode(DataSourceMode newMode) {

    switch (newMode) {
      case DataSourceMode.csv:
        return FileDataSource();

      case DataSourceMode.sql:
        return AssetDataSource();

      case DataSourceMode.api:
        return AssetDataSource();
    }
  }
}
