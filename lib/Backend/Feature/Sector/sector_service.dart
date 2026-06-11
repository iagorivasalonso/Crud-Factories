import 'package:crud_factories/Backend/Feature/Connection/ExecuteQuery/IexecuteQuery.dart' show Iexecutequery;
import 'package:crud_factories/Backend/Feature/Sector/CsvSectorDataSource.dart' show CsvSectorDataSource;
import 'package:crud_factories/Backend/Feature/Sector/IsectorDataSource.dart' show ISectorDataSource;
import 'package:crud_factories/Backend/Feature/Sector/apiSectorDataSource%20.dart';

import 'package:crud_factories/Backend/Providers/App_provaider.dart' show DataSourceMode;
import 'package:crud_factories/Backend/Repositories/sectorRepository.dart' show SectorRepository;
import 'package:crud_factories/Objects/AppRoutesState.dart' show RouteFiles;

import '../../../Objects/ApiConfig.dart';
import 'sqlSectorDataSource.dart';



  class RepositorySector {

      static SectorRepository create(
            DataSourceMode mode,
            RouteFiles files,
            {Iexecutequery? db, required ApiConfig config,}
      ) {
        late ISectorDataSource datasource;

        switch (mode) {

          case DataSourceMode.csv:
            datasource = CsvSectorDataSource(files.sectors);
            break;

          case DataSourceMode.sql:
            if (db == null) {
              throw Exception("Database connection is null");
            }

            datasource = SqlSectorDataSource(
                executeQuery:db
            );

           break;
          case DataSourceMode.api:

            datasource = ApiSectorDataSource(
                config:config,
            );

            break;
        }

        return SectorRepository(datasource);
      }
  }
