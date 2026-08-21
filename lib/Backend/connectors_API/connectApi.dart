

import 'package:crud_factories/Objects/ApiConfig.dart' show ApiConfig;


Future<Uri> connectApi(String nameTable, ApiConfig config) async {
  return Uri(
    scheme: 'https',
    host: 'crud-factories.onrender.com',
    path: '/db/${config.database}/$nameTable',
    queryParameters: {
      'host': config.host,
      'port': config.port,
      'user': config.user,
      'password': config.password,
    },
  );
}
