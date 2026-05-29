

import 'package:crud_factories/Objects/Conection.dart';
import '../Feature/Connection/Datasource/IConnection_repository.dart';

class ConnectionRepository {

  final IConnectionDataSource  dataSource;

  ConnectionRepository(this.dataSource);

  Future<void> save( Conection connection){
     return dataSource.save(connection);
  }

  Future<void> delete(String id, List<Conection> connections){
    return dataSource.delete(id);
  }

  Future<List<Conection>> load() {
     return dataSource.load();
  }

}