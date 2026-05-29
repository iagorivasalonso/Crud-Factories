import 'package:crud_factories/Backend/Feature/Connection/Sesion/IConnection_sesion_service.dart';
import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Objects/Conection.dart';
import 'package:mysql1/mysql1.dart';

class SqlConnectionSessionService implements IConnectionSesionService{

  @override
  Future<MySqlConnection> connect(Conection c) async {

    try {

      final settings = ConnectionSettings(
        host: c.host,
        port: int.parse(c.port),
        user: c.user,
        password: c.password,
        db: c.database,
      );

      executeQuery = await MySqlConnection.connect(settings);

      return executeQuery;

    } catch (e) {
      rethrow; // 👈 IMPORTANTÍSIMO
    }
  }

  @override
  Future<bool> disconnect(Conection c) async {

    await executeQuery?.close();

    return true;
  }

}