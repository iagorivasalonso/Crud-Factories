
import 'package:crud_factories/Backend/Feature/Connection/ExecuteQuery/IexecuteQuery.dart';
import 'package:crud_factories/Backend/Feature/LineSend/CsvLineSendDataSource.dart';
import 'package:crud_factories/Backend/Feature/LineSend/ILineSendDataSource.dart';
import 'package:crud_factories/Backend/Feature/LineSend/apiLineSendDataSource%20.dart';
import 'package:crud_factories/Backend/Feature/LineSend/sqlLineSendDataSource.dart';
import 'package:crud_factories/Backend/Providers/App_provaider.dart';
import 'package:crud_factories/Backend/Repositories/lineSendRepository.dart';
import 'package:crud_factories/Objects/ApiConfig.dart';
import 'package:crud_factories/Objects/AppRoutesState.dart';

class RepositoryLineSend {

  static LinesendRepository create(
       DataSourceMode mode,
       RouteFiles files,
       {Iexecutequery? db, ApiConfig? config}
      ){

    late ILineSendDatasource dataSource;

    switch(mode){
      case DataSourceMode.csv:
            dataSource = CsvLineSendDatasource(files.linesSends);
        break;
      case DataSourceMode.sql:
        if (db == null) {
          throw Exception("Database connection is null");
        }

        dataSource = SqlLinesendDatasource(
            executeQuery: db
        );
        break;
      case DataSourceMode.api:
        if (config == null) {
          throw Exception("ApiConfig not initialized");
        }

        dataSource = apiLinesendDatasource(
            config: config
        );
        break;
    }
    return LinesendRepository(dataSource);
  }
}