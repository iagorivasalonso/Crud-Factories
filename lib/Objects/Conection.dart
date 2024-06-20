
class Conection {

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

  @override
  String toString() {
    return 'Conection{database: $database, host: $host, port: $port, user: $user, password: $password}';
  }
}