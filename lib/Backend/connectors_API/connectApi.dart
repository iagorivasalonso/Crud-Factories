


import 'package:crud_factories/Backend/Feature/Sector/apiSectorDataSource%20.dart' show ApiConfig;

Future<Uri> connectApi(String nameTable, ApiConfig config) async {

  return Uri(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: 'db/${config.database}/$nameTable',
    queryParameters: {
      'host': config.host,
      'port': config.port,
      'user': config.user,
      'password': config.password,
    },
  );
}
