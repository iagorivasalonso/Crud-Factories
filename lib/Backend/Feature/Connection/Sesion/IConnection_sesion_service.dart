import 'package:crud_factories/Backend/Feature/Connection/Controller/ConnectionController.dart' show DisconnectResponse;
import 'package:crud_factories/Backend/Feature/Connection/ExecuteQuery/IexecuteQuery.dart' show Iexecutequery;
import 'package:crud_factories/Objects/Conection.dart';
import 'package:mysql1/mysql1.dart' show MySqlConnection;

abstract class IConnectionSesionService {

  Future<void> connect(Conection c);

  Future<DisconnectResponse> disconnect();

  Iexecutequery get executeQuery;
}