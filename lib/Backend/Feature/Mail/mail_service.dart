
import 'package:crud_factories/Backend/Feature/Connection/ExecuteQuery/IexecuteQuery.dart' show Iexecutequery;
import 'package:crud_factories/Backend/Feature/Mail/CsvMailDataSource.dart';
import 'package:crud_factories/Backend/Feature/Mail/IMailDataSource.dart';
import 'package:crud_factories/Backend/Feature/Mail/apiMailDataSource%20.dart';
import 'package:crud_factories/Backend/Feature/Mail/sqlMailDataSource.dart';
import 'package:crud_factories/Backend/Providers/App_provaider.dart';
import 'package:crud_factories/Backend/Repositories/mailRepository.dart';
import 'package:crud_factories/Objects/ApiConfig.dart' show ApiConfig;
import 'package:crud_factories/Objects/AppRoutesState.dart' show RouteFiles;

class RepositoryMail {

     static MailRepository create(
            DataSourceMode mode,
            RouteFiles files,
            {Iexecutequery? db, ApiConfig? config, String? userId}
          ) {

         late IMailDataSource dataSource;

         if (userId == null && mode != DataSourceMode.csv) {
           throw Exception("UserId is required for SQL mode");
         }


         switch(mode){
           case DataSourceMode.csv:
             dataSource = CsvMailDatasource(files.mails);
             break;
           case DataSourceMode.sql:
             if (db == null) {
               throw Exception("Database connection is null");
             }

             dataSource = SqlMailDataSource(
                 executeQuery: db,
                 userId:userId!
             );
             break;
           case DataSourceMode.api:
             if (config == null) {
               throw Exception("ApiConfig not initialized");
             }

             dataSource = apiMailDataSource(
                 config: config,
                 userId:userId!
             );
             break;
         }
         return MailRepository(dataSource);
     }

     static MailRepository createsysten(
         DataSourceMode mode,
         RouteFiles files,
         {Iexecutequery? db, ApiConfig? config}) {

       late IMailDataSource dataSource;

       switch (mode) {
         case DataSourceMode.csv:
           print('CREANDO CSV SYSTEM MAIL');
           dataSource = CsvMailDatasource(files.mails);
           break;

         case DataSourceMode.sql:
           print('CREANDO SQL SYSTEM MAIL');

           if (db == null) {
             throw Exception("Database connection is null");
           }

           dataSource = SqlMailDataSource(
             executeQuery: db,
             userId: '',
           );
           break;

         case DataSourceMode.api:
           print('CREANDO API SYSTEM MAIL');

           if (config == null) {
             throw Exception("ApiConfig not initialized");
           }

           dataSource = apiMailDataSource(
             config: config,
             userId: '',
           );
           break;
       }

       print('DATASOURCE CREADO: ${dataSource.runtimeType}');

       return MailRepository(dataSource);
     }
}
