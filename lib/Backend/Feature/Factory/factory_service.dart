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
      {Iexecutequery? db,  ApiConfig? config, String? userId,}
      ) {
       late IFactoryDataSource dataSource;

       if (userId == null && mode != DataSourceMode.csv) {
         throw Exception("UserId is required for SQL mode");
       }

       switch(mode) {
         case DataSourceMode.csv:
            dataSource = CsvFactorydatasource(files.factories);
           break;
         case DataSourceMode.sql:
           if (db == null) {
             throw Exception("Database connection is null");
           }

           dataSource = SqlFactoryDataSource(
               executeQuery: db,
               userId:userId!
           );
           break;
         case DataSourceMode.api:
           if (config == null) {
             throw Exception("ApiConfig not initialized");
           }
            dataSource = apiFactoryDataSource(
                config: config,
                userId:userId!
            );
           break;
       }
       return FactoryRepository(dataSource);
      }
}
