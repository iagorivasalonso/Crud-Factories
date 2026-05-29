import 'package:crud_factories/Objects/Conection.dart';
import 'package:mysql1/mysql1.dart' show MySqlConnection;

abstract class IConnectionSesionService {

  Future<MySqlConnection> connect(Conection c);

  Future<bool> disconnect(Conection c);

}