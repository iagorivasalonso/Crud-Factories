import 'package:crud_factories/Backend/Feature/Connection/ExecuteQuery/IexecuteQuery.dart' show Iexecutequery;
import 'package:crud_factories/Backend/Feature/Factory/CsvFactoryDataSource.dart';
import 'package:crud_factories/Backend/Feature/Factory/IFactoryDataSource.dart';
import 'package:crud_factories/Backend/Feature/Factory/apiFactoryDataSource%20.dart';
import 'package:crud_factories/Backend/Feature/Factory/sqlFactoryDataSource.dart';
import 'package:crud_factories/Backend/Providers/App_provaider.dart' show DataSourceMode;
import 'package:crud_factories/Backend/Repositories/factoryRepository.dart';
import 'package:crud_factories/Objects/ApiConfig.dart' show ApiConfig;
import 'package:crud_factories/Objects/AppRoutesState.dart' show RouteFiles;

class RepositoryFactory{

  static FactoryRepository create(
      DataSourceMode mode,
      RouteFiles files,
      {Iexecutequery? db,  ApiConfig? config,}
      ) {
       late IFactoryDataSource dataSource;

       switch(mode) {
         case DataSourceMode.csv:
            dataSource = CsvFactorydatasource(files.factories);
           break;
         case DataSourceMode.sql:
           if (db == null) {
             throw Exception("Database connection is null");
           }

           dataSource = SqlFactoryDataSource(
               executeQuery: db
           );
           break;
         case DataSourceMode.api:
           if (config == null) {
             throw Exception("ApiConfig not initialized");
           }
            dataSource = apiFactoryDataSource(
                config: config
            );
           break;
       }
       return FactoryRepository(dataSource);
      }
}