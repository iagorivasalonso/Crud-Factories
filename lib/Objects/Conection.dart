
import 'package:crud_factories/Frontend/importData.dart';

class Conection extends BaseEntity {

  String id;
  String database;
  String host;
  String port;
  String user;
  String password;

  Conection({
    required this.id,
    required this.database,
    required this.port,
    required this.host,
    required this.user,
    required this.password
});

  Map<String, dynamic> toJson() => {
    'host': host,
    'port': port,
    'user': user,
    'password': password,
    'database': database,
  };
}
