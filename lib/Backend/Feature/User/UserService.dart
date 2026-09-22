
import 'package:crud_factories/Backend/Feature/User/ApiUserService.dart';
import 'package:crud_factories/Backend/Feature/User/IUserDataSource.dart';
import 'package:crud_factories/Backend/Feature/User/SqlUserService.dart';
import 'package:crud_factories/Backend/Providers/App_provaider.dart' show DataSourceMode;
import 'package:crud_factories/Backend/Repositories/userRepository.dart';

import '../../../Objects/ApiConfig.dart';
import '../../../Objects/AppRoutesState.dart';
import '../Connection/ExecuteQuery/IexecuteQuery.dart';

class RepositoryUser {

  static UserRepository create(
      DataSourceMode mode,
      RouteFiles files,
      {Iexecutequery? db, ApiConfig? config, String? userId,}
      ) {
          late IUserDataSource dataSource;

          switch (mode) {

            case DataSourceMode.csv:
            // TODO: Handle this case.
              throw UnimplementedError();

            case DataSourceMode.sql:

              if (db == null) {
                throw Exception("Database connection is null");
              }

              dataSource = SqlUserDataSource(
                  executeQuery: db
              );

            case DataSourceMode.api:

              if (config == null) {
                throw Exception("ApiConfig not initialized");
              }

              dataSource = ApiUserDataSource(
                  config: config,
              );
          }
          return UserRepository(dataSource: dataSource);

  }
}