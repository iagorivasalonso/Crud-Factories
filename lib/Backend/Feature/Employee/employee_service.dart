
import 'package:crud_factories/Backend/Feature/Connection/ExecuteQuery/IexecuteQuery.dart' show Iexecutequery;
import 'package:crud_factories/Backend/Feature/Employee/CsvEmployeeDataSource.dart';
import 'package:crud_factories/Backend/Feature/Employee/IEmployeeDataSource.dart';
import 'package:crud_factories/Backend/Feature/Employee/apiEmployeeDataSource%20.dart' show ApiEmployeeDataSource;
import 'package:crud_factories/Backend/Feature/Employee/sqlEmployeeDataSource.dart';
import 'package:crud_factories/Backend/Providers/App_provaider.dart' show DataSourceMode;
import 'package:crud_factories/Backend/Repositories/employeeRepository.dart';
import 'package:crud_factories/Objects/ApiConfig.dart' show ApiConfig;
import 'package:crud_factories/Objects/AppRoutesState.dart' show RouteFiles;

class RepositoryEmployee {

  static EmployeeRepository create (
      DataSourceMode mode,
      RouteFiles files,
      {Iexecutequery? db, ApiConfig? config,}
      ) {
       late IEmployeeDataSource dataSource;

       switch(mode){

         case DataSourceMode.csv:
           dataSource = Csvemployeedatasource(files.employees);
          break;

         case DataSourceMode.sql:
           if (db == null) {
             throw Exception("Database connection is null");
           }

           dataSource = SqlEmployeeDataSource (
              executeQuery: db,
           );
          break;
         case DataSourceMode.api:
           if (config == null) {
             throw Exception("ApiConfig not initialized");
           }
           dataSource = ApiEmployeeDataSource(
              config: config
           );
          break;
       }
       return EmployeeRepository(dataSource);
  }

}