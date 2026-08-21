

import 'package:crud_factories/Backend/core/service/Cryptoservice.dart';
import 'package:crud_factories/Objects/Conection.dart';
import '../Feature/Connection/Datasource/IConnection_repository.dart';

class ConnectionRepository {

  final IConnectionDataSource  dataSource;

  ConnectionRepository(this.dataSource);

  Future<void> save( Conection connection){

      final encriptedConection = Conection(
          id: connection.id,
          database: connection.database,
          port: connection.port,
          host: connection.host,
          user: connection.user,
          password: CryptoService.encrypt(connection.password)
      );

     return dataSource.save(encriptedConection);
  }

  Future<void> delete(String id){

    return dataSource.delete(id);
  }

  Future<List<Conection>> load() async {

    final connections = await dataSource.load();

    return connections.map((connection) {
      return Conection(
        id: connection.id,
        database: connection.database,
        port: connection.port,
        host: connection.host,
        user: connection.user,
        password: CryptoService.decrypt(connection.password),
      );
    }).toList();
  }
  Future<void> saveAll(List<Conection>connections) async {

    final encryptedConnections = connections.map((connection) {

      return Conection(
        id: connection.id,
        database: connection.database,
        port: connection.port,
        host: connection.host,
        user: connection.user,
        password: CryptoService.encrypt(connection.password),
      );

    }).toList();

    return dataSource.saveAll(encryptedConnections);
  }

}
