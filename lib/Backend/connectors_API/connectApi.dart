

import 'package:crud_factories/Backend/connectors_API/ApiConfigUrl.dart' show ApiConfigUrl;
import 'package:crud_factories/Objects/ApiConfig.dart' show ApiConfig;


Future<Uri> connectApi(
    String nameTable,
    ApiConfig config, {
      String? userId,
    }) async {
  return Uri.parse('${ApiConfigUrl.baseUrl}/db/${config.database}/$nameTable')
      .replace(
    queryParameters: {
      'host': config.host,
      'port': config.port.toString(),
      'user': config.user,
      'password': config.password,
      if (userId != null) 'user_id': userId,
    },
  );
}


