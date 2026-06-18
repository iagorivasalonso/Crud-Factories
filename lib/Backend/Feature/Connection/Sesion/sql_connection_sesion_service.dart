import 'package:crud_factories/Backend/Feature/Connection/Controller/ConnectionController.dart' show DisconnectResponse;
import 'package:crud_factories/Backend/Feature/Connection/ExecuteQuery/IexecuteQuery.dart' show Iexecutequery;
import 'package:crud_factories/Backend/Feature/Connection/ExecuteQuery/sqlExecuteQuery.dart';
import 'package:crud_factories/Backend/Feature/Connection/Sesion/IConnection_sesion_service.dart';

import 'package:crud_factories/Objects/Conection.dart';
import 'package:mysql1/mysql1.dart';

class SqlConnectionSessionService implements IConnectionSesionService {

  MySqlConnection? _connection;
  Iexecutequery? _executeQuery;

  Conection? _active;

  @override
  Future<void> connect(Conection c) async {


    _active = c;

    _connection = await MySqlConnection.connect(
      ConnectionSettings(
        host: c.host,
        port: int.parse(c.port),
        user: c.user,
        password: c.password,
        db: c.database,
      ),
    );

    _executeQuery = sqlExecuteQuery(_connection!);
  }

  @override
  Iexecutequery get executeQuery {
    final q = _executeQuery;
    if (q == null) {
      throw Exception("Session not connected");
    }
    return q;
  }

  @override
  Future<DisconnectResponse> disconnect() async {
    final wasConnected = _connection != null;

    try {
      await _connection?.close();

      return DisconnectResponse(
        ok: true,
        message: wasConnected
            ? "Disconnected successfully"
            : "There was no active connection",
      );

    } catch (e) {
      return DisconnectResponse(
        ok: false,
        message: e.toString(),
      );

    } finally {
      _connection = null;
      _executeQuery = null;
      _active = null;
    }
  }
}